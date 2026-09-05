# Commission dashboard guide

These instructions apply to `commission-web-app/` and extend the repository-level `AGENTS.md`.

## Stack and structure

- This is a React 19 application using React Router 7 framework mode, TypeScript strict mode, Vite 8, Tailwind CSS 4, and the Firebase Web SDK.
- Route registration lives in `app/routes.ts`; route modules live in `app/routes/`.
- Authentication state and profile resolution live in `app/context/AuthContext.tsx` and `app/hooks/useAuth.ts`. Route gates are in `app/components/GuestRoute.tsx` and `app/components/ProtectedRoute.tsx`.
- Firebase initialization is in `app/config/firebase.ts`; authentication and Firestore access are separated into `app/lib/auth.ts` and `app/lib/firestore.ts`.
- Shared dashboard views live in `app/components/dashboard/`. Global styles and Tailwind imports/tokens live in `app/app.css`.

## Implementation conventions

- Use function components and hooks. Keep Firebase reads/writes out of presentational components when they belong in `app/lib/`.
- Use the `~/*` alias for imports from `app/` and preserve strict TypeScript types. Normalize Firestore's untyped data at the data boundary.
- Register new routes in `app/routes.ts` and use React Router-generated route types where applicable.
- Preserve loading, unauthenticated, unauthorized, empty, and error states. Client route protection improves UX but does not replace Firestore rules.
- Keep browser-only APIs out of server rendering paths or guard them explicitly.
- Follow the local file style. No repository formatter or linter script is currently configured, so avoid unrelated whitespace churn.
- For dashboard UI work, read `.github/skills/dashboard-ui-theme/SKILL.md` and follow its Prize24 tokens, accessibility states, and responsive-layout checks.

## Environment and Firebase

- Required public client variables are documented in `.env.example` and use the `VITE_FIREBASE_*` prefix. Add new names to the example with empty/safe placeholder values.
- Never commit a populated `.env`, Admin SDK credential, private key, or server secret. `VITE_*` values are bundled into the client and must never contain secrets.
- Firestore collection defaults and profile normalization are centralized in `app/lib/firestore.ts`; avoid scattering alternate collection names or field fallbacks.
- This directory's `firebase.json` configures Hosting only. Coordinate Firestore rule changes with the canonical `../cloud_functions/firestore.rules` and `../cloud_functions/firestore.indexes.json`.

## Commands

Run from `commission-web-app/`:

```sh
npm run dev
npm run typecheck
npm run build
npm run start
```

Use `npm ci` for a clean install or `npm install` only when intentionally updating dependencies and `package-lock.json`. There is currently no test or lint script, so use `npm run typecheck` plus `npm run build` as the baseline and state that automated tests were not available.

`firebase deploy --only hosting` is a production-affecting command and must not be run unless explicitly requested with the target project confirmed.
