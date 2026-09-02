import {
    type DocumentData,
    type QueryConstraint,
    type QueryDocumentSnapshot,
    Timestamp,
    collection,
    doc,
    getDoc,
    getDocs,
    limit,
    orderBy,
    query,
    serverTimestamp,
    startAfter,
    updateDoc,
    where,
    setDoc,
} from "firebase/firestore";
import { db } from "~/config/firebase";

export type InviteRecord = {
    id: string;
    code: string;
    role?: string;
    used?: boolean;
    expiresAt?: Timestamp;
};

export type AppUserProfile = {
    id: string;
    uid: string;
    email: string;
    displayName: string;
    role: string;
    createdAt: Date | null;
    status: string;
    avatarUrl: string;
};

export type RefereeRecord = {
    id: string;
    createdAt: Date | null;
    lastCommissionAt: Date | null;
    lastEventType: string;
    lastPaymentId: string;
    refereeUserId: string;
    referralCode: string;
    totalCommission: number | null;
    totalPayments: number | null;
    updatedAt: Date | null;
    userId: string;
};

export type CommissionRecord = {
    id: string;
    commission: number | null;
    createdAt: Date | null;
    currency: string;
    date: Date | null;
    paymentId: string;
    totalAmount: number | null;
    type: string;
    userId: string;
};

export type CommissionCursor = QueryDocumentSnapshot<DocumentData>;

const usersCollectionName =
    import.meta.env.VITE_FIREBASE_USERS_COLLECTION ?? "users";
const invitesCollectionName =
    import.meta.env.VITE_FIREBASE_INVITES_COLLECTION ?? "invites";
const refereesCollectionName = "referees";
const commissionsCollectionName = "commissions";

const toDate = (value: unknown): Date | null => {
    if (value instanceof Timestamp) {
        return value.toDate();
    }

    if (value instanceof Date) {
        return value;
    }

    return null;
};

const toStringValue = (value: unknown, fallback = "") => {
    if (typeof value === "string") {
        return value;
    }

    return fallback;
};

const toNumberValue = (value: unknown): number | null => {
    if (typeof value === "number" && Number.isFinite(value)) {
        return value;
    }

    return null;
};

const findUserByEmailQuery = async (email: string) => {
    const normalizedEmail = email.trim();

    if (!normalizedEmail) {
        return null;
    }

    const userQueries = [
        query(
            collection(db, usersCollectionName),
            where("userEmail", "==", normalizedEmail),
            limit(1),
        ),
        query(
            collection(db, usersCollectionName),
            where("email", "==", normalizedEmail),
            limit(1),
        ),
    ];

    const lowerCaseEmail = normalizedEmail.toLowerCase();
    if (lowerCaseEmail !== normalizedEmail) {
        userQueries.push(
            query(
                collection(db, usersCollectionName),
                where("userEmail", "==", lowerCaseEmail),
                limit(1),
            ),
            query(
                collection(db, usersCollectionName),
                where("email", "==", lowerCaseEmail),
                limit(1),
            ),
        );
    }

    for (const userQuery of userQueries) {
        const userSnap = await getDocs(userQuery);
        if (!userSnap.empty) {
            const match = userSnap.docs[0];
            return normalizeUserProfile(match.id, match.data());
        }
    }

    return null;
};

const normalizeRefereeRecord = (
    docId: string,
    data: Record<string, unknown>,
): RefereeRecord => {
    return {
        id: docId,
        createdAt: toDate(data.createdAt),
        lastCommissionAt: toDate(data.lastCommissionAt),
        lastEventType: toStringValue(data.lastEventType),
        lastPaymentId: toStringValue(data.lastPaymentId),
        refereeUserId: toStringValue(data.refereeUserId),
        referralCode: toStringValue(data.referralCode),
        totalCommission: toNumberValue(data.totalCommission),
        totalPayments: toNumberValue(data.totalPayments),
        updatedAt: toDate(data.updatedAt),
        userId: toStringValue(data.userId),
    };
};

const normalizeCommissionRecord = (
    docId: string,
    data: Record<string, unknown>,
): CommissionRecord => {
    return {
        id: docId,
        commission: toNumberValue(data.commission),
        createdAt: toDate(data.createdAt),
        currency: toStringValue(data.currency, "USD"),
        date: toDate(data.date),
        paymentId: toStringValue(data.paymentId),
        totalAmount: toNumberValue(data.totalAmount),
        type: toStringValue(data.type),
        userId: toStringValue(data.userId),
    };
};

