import type { KeyboardEvent, FormEvent } from "react";
import type { AppUserProfile, CommissionRecord } from "~/lib/firestore";
import type {
    CommissionDateRange,
    CommissionGroup,
    CommissionLookupState,
    CommissionPaginationState,
} from "./commission-types";
import { formatCommission, formatDate, typeToneClasses } from "./commission-utils";

type CommissionTabProps = {
    email: string;
    dateRange: CommissionDateRange;
    pagination: CommissionPaginationState;
    lookupState: CommissionLookupState;
    groupedCommissions: CommissionGroup[];
    selectedCommission: CommissionRecord | null;
    selectedCommissionUser: AppUserProfile | null;
    onEmailChange: (value: string) => void;
    onDateRangeChange: (value: CommissionDateRange) => void;
    onSubmit: (event: FormEvent<HTMLFormElement>) => void;
    onLoadMore: () => void;
    onSelectCommission: (commissionId: string) => void;
    onCommissionRowKeyDown: (event: KeyboardEvent<HTMLDivElement>, commissionId: string) => void;
};

export default function CommissionTab({
    email,
    dateRange,
    pagination,
    lookupState,
    groupedCommissions,
    selectedCommission,
    selectedCommissionUser,
    onEmailChange,
    onDateRangeChange,
    onSubmit,
    onLoadMore,
    onSelectCommission,
    onCommissionRowKeyDown,
}: CommissionTabProps) {
    const selectedIndex = selectedCommission
        ? groupedCommissions.flatMap((group) => group.items).findIndex((commission) => commission.id === selectedCommission.id)
        : -1;
    const selectedPosition = selectedIndex >= 0 ? selectedIndex + 1 : 0;
    const lookupStatusLabel =
        lookupState.status === "ready"
            ? "Ready"
            : lookupState.status === "loading"
                ? "Searching"
                : lookupState.status === "empty"
                    ? "Empty"
                    : lookupState.status === "not-found"
                        ? "No match"
                        : lookupState.status === "error"
                            ? "Error"
                            : "Idle";

    return (
        <section className="space-y-4">
            <div className="p24-card px-6 py-5 lg:px-7 lg:py-6">
                <div>
                    <p className="text-xs font-semibold uppercase tracking-[0.16em] text-slate-500">
                        Commission lookup
                    </p>
                    <h2 className="mt-2 text-2xl font-extrabold tracking-tight text-slate-900">
                        Search commission transactions
                    </h2>
                    <p className="mt-2 text-sm text-slate-600">
                        Enter an email and optional date range to review transaction records.
                    </p>
                </div>

                <form onSubmit={onSubmit} className="mt-6 grid gap-3 xl:grid-cols-[minmax(0,1.4fr)_repeat(2,minmax(180px,0.8fr))_auto]">
                    <label>
                        <span className="mb-2 block text-sm font-semibold text-slate-700">Email address</span>
                        <input
                            type="email"
                            value={email}
                            onChange={(event) => onEmailChange(event.target.value)}
                            placeholder="admin@example.com"
                            className="w-full rounded-xl border border-slate-300 bg-white px-4 py-3 text-sm text-slate-900 shadow-sm outline-none transition placeholder:text-slate-400 focus:border-slate-500 focus:ring-2 focus:ring-slate-200"
                        />
                    </label>
                    <label>
                        <span className="mb-2 block text-sm font-semibold text-slate-700">From</span>
                        <input
                            type="date"
                            value={dateRange.from}
                            onChange={(event) =>
                                onDateRangeChange({
                                    ...dateRange,
                                    from: event.target.value,
                                })
                            }
                            className="w-full rounded-xl border border-slate-300 bg-white px-4 py-3 text-sm text-slate-900 shadow-sm outline-none transition focus:border-slate-500 focus:ring-2 focus:ring-slate-200"
                        />
                    </label>
                    <label>
                        <span className="mb-2 block text-sm font-semibold text-slate-700">To</span>
                        <input
                            type="date"
                            value={dateRange.to}
                            onChange={(event) =>
                                onDateRangeChange({
                                    ...dateRange,
                                    to: event.target.value,
                                })
                            }
                            className="w-full rounded-xl border border-slate-300 bg-white px-4 py-3 text-sm text-slate-900 shadow-sm outline-none transition focus:border-slate-500 focus:ring-2 focus:ring-slate-200"
                        />
                    </label>
                    <button
                        type="submit"
                        disabled={lookupState.status === "loading" || !email.trim()}
                        className="p24-button-gradient h-[46px] self-end rounded-xl px-5 py-3 text-sm font-semibold shadow-sm transition disabled:cursor-not-allowed disabled:opacity-60"
                    >
                        {lookupState.status === "loading" ? "Searching..." : "Search"}
                    </button>
                </form>

                {lookupState.status === "error" && lookupState.message ? (
                    <div className="mt-4 rounded-xl border border-orange-200 bg-orange-50 px-4 py-3 text-sm text-orange-800">
                        {lookupState.message}
                    </div>
                ) : null}
            </div>

            <div className="grid gap-4 xl:grid-cols-[minmax(0,1.95fr)_minmax(360px,0.95fr)]">
                <section className="p24-card overflow-hidden">
                    <div className="flex items-center justify-between border-b border-slate-200 px-6 py-4">
                        <div>
                            <h3 className="text-lg font-bold text-slate-900">Commission items</h3>
                            <p className="text-sm text-slate-600">
                                {lookupState.status === "ready"
                                    ? `${pagination.loadedCount} item${pagination.loadedCount === 1 ? "" : "s"} loaded for ${lookupState.user.email}`
                                    : "Awaiting a commission lookup"}
                            </p>
                        </div>
                        <div className="flex flex-wrap justify-end gap-2">
                            <span className="rounded-full bg-slate-100 px-3 py-1 text-xs font-semibold uppercase tracking-[0.12em] text-slate-600">
                                {lookupStatusLabel}
                            </span>
                            {lookupState.status === "ready" ? (
                                <>
                                    <span className="rounded-full bg-slate-100 px-3 py-1 text-xs font-semibold uppercase tracking-[0.12em] text-slate-600">
                                        Selected {selectedPosition || "None"}
                                    </span>
                                    <span className="rounded-full bg-slate-100 px-3 py-1 text-xs font-semibold uppercase tracking-[0.12em] text-slate-600">
                                        {pagination.hasMore ? "More available" : "End of results"}
                                    </span>
                                </>
                            ) : null}
                        </div>
                    </div>

                    {lookupState.status === "idle" || lookupState.status === "loading" ? (
                        <div className="px-6 py-10 text-center text-sm text-slate-500">
                            {lookupState.status === "loading" ? "Loading commission records..." : "Search by email to display commission data."}
                        </div>
                    ) : null}

                    {lookupState.status === "not-found" ? (
                        <div className="px-6 py-10 text-center">
                            <p className="text-lg font-bold text-slate-900">No matching user found</p>
                            <p className="mt-2 text-sm text-slate-600">{lookupState.message}</p>
                        </div>
                    ) : null}

                    {lookupState.status === "empty" ? (
                        <div className="px-6 py-10 text-center">
                            <p className="text-lg font-bold text-slate-900">No commission items yet</p>
                            <p className="mt-2 text-sm text-slate-600">{lookupState.message}</p>
                        </div>
                    ) : null}

                    {lookupState.status === "ready" ? (
                        <div className="overflow-x-auto">
                            <div className="divide-y divide-slate-100 bg-white">
                                {groupedCommissions.map((group) => (
                                    <div key={group.monthLabel}>
                                        <div className="bg-slate-50 px-6 py-3 text-xs font-semibold uppercase tracking-[0.12em] text-slate-600">
                                            {group.monthLabel}
                                        </div>
                                        {group.items.map((commission) => {
                                            const isSelected = selectedCommission?.id === commission.id;
                                            const toneClass = typeToneClasses[commission.type.toUpperCase()] ?? "bg-slate-100 text-slate-700 ring-slate-200";

                                            return (
                                                <div
                                                    key={commission.id}
                                                    role="button"
                                                    tabIndex={0}
                                                    onClick={() => onSelectCommission(commission.id)}
                                                    onKeyDown={(event) => onCommissionRowKeyDown(event, commission.id)}
                                                    className={`grid cursor-pointer gap-3 border-t border-slate-100 px-6 py-4 transition hover:bg-slate-50 md:grid-cols-[1.2fr_1.3fr_auto_auto] ${isSelected ? "bg-slate-50" : "bg-white"}`}
                                                >
                                                    <div>
                                                        <div className="text-xs font-semibold uppercase tracking-[0.12em] text-slate-500">Date</div>
                                                        <div className="mt-1 font-semibold text-slate-900">{formatDate(commission.date ?? commission.createdAt)}</div>
                                                    </div>
                                                    <div>
                                                        <div className="text-xs font-semibold uppercase tracking-[0.12em] text-slate-500">Payment ID</div>
                                                        <div className="mt-1 break-all font-semibold text-slate-900">{commission.paymentId || "—"}</div>
                                                        <div className="mt-1 text-xs text-slate-500">Doc {commission.id}</div>
                                                    </div>
                                                    <div className="md:text-right">
                                                        <div className="text-xs font-semibold uppercase tracking-[0.12em] text-slate-500">Commission</div>
                                                        <div className="mt-1 font-semibold text-slate-900">{formatCommission(commission.commission, commission.currency)}</div>
                                                        <div className="mt-1 text-xs text-slate-500">Total {formatCommission(commission.totalAmount, commission.currency)}</div>
                                                    </div>
                                                    <div className="md:text-right">
                                                        <div className="text-xs font-semibold uppercase tracking-[0.12em] text-slate-500">Type</div>
                                                        <span className={`mt-1 inline-flex rounded-full px-2.5 py-1 text-xs font-semibold ring-1 ring-inset ${toneClass}`}>
                                                            {commission.type || "Unknown"}
                                                        </span>
                                                    </div>
                                                </div>
                                            );
                                        })}
                                    </div>
                                ))}
                            </div>
                            <div className="border-t border-slate-200 px-6 py-4">
                                <button
                                    type="button"
                                    onClick={onLoadMore}
                                    disabled={!pagination.hasMore || pagination.isLoadingMore}
                                    className="w-full rounded-xl border border-slate-300 bg-white px-4 py-2.5 text-sm font-semibold text-slate-700 transition hover:bg-slate-50 disabled:cursor-not-allowed disabled:opacity-60"
                                >
                                    {pagination.isLoadingMore
                                        ? "Loading more..."
                                        : pagination.hasMore
                                            ? "Load more"
                                            : "No more records"}
                                </button>
                            </div>
                        </div>
                    ) : null}
                </section>

                <aside className="space-y-4 xl:sticky xl:top-6">
                    <section className="p24-card p-6 shadow-sm">
                        <p className="text-xs font-semibold uppercase tracking-[0.16em] text-slate-500">
                            Selected commission item
                        </p>

                        {lookupState.status === "ready" && selectedCommission ? (
                            <div className="mt-4 space-y-3 text-sm">
                                <div className="rounded-xl bg-slate-50 px-4 py-3">
                                    <div className="text-xs font-semibold uppercase tracking-[0.12em] text-slate-500">User name</div>
                                    <div className="mt-1 font-semibold text-slate-900">
                                        {selectedCommissionUser?.displayName || selectedCommissionUser?.email || "Not available"}
                                    </div>
                                </div>
                                <div className="rounded-xl bg-slate-50 px-4 py-3">
                                    <div className="text-xs font-semibold uppercase tracking-[0.12em] text-slate-500">Payment ID</div>
                                    <div className="mt-1 break-all font-semibold text-slate-900">{selectedCommission.paymentId || "Not available"}</div>
                                </div>
                                <div className="grid gap-3 sm:grid-cols-2">
                                    <div className="rounded-xl bg-slate-50 px-4 py-3">
                                        <div className="text-xs font-semibold uppercase tracking-[0.12em] text-slate-500">Commission</div>
                                        <div className="mt-1 font-medium text-slate-900">{formatCommission(selectedCommission.commission, selectedCommission.currency)}</div>
                                    </div>
                                    <div className="rounded-xl bg-slate-50 px-4 py-3">
                                        <div className="text-xs font-semibold uppercase tracking-[0.12em] text-slate-500">Total amount</div>
                                        <div className="mt-1 font-medium text-slate-900">{formatCommission(selectedCommission.totalAmount, selectedCommission.currency)}</div>
                                    </div>
                                    <div className="rounded-xl bg-slate-50 px-4 py-3">
                                        <div className="text-xs font-semibold uppercase tracking-[0.12em] text-slate-500">Currency</div>
                                        <div className="mt-1 font-medium text-slate-900">{selectedCommission.currency || "Not available"}</div>
                                    </div>
                                    <div className="rounded-xl bg-slate-50 px-4 py-3">
                                        <div className="text-xs font-semibold uppercase tracking-[0.12em] text-slate-500">Type</div>
                                        <div className="mt-1 font-medium text-slate-900">{selectedCommission.type || "Not available"}</div>
                                    </div>
                                    <div className="rounded-xl bg-slate-50 px-4 py-3">
                                        <div className="text-xs font-semibold uppercase tracking-[0.12em] text-slate-500">Date</div>
                                        <div className="mt-1 font-medium text-slate-900">{formatDate(selectedCommission.date)}</div>
                                    </div>
                                    <div className="rounded-xl bg-slate-50 px-4 py-3">
                                        <div className="text-xs font-semibold uppercase tracking-[0.12em] text-slate-500">Created at</div>
                                        <div className="mt-1 font-medium text-slate-900">{formatDate(selectedCommission.createdAt)}</div>
                                    </div>
                                    <div className="rounded-xl bg-slate-50 px-4 py-3 sm:col-span-2">
                                        <div className="text-xs font-semibold uppercase tracking-[0.12em] text-slate-500">User ID</div>
                                        <div className="mt-1 break-all font-medium text-slate-900">{selectedCommission.userId || "Not available"}</div>
                                    </div>
                                </div>
                            </div>
                        ) : lookupState.status === "empty" ? (
                            <div className="mt-4 rounded-2xl border border-dashed border-slate-300 bg-slate-50 px-4 py-6 text-sm text-slate-600">
                                User found, but there are no commission documents to display.
                            </div>
                        ) : lookupState.status === "not-found" ? (
                            <div className="mt-4 rounded-2xl border border-dashed border-slate-300 bg-slate-50 px-4 py-6 text-sm text-slate-600">
                                No user matched this email.
                            </div>
                        ) : (
                            <div className="mt-4 rounded-2xl border border-dashed border-slate-300 bg-slate-50 px-4 py-6 text-sm text-slate-600">
                                Select a commission row to inspect the full item.
                            </div>
                        )}
                    </section>
                </aside>
            </div>
        </section>
    );
}