import { useState } from "react";
import { Link, useNavigate } from "react-router";
import AuthCard from "~/components/AuthCard";
import GuestRoute from "~/components/GuestRoute";
import { signUpWithGoogle } from "~/lib/auth";

export default function SignupRoute() {
    const [inviteCode, setInviteCode] = useState("");
    const [error, setError] = useState<string | null>(null);
    const [isSubmitting, setIsSubmitting] = useState(false);
    const navigate = useNavigate();

    const handleSignup = async () => {
        setError(null);

        if (!inviteCode.trim()) {
            setError("Invite code is required.");
            return;
        }

        setIsSubmitting(true);

        try {
            await signUpWithGoogle(inviteCode);
            navigate("/", { replace: true });
        } catch (signupError) {
            setError(
                signupError instanceof Error
                    ? signupError.message
                    : "Unable to sign up right now.",
            );
        } finally {
            setIsSubmitting(false);
        }
    };

    return (
        <GuestRoute>
            <div className="p24-shell flex min-h-screen items-center justify-center px-4 py-8">
                <AuthCard
                    title="Invite Sign Up"
                    subtitle="Enter your invite code and continue with Google."
                >
                    <div className="space-y-2">
                        <label
                            htmlFor="invite-code"
                            className="text-xs font-semibold uppercase tracking-[0.14em] text-slate-500"
                        >
                            Invite code
                        </label>
                        <input
                            id="invite-code"
                            name="invite-code"
                            value={inviteCode}
                            onChange={(event) => setInviteCode(event.target.value)}
                            placeholder="Enter invite code"
                            className="w-full rounded-xl border border-slate-300 bg-white px-4 py-2.5 text-sm text-slate-900 outline-none transition focus:border-slate-500 focus:ring-2 focus:ring-slate-200"
                        />
                    </div>

                    <button
                        type="button"
                        onClick={handleSignup}
                        disabled={isSubmitting}
                        className="p24-button-gradient w-full rounded-xl px-4 py-3 text-sm font-bold tracking-wide transition disabled:cursor-not-allowed disabled:opacity-60"
                    >
                        {isSubmitting ? "Creating account..." : "Sign up with Google"}
                    </button>

                    {error ? (
                        <p className="rounded-lg border border-orange-200 bg-orange-50 px-3 py-2 text-sm text-orange-700">
                            {error}
                        </p>
                    ) : null}

                    <p className="text-center text-sm text-slate-600">
                        Already have access?{" "}
                        <Link className="font-semibold text-slate-900 underline" to="/login">
                            Back to login
                        </Link>
                    </p>
                </AuthCard>
            </div>
        </GuestRoute>
    );
}