const uniqueNonEmpty = (values: Array<string | null | undefined>) => {
    const seen = new Set<string>();
    const result: string[] = [];

    for (const value of values) {
        const normalized = (value ?? "").trim();
        if (!normalized || seen.has(normalized)) {
            continue;
        }

        seen.add(normalized);
        result.push(normalized);
    }

    return result;
};

export const isRoleAdmin = (role: string | undefined | null) => {
    return (role ?? "").trim().toLowerCase() === "admin";
};

const normalizeUserProfile = (
    docId: string,
    data: Record<string, unknown>,
): AppUserProfile => {
    const uid = (data.uid as string | undefined) ?? docId;
    const email =
        (data.userEmail as string | undefined) ??
        (data.email as string | undefined) ??
        "";
    const displayName =
        (data.userName as string | undefined) ??
        (data.displayName as string | undefined) ??
        "";
    const role = ((data.role as string | undefined) ?? "user").trim().toLowerCase();
    const status = (data.status as string | undefined) ?? "active";
    const avatarUrl =
        (data.userAvatar as string | undefined) ??
        (data.avatarUrl as string | undefined) ??
        "";

    return {
        id: docId,
        uid,
        email,
        displayName,
        role,
        createdAt: toDate(data.createdAt),
        status,
        avatarUrl,
    };
};

export const fetchExistingUserProfile = async ({
    uid,
    email,
}: {
    uid: string;
    email: string | null;
}): Promise<AppUserProfile | null> => {
    const byIdRef = doc(db, usersCollectionName, uid);
    const byIdSnap = await getDoc(byIdRef);
    if (byIdSnap.exists()) {
        return normalizeUserProfile(byIdSnap.id, byIdSnap.data());
    }

    const byUidQuery = query(
        collection(db, usersCollectionName),
        where("uid", "==", uid),
        limit(1),
    );
    const byUidSnap = await getDocs(byUidQuery);
    if (!byUidSnap.empty) {
        const match = byUidSnap.docs[0];
        return normalizeUserProfile(match.id, match.data());
    }

    if (email) {
        const match = await findUserByEmailQuery(email);
        if (match) {
            return match;
        }
    }

    return null;
};

export const fetchUserByEmail = async (
    email: string,
): Promise<AppUserProfile | null> => {
    return findUserByEmailQuery(email);
};

export const fetchRefereesForEmail = async (
    email: string,
): Promise<
    | {
        user: AppUserProfile;
        referees: RefereeRecord[];
    }
    | null
> => {
    const user = await fetchUserByEmail(email);
    if (!user) {
        return null;
    }

    const refereesSnap = await getDocs(
        collection(db, usersCollectionName, user.id, refereesCollectionName),
    );

    const referees = refereesSnap.docs
        .map((refereeDoc) => normalizeRefereeRecord(refereeDoc.id, refereeDoc.data()))
        .sort((left, right) => {
            const leftTime =
                left.lastCommissionAt?.getTime() ?? left.updatedAt?.getTime() ?? 0;
            const rightTime =
                right.lastCommissionAt?.getTime() ?? right.updatedAt?.getTime() ?? 0;

            return rightTime - leftTime;
        });

    return {
        user,
        referees,
    };
};

export const fetchCommissionDataForEmail = async ({
    email,
    loggedInUserIds,
    pageSize = 25,
    cursor = null,
    requestUserId,
    startDate = null,
    endDate = null,
}: {
    email: string;
    loggedInUserIds: string[];
    pageSize?: number;
    cursor?: CommissionCursor | null;
    requestUserId?: string | null;
    startDate?: Date | null;
    endDate?: Date | null;
}): Promise<
    | {
        user: AppUserProfile;
        commissions: CommissionRecord[];
        hasMore: boolean;
        nextCursor: CommissionCursor | null;
        requestUserId: string | null;
    }
    | null
