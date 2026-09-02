import {
    GoogleAuthProvider,
    signInWithPopup,
    signOut,
    type User,
} from "firebase/auth";
import { auth } from "~/config/firebase";
import {
    createUserFromGoogleLogin,
    fetchExistingUserProfile,
    markInviteAsUsed,
    type AppUserProfile,
    validateInviteCode,
} from "~/lib/firestore";

const googleProvider = new GoogleAuthProvider();
googleProvider.setCustomParameters({ prompt: "select_account" });

export const signInWithGoogle = async (): Promise<AppUserProfile> => {
    const credential = await signInWithPopup(auth, googleProvider);
    const user = credential.user;

    const profile = await fetchExistingUserProfile({
        uid: user.uid,
        email: user.email,
    });

    if (!profile) {
        throw new Error(
            "No profile found for this account. Please sign up using a valid invite code.",
        );
    }

    return profile;
};

export const signUpWithGoogle = async (
    inviteCode: string,
): Promise<AppUserProfile> => {
    const invite = await validateInviteCode(inviteCode);
    if (!invite) {
        throw new Error("Invalid or expired invite code.");
    }

    const credential = await signInWithPopup(auth, googleProvider);
    const user = credential.user;

    const existing = await fetchExistingUserProfile({
        uid: user.uid,
        email: user.email,
    });

    if (!existing) {
        await createUserFromGoogleLogin({
            uid: user.uid,
            email: user.email ?? "",
            displayName: user.displayName ?? "",
            photoURL: user.photoURL ?? "",
            role: (invite.role ?? "user").toLowerCase(),
        });
        await markInviteAsUsed(invite.id, user.uid);
    }

    const profile = await fetchExistingUserProfile({
        uid: user.uid,
        email: user.email,
    });

    if (!profile) {
        throw new Error("Unable to create user profile.");
    }

    return profile;
};

export const logoutUser = async () => {
    await signOut(auth);
};

export const getSafeUserMeta = (user: User | null) => {
    if (!user) {
        return null;
    }

    return {
        uid: user.uid,
        email: user.email,
        name: user.displayName,
    };
};
