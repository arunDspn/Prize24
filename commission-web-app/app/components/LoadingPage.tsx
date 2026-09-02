export default function LoadingPage({ label }: { label?: string }) {
    return (
        <div className="p24-shell min-h-screen px-4 py-10 sm:px-6">
            <div className="mx-auto flex w-full max-w-xl items-center justify-center">
                <div className="p24-card w-full p-8 text-center">
                    <div className="mx-auto mb-5 h-12 w-12 animate-spin rounded-full border-4 border-slate-200 border-t-orange-500" />
                    <p className="text-sm font-semibold tracking-wide text-slate-600">
                        {label ?? "Checking your secure session..."}
                    </p>
                </div>
            </div>
        </div>
    );
}
