import { Navigate } from "react-router";
import { useAuth } from "~/hooks/useAuth";
import LoadingPage from "~/components/LoadingPage";

export default function ProtectedRoute({
    children,
}: {
    children: React.ReactNode;
}) {
    const { currentUser, isAdmin, isLoading, profileResolved } = useAuth();

    if (isLoading || (currentUser && !profileResolved)) {
        return <LoadingPage label="Verifying admin access..." />;
    }

    if (!currentUser) {
        return <Navigate to="/login" replace />;
    }

    if (!isAdmin) {
        return <Navigate to="/access-denied" replace />;
    }

    return <>{children}</>;
}
