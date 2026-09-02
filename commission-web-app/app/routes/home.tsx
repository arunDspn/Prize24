import type { Route } from "./+types/home";
import { useEffect, useMemo, useState, type KeyboardEvent, type FormEvent } from "react";
import { useNavigate } from "react-router";
import ProtectedRoute from "~/components/ProtectedRoute";
import CommissionTab from "~/components/dashboard/CommissionTab";
import OverviewTab from "~/components/dashboard/OverviewTab";
import type {
  CommissionDateRange,
  CommissionLookupState,
  CommissionPaginationState,
} from "~/components/dashboard/commission-types";
import { useAuth } from "~/hooks/useAuth";
import {
  type CommissionCursor,
  fetchExistingUserProfile,
  fetchCommissionDataForEmail,
  type AppUserProfile,
  type CommissionRecord,
} from "~/lib/firestore";

type DashboardTab = "overview" | "commission";

const indiaDateTimeFormatter = new Intl.DateTimeFormat("en-IN", {
  dateStyle: "medium",
  timeStyle: "short",
  timeZone: "Asia/Kolkata",
});

const monthYearFormatter = new Intl.DateTimeFormat("en-IN", {
  month: "long",
  year: "numeric",
  timeZone: "Asia/Kolkata",
});

const COMMISSION_PAGE_SIZE = 25;

const formatDate = (value: Date | null) => {
  if (!value) {
    return "Not available";
  }

  return indiaDateTimeFormatter.format(value);
};

export function meta({ }: Route.MetaArgs) {
  return [
    { title: "Prize24 Admin Dashboard" },
    { name: "description", content: "Admin-only dashboard access." },
  ];
}

