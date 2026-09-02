import { Navigate } from "react-router";
import LoadingPage from "~/components/LoadingPage";
import { useAuth } from "~/hooks/useAuth";

export default function IndexRoute() {
    const { currentUser, isAdmin, isLoading, profileResolved } = useAuth();

    if (isLoading || (currentUser && !profileResolved)) {
        return <LoadingPage label="Loading dashboard..." />;
    }

    if (!currentUser) {
        return <Navigate to="/login" replace />;
    }

    return <Navigate to={isAdmin ? "/home" : "/access-denied"} replace />;
}
