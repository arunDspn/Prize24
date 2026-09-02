import type { AppUserProfile } from "~/lib/firestore";

export default function OverviewTab({ profile }: { profile: AppUserProfile | null }) {
    return (
        <section className="space-y-4">
            <div className="grid gap-4 lg:grid-cols-3">
                <article className="p24-card border-l-4 border-l-[#ff5f6d] p-5">
                    <p className="text-xs font-semibold uppercase tracking-[0.14em] text-slate-500">
                        Access level
                    </p>
                    <p className="mt-3 text-3xl font-extrabold p24-status-admin">ADMIN</p>
                    <p className="mt-2 text-sm text-slate-600">
                        Administrative permissions are active for this account.
                    </p>
                </article>

                <article className="p24-card p-5">
                    <p className="text-xs font-semibold uppercase tracking-[0.14em] text-slate-500">
                        Account status
                    </p>
                    <p className="mt-3 text-xl font-bold text-slate-900 capitalize">
                        {profile?.status || "active"}
                    </p>
                    <p className="mt-2 text-sm text-slate-600">
                        Session health and access checks are passing.
                    </p>
                </article>

                <article className="p24-card p-5">
                    <p className="text-xs font-semibold uppercase tracking-[0.14em] text-slate-500">
                        Profile
                    </p>
                    <p className="mt-3 text-xl font-bold text-slate-900">
                        {profile?.displayName || "No name available"}
                    </p>
                    <p className="mt-2 truncate text-sm text-slate-600">
                        {profile?.email || "No email available"}
                    </p>
                </article>
            </div>

            <section className="p24-kpi-strip rounded-2xl px-6 py-5">
                <h3 className="text-lg font-bold text-slate-900">Security and access summary</h3>
                <p className="mt-2 text-sm text-slate-700">
                    Access to this dashboard is restricted to administrator accounts with valid authentication.
                </p>
            </section>
        </section>
    );
}