export default function Home() {
  const { profile, currentUser, logout } = useAuth();
  const navigate = useNavigate();
  const [activeTab, setActiveTab] = useState<DashboardTab>("overview");
  const [email, setEmail] = useState(profile?.email ?? "");
  const [lookupState, setLookupState] = useState<CommissionLookupState>({
    status: "idle",
    message: null,
    user: null,
    commissions: [],
  });
  const [selectedCommissionId, setSelectedCommissionId] = useState<string | null>(null);
  const [selectedCommissionUser, setSelectedCommissionUser] = useState<AppUserProfile | null>(null);
  const [dateRange, setDateRange] = useState<CommissionDateRange>({ from: "", to: "" });
  const [pagination, setPagination] = useState<CommissionPaginationState>({
    hasMore: false,
    isLoadingMore: false,
    loadedCount: 0,
  });
  const [nextCursor, setNextCursor] = useState<CommissionCursor | null>(null);
  const [requestUserId, setRequestUserId] = useState<string | null>(null);

  useEffect(() => {
    if (!email && profile?.email) {
      setEmail(profile.email);
    }
  }, [email, profile?.email]);

  const selectedCommission = useMemo(() => {
    if (lookupState.status !== "ready") {
      return null;
    }

    if (!selectedCommissionId) {
      return lookupState.commissions[0] ?? null;
    }

    return lookupState.commissions.find((commission) => commission.id === selectedCommissionId) ?? lookupState.commissions[0] ?? null;
  }, [lookupState, selectedCommissionId]);

  useEffect(() => {
    let isActive = true;

    const loadSelectedCommissionUser = async () => {
      if (!selectedCommission?.userId) {
        setSelectedCommissionUser(null);
        return;
      }

      try {
        const userProfile = await fetchExistingUserProfile({
          uid: selectedCommission.userId,
          email: null,
        });

        if (isActive) {
          setSelectedCommissionUser(userProfile);
        }
      } catch {
        if (isActive) {
          setSelectedCommissionUser(null);
        }
      }
    };

    void loadSelectedCommissionUser();

    return () => {
      isActive = false;
    };
  }, [selectedCommission]);

  const groupedCommissions = useMemo(() => {
    if (lookupState.status !== "ready") {
      return [] as Array<{ monthLabel: string; items: CommissionRecord[] }>;
    }

    const groups = new Map<string, CommissionRecord[]>();

    for (const commission of lookupState.commissions) {
      const sourceDate = commission.date ?? commission.createdAt;
      const monthLabel = sourceDate
        ? monthYearFormatter.format(sourceDate)
        : "No date";

      const existing = groups.get(monthLabel);
      if (existing) {
        existing.push(commission);
      } else {
        groups.set(monthLabel, [commission]);
      }
    }

    return Array.from(groups.entries()).map(([monthLabel, items]) => ({
      monthLabel,
      items,
    }));
  }, [lookupState]);

  const activeSectionLabel = activeTab === "overview" ? "Overview" : "Commission lookup";

  const handleLogout = async () => {
    await logout();
    navigate("/login", { replace: true });
  };

  const parseDateBoundary = (value: string, type: "start" | "end") => {
    const trimmed = value.trim();
    if (!trimmed) {
      return null;
    }

    const date =
      type === "start"
        ? new Date(`${trimmed}T00:00:00`)
        : new Date(`${trimmed}T23:59:59.999`);

    if (Number.isNaN(date.getTime())) {
      return null;
    }

    return date;
  };

  const handleCommissionLookup = async (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault();

    const trimmedEmail = email.trim();
    if (!trimmedEmail) {
      setLookupState({
        status: "error",
        message: "Enter an email address to look up commission records.",
        user: null,
        commissions: [],
      });
      return;
    }

    const startDate = parseDateBoundary(dateRange.from, "start");
    const endDate = parseDateBoundary(dateRange.to, "end");
    if (startDate && endDate && startDate.getTime() > endDate.getTime()) {
      setLookupState({
        status: "error",
        message: "Start date must be before or equal to end date.",
        user: null,
        commissions: [],
      });
      return;
    }

    setLookupState({
      status: "loading",
      message: null,
      user: null,
      commissions: [],
    });
    setPagination({ hasMore: false, isLoadingMore: false, loadedCount: 0 });
    setNextCursor(null);
    setRequestUserId(null);
    setSelectedCommissionId(null);

    try {
      const result = await fetchCommissionDataForEmail({
        email: trimmedEmail,
        loggedInUserIds: [currentUser?.uid, profile?.uid, profile?.id].filter((value): value is string => Boolean(value)),
        pageSize: COMMISSION_PAGE_SIZE,
        startDate,
        endDate,
      });

      if (!result) {
        setLookupState({
          status: "not-found",
          message: `No user document matched ${trimmedEmail}.`,
          user: null,
          commissions: [],
        });
        return;
      }

      if (result.commissions.length === 0) {
        setLookupState({
          status: "empty",
          message: `User ${result.user.email || trimmedEmail} exists, but there are no commission records for the selected date range.`,
          user: result.user,
          commissions: [],
        });
        setPagination({ hasMore: false, isLoadingMore: false, loadedCount: 0 });
        setNextCursor(null);
        setRequestUserId(result.requestUserId);
        return;
      }

      setLookupState({
        status: "ready",
        message: null,
        user: result.user,
        commissions: result.commissions,
      });
      setPagination({
        hasMore: result.hasMore,
        isLoadingMore: false,
        loadedCount: result.commissions.length,
      });
      setNextCursor(result.nextCursor);
      setRequestUserId(result.requestUserId);
      setSelectedCommissionId(result.commissions[0]?.id ?? null);
    } catch (lookupError) {
      setLookupState({
        status: "error",
        message:
          lookupError instanceof Error
            ? lookupError.message
            : "Failed to load commission records.",
        user: null,
        commissions: [],
      });
      setPagination({ hasMore: false, isLoadingMore: false, loadedCount: 0 });
      setNextCursor(null);
      setRequestUserId(null);
    }
  };

  const handleLoadMore = async () => {
    if (
      lookupState.status !== "ready" ||
      pagination.isLoadingMore ||
      !pagination.hasMore ||
      !nextCursor ||
      !requestUserId
    ) {
      return;
    }

    setPagination((previous) => ({ ...previous, isLoadingMore: true }));

    try {
      const startDate = parseDateBoundary(dateRange.from, "start");
      const endDate = parseDateBoundary(dateRange.to, "end");
      const result = await fetchCommissionDataForEmail({
        email: email.trim(),
        loggedInUserIds: [currentUser?.uid, profile?.uid, profile?.id].filter((value): value is string => Boolean(value)),
        pageSize: COMMISSION_PAGE_SIZE,
        startDate,
        endDate,
        requestUserId,
        cursor: nextCursor,
      });

      if (!result) {
        setLookupState({
          status: "error",
          message: "Unable to load more commission records right now.",
          user: null,
          commissions: [],
        });
        setPagination({ hasMore: false, isLoadingMore: false, loadedCount: 0 });
        setNextCursor(null);
        setRequestUserId(null);
        return;
      }

      const existingCommissions = lookupState.commissions;
      const seenIds = new Set(existingCommissions.map((commission) => commission.id));
      const appendedCommissions = result.commissions.filter(
        (commission) => !seenIds.has(commission.id),
      );
      const mergedCommissions = [...existingCommissions, ...appendedCommissions];

      setLookupState({
        status: "ready",
        message: null,
        user: lookupState.user,
        commissions: mergedCommissions,
      });
      setPagination({
        hasMore: result.hasMore,
        isLoadingMore: false,
        loadedCount: mergedCommissions.length,
      });
      setNextCursor(result.nextCursor);
    } catch {
      setPagination((previous) => ({ ...previous, isLoadingMore: false }));
      setLookupState({
        status: "error",
        message: "Failed to load more commission records.",
        user: null,
        commissions: [],
      });
    }
  };

  const handleRowKeyDown = (
    event: KeyboardEvent<HTMLDivElement>,
    commissionId: string,
  ) => {
    if (event.key === "Enter" || event.key === " ") {
      event.preventDefault();
      setSelectedCommissionId(commissionId);
    }
  };

  return (
    <ProtectedRoute>
      <div className="p24-shell min-h-screen px-4 py-6 sm:px-6 lg:px-8 xl:px-10">
        <div className="p24-dashboard-frame space-y-6 xl:space-y-8">
          <header className="p24-card flex flex-col gap-6 px-6 py-6 shadow-sm sm:px-7 lg:px-8 xl:flex-row xl:items-start xl:justify-between">
            <div>
              <p className="text-xs font-semibold uppercase tracking-[0.16em] text-slate-500">
                Prize24 secure zone
              </p>
              <h1 className="mt-1 text-2xl font-extrabold tracking-tight text-slate-900">
                Admin Dashboard
              </h1>
              <p className="mt-2 text-sm text-slate-600">
                Signed in as <span className="font-semibold">{profile?.email}</span>
              </p>
            </div>
            <div className="flex flex-col gap-3 sm:flex-row sm:items-center">
              <div className="rounded-2xl border border-slate-200 bg-slate-50 px-4 py-3">
                <p className="text-xs font-semibold uppercase tracking-[0.14em] text-slate-500">
                  Active section
                </p>
                <p className="mt-1 text-sm font-semibold text-slate-900">{activeSectionLabel}</p>
              </div>
              <button
                type="button"
                onClick={handleLogout}
                className="p24-button-gradient rounded-xl px-5 py-2.5 text-sm font-semibold shadow-sm transition"
              >
                Logout
              </button>
            </div>
          </header>

          <div className="p24-card p-2">
            <div className="flex gap-2">
              <button
                type="button"
                onClick={() => setActiveTab("overview")}
                className={`rounded-xl px-4 py-2 text-sm font-semibold transition ${activeTab === "overview"
                  ? "bg-slate-900 text-white shadow-sm"
                  : "bg-white text-slate-600 hover:bg-slate-100"
                  }`}
              >
                Overview
              </button>
              <button
                type="button"
                onClick={() => setActiveTab("commission")}
                className={`rounded-xl px-4 py-2 text-sm font-semibold transition ${activeTab === "commission"
                  ? "bg-slate-900 text-white shadow-sm"
                  : "bg-white text-slate-600 hover:bg-slate-100"
                  }`}
              >
                Commission
              </button>
            </div>
          </div>

          {activeTab === "overview" ? (
            <OverviewTab profile={profile} />
          ) : (
            <CommissionTab
              email={email}
              dateRange={dateRange}
              pagination={pagination}
              lookupState={lookupState}
              groupedCommissions={groupedCommissions}
              selectedCommission={selectedCommission}
              selectedCommissionUser={selectedCommissionUser}
              onEmailChange={setEmail}
              onDateRangeChange={setDateRange}
              onSubmit={handleCommissionLookup}
              onLoadMore={handleLoadMore}
              onSelectCommission={setSelectedCommissionId}
              onCommissionRowKeyDown={handleRowKeyDown}
            />
          )}
        </div>
      </div>
    </ProtectedRoute>
  );
}