> => {
    const user = await fetchUserByEmail(email);
    if (!user) {
        return null;
    }

    const requestUserIds = requestUserId
        ? uniqueNonEmpty([requestUserId])
        : uniqueNonEmpty([user.uid, user.id]);

    const toStartOfDay = (value: Date | null) => {
        if (!value) {
            return null;
        }

        return new Date(
            value.getFullYear(),
            value.getMonth(),
            value.getDate(),
            0,
            0,
            0,
            0,
        );
    };

    const toEndOfDay = (value: Date | null) => {
        if (!value) {
            return null;
        }

        return new Date(
            value.getFullYear(),
            value.getMonth(),
            value.getDate(),
            23,
            59,
            59,
            999,
        );
    };

    const normalizedStartDate = toStartOfDay(startDate);
    const normalizedEndDate = toEndOfDay(endDate);

    let matchedRequestUserId: string | null = requestUserIds[0] ?? null;
    let commissions: CommissionRecord[] = [];
    let hasMore = false;
    let nextCursor: CommissionCursor | null = null;

    for (const candidateRequestUserId of requestUserIds) {
        const constraints: QueryConstraint[] = [
            orderBy("createdAt", "desc"),
            limit(Math.max(pageSize, 1) + 1),
        ];

        if (normalizedStartDate) {
            constraints.unshift(
                where("createdAt", ">=", Timestamp.fromDate(normalizedStartDate)),
            );
        }

        if (normalizedEndDate) {
            constraints.unshift(
                where("createdAt", "<=", Timestamp.fromDate(normalizedEndDate)),
            );
        }

        if (cursor) {
            constraints.push(startAfter(cursor));
        }

        const commissionsSnap = await getDocs(
            query(
                collection(
                    db,
                    usersCollectionName,
                    candidateRequestUserId,
                    commissionsCollectionName,
                ),
                ...constraints,
            ),
        );

        const pageDocs = commissionsSnap.docs.slice(0, Math.max(pageSize, 1));
        const records = pageDocs
            .map((commissionDoc) =>
                normalizeCommissionRecord(commissionDoc.id, commissionDoc.data()),
            )
            .sort((left, right) => {
                const leftTime =
                    left.date?.getTime() ?? left.createdAt?.getTime() ?? 0;
                const rightTime =
                    right.date?.getTime() ?? right.createdAt?.getTime() ?? 0;

                return rightTime - leftTime;
            });

        if (records.length > 0 || requestUserId) {
            matchedRequestUserId = candidateRequestUserId;
            commissions = records;
            hasMore = commissionsSnap.docs.length > Math.max(pageSize, 1);
            nextCursor = pageDocs[pageDocs.length - 1] ?? null;
            break;
        }
    }

    void loggedInUserIds;

    return {
        user,
        commissions,
        hasMore,
        nextCursor,
        requestUserId: matchedRequestUserId,
    };
};

export const validateInviteCode = async (
    inviteCode: string,
): Promise<InviteRecord | null> => {
    const code = inviteCode.trim();
    if (!code) {
        return null;
    }

    const inviteQuery = query(
        collection(db, invitesCollectionName),
        where("code", "==", code),
        where("used", "==", false),
        limit(1),
    );

    const inviteSnap = await getDocs(inviteQuery);
    if (inviteSnap.empty) {
        return null;
    }

    const inviteDoc = inviteSnap.docs[0];
    const inviteData = inviteDoc.data();

    const expiresAt = inviteData.expiresAt as Timestamp | undefined;
    if (expiresAt && expiresAt.toMillis() < Date.now()) {
        return null;
    }

    return {
        id: inviteDoc.id,
        code,
        role: inviteData.role as string | undefined,
        used: inviteData.used as boolean | undefined,
        expiresAt,
    };
};

export const markInviteAsUsed = async (inviteId: string, uid: string) => {
    const inviteRef = doc(db, invitesCollectionName, inviteId);
    await updateDoc(inviteRef, {
        used: true,
        usedBy: uid,
        usedAt: serverTimestamp(),
    });
};

export const createUserFromGoogleLogin = async ({
    uid,
    email,
    displayName,
    photoURL,
    role,
}: {
    uid: string;
    email: string;
    displayName: string;
    photoURL: string;
    role: string;
}) => {
    const userRef = doc(db, usersCollectionName, uid);
    await setDoc(
        userRef,
        {
            uid,
            userEmail: email,
            userName: displayName,
            userAvatar: photoURL,
            role,
            status: "active",
            createdAt: serverTimestamp(),
            updatedAt: serverTimestamp(),
        },
        { merge: true },
    );
};
