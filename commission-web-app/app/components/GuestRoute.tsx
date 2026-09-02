import { Navigate } from "react-router";
import { useAuth } from "~/hooks/useAuth";
import LoadingPage from "~/components/LoadingPage";

export default function GuestRoute({
    children,
}: {
    children: React.ReactNode;
}) {
    const { currentUser, isAdmin, isLoading, profileResolved } = useAuth();

    if (isLoading || (currentUser && !profileResolved)) {
        return <LoadingPage label="Preparing authentication..." />;
    }

    if (!currentUser) {
        return <>{children}</>;
    }

    return <Navigate to={isAdmin ? "/home" : "/access-denied"} replace />;
}
