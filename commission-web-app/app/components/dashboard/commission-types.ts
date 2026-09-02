import type { AppUserProfile, CommissionRecord } from "~/lib/firestore";

export type CommissionDateRange = {
    from: string;
    to: string;
};

export type CommissionPaginationState = {
    hasMore: boolean;
    isLoadingMore: boolean;
    loadedCount: number;
};

export type CommissionLookupState =
    | { status: "idle"; message: string | null; user: AppUserProfile | null; commissions: CommissionRecord[] }
    | { status: "loading"; message: string | null; user: AppUserProfile | null; commissions: CommissionRecord[] }
    | { status: "not-found"; message: string; user: null; commissions: [] }
    | { status: "empty"; message: string; user: AppUserProfile; commissions: [] }
    | { status: "ready"; message: string | null; user: AppUserProfile; commissions: CommissionRecord[] }
    | { status: "error"; message: string; user: null; commissions: [] };

export type CommissionGroup = {
    monthLabel: string;
    items: CommissionRecord[];
};