import { type RouteConfig, index, route } from "@react-router/dev/routes";

export default [
    index("routes/index.tsx"),
    route("login", "routes/auth/login.tsx"),
    route("signup", "routes/auth/signup.tsx"),
    route("access-denied", "routes/access-denied.tsx"),
    route("home", "routes/home.tsx"),
] satisfies RouteConfig;
