export default function AuthCard({
    title,
    subtitle,
    children,
}: {
    title: string;
    subtitle: string;
    children: React.ReactNode;
}) {
    return (
        <section className="p24-card w-full max-w-md overflow-hidden">
            <div className="bg-gradient-to-r from-[var(--brand-start)] to-[var(--brand-end)] px-6 py-5">
                <h1 className="text-xl font-bold tracking-tight text-slate-900">{title}</h1>
                <p className="mt-1 text-sm font-medium text-slate-800/80">{subtitle}</p>
            </div>
            <div className="space-y-4 px-6 py-6">{children}</div>
        </section>
    );
}
