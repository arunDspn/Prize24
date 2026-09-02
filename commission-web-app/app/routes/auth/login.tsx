import { useState } from "react";
import { useNavigate, Link } from "react-router";
import AuthCard from "~/components/AuthCard";
import GuestRoute from "~/components/GuestRoute";
import { signInWithGoogle } from "~/lib/auth";

export default function LoginRoute() {
    const [error, setError] = useState<string | null>(null);
    const [isSubmitting, setIsSubmitting] = useState(false);
    const navigate = useNavigate();

    const handleGoogleLogin = async () => {
        setError(null);
        setIsSubmitting(true);

        try {
            await signInWithGoogle();
            navigate("/", { replace: true });
        } catch (authError) {
            setError(
                authError instanceof Error
                    ? authError.message
                    : "Login failed. Please try again.",
            );
        } finally {
            setIsSubmitting(false);
        }
    };

    return (
        <GuestRoute>
            <div className="p24-shell flex min-h-screen items-center justify-center px-4 py-8">
                <AuthCard
                    title="Admin Sign In"
                    subtitle="Use your Google account to access the Prize24 dashboard."
                >
                    <button
                        type="button"
                        onClick={handleGoogleLogin}
                        disabled={isSubmitting}
                        className="p24-button-gradient w-full rounded-xl px-4 py-3 text-sm font-bold tracking-wide transition disabled:cursor-not-allowed disabled:opacity-60"
                    >
                        {isSubmitting ? "Signing in..." : "Continue with Google"}
                    </button>

                    {error ? (
                        <p className="rounded-lg border border-orange-200 bg-orange-50 px-3 py-2 text-sm text-orange-700">
                            {error}
                        </p>
                    ) : null}

                    <p className="text-center text-sm text-slate-600">
                        Need an invite first?{" "}
                        <Link className="font-semibold text-slate-900 underline" to="/signup">
                            Go to sign up
                        </Link>
                    </p>
                </AuthCard>
            </div>
        </GuestRoute>
    );
}
