import { Navigate, useNavigate } from "react-router";
import { useAuth } from "~/hooks/useAuth";
import LoadingPage from "~/components/LoadingPage";

export default function AccessDeniedRoute() {
    const { currentUser, isAdmin, isLoading, profile, profileResolved, logout } = useAuth();
    const navigate = useNavigate();

    if (isLoading || (currentUser && !profileResolved)) {
        return <LoadingPage label="Verifying access level..." />;
    }

    if (!currentUser) {
        return <Navigate to="/login" replace />;
    }

    if (isAdmin) {
        return <Navigate to="/home" replace />;
    }

    const handleLogout = async () => {
        await logout();
        navigate("/login", { replace: true });
    };

    return (
        <div className="p24-shell flex min-h-screen items-center justify-center px-4 py-8">
            <section className="p24-card w-full max-w-xl p-7 sm:p-9">
                <p className="text-xs font-semibold uppercase tracking-[0.16em] text-slate-500">Restricted area</p>
                <h1 className="mt-3 text-3xl font-extrabold tracking-tight text-slate-900">Access denied</h1>
                <p className="mt-4 text-sm leading-relaxed text-slate-700">
                    Only admins can access this dashboard. Your current role is
                    <span className="p24-status-denied ml-1 font-bold uppercase">{profile?.role ?? "unknown"}</span>.
                </p>

                <div className="mt-6 flex gap-3">
                    <button
                        type="button"
                        onClick={handleLogout}
                        className="p24-button-gradient rounded-xl px-5 py-2.5 text-sm font-semibold transition"
                    >
                        Logout
                    </button>
                    <button
                        type="button"
                        onClick={() => navigate("/login", { replace: true })}
                        className="rounded-xl border border-slate-300 bg-white px-5 py-2.5 text-sm font-semibold text-slate-700 transition hover:bg-slate-100"
                    >
                        Back to login
                    </button>
                </div>
            </section>
        </div>
    );
}
