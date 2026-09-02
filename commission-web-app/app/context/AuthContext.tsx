import {
    createContext,
    useCallback,
    useContext,
    useEffect,
    useMemo,
    useState,
} from "react";
import { onAuthStateChanged, type User } from "firebase/auth";
import { auth } from "~/config/firebase";
import { logoutUser } from "~/lib/auth";
import {
    fetchExistingUserProfile,
    isRoleAdmin,
    type AppUserProfile,
} from "~/lib/firestore";

type AuthContextValue = {
    currentUser: User | null;
    profile: AppUserProfile | null;
    profileResolved: boolean;
    isAdmin: boolean;
    isLoading: boolean;
    error: string | null;
    refreshProfile: () => Promise<void>;
    logout: () => Promise<void>;
};

const AuthContext = createContext<AuthContextValue | undefined>(undefined);

export const AuthProvider = ({ children }: { children: React.ReactNode }) => {
    const [currentUser, setCurrentUser] = useState<User | null>(null);
    const [profile, setProfile] = useState<AppUserProfile | null>(null);
    const [profileResolved, setProfileResolved] = useState(false);
    const [isLoading, setIsLoading] = useState(true);
    const [error, setError] = useState<string | null>(null);

    const loadProfile = useCallback(async (user: User) => {
        const nextProfile = await fetchExistingUserProfile({
            uid: user.uid,
            email: user.email,
        });

        setProfile(nextProfile);
    }, []);

    const refreshProfile = useCallback(async () => {
        if (!currentUser) {
            setProfile(null);
            setProfileResolved(true);
            return;
        }

        setProfileResolved(false);
        try {
            await loadProfile(currentUser);
            setError(null);
        } catch (profileError) {
            setError(
                profileError instanceof Error
                    ? profileError.message
                    : "Failed to load profile.",
            );
            setProfile(null);
        } finally {
            setProfileResolved(true);
        }
    }, [currentUser, loadProfile]);

    useEffect(() => {
        const unsubscribe = onAuthStateChanged(auth, async (user) => {
            setIsLoading(true);
            setCurrentUser(user);

            if (!user) {
                setProfile(null);
                setProfileResolved(true);
                setIsLoading(false);
                return;
            }

            setProfileResolved(false);
            try {
                await loadProfile(user);
                setError(null);
            } catch (profileError) {
                setError(
                    profileError instanceof Error
                        ? profileError.message
                        : "Failed to load profile.",
                );
                setProfile(null);
            } finally {
                setProfileResolved(true);
                setIsLoading(false);
            }
        });

        return () => unsubscribe();
    }, [loadProfile]);

    const logout = useCallback(async () => {
        await logoutUser();
        setProfile(null);
    }, []);

    const value = useMemo(
        () => ({
            currentUser,
            profile,
            profileResolved,
            isAdmin: isRoleAdmin(profile?.role),
            isLoading,
            error,
            refreshProfile,
            logout,
        }),
        [
            currentUser,
            error,
            isLoading,
            logout,
            profile,
            profileResolved,
            refreshProfile,
        ],
    );

    return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
};

export const useAuth = () => {
    const context = useContext(AuthContext);
    if (!context) {
        throw new Error("useAuth must be used within AuthProvider");
    }

    return context;
};
