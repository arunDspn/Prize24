# Firebase backend guide

These instructions apply to `cloud_functions/` and extend the repository-level `AGENTS.md`.

## Scope and architecture

- This is the canonical Firebase backend root. `firestore.rules` and `firestore.indexes.json` are its deployable database configuration; implemented Functions source is in `functions/src/`, and `functions/src/index.ts` is the public export surface.
- `functions/package.json` targets Node.js 22. Use a compatible local Node version for install, build, emulator, and deployment work.
- Feature modules are grouped by domain, including campaign gifts/sharing, shop relationships, vendor friendships, account lifecycle, and the RevenueCat webhook.
- `functions/lib/` is TypeScript output and is ignored by lint. Never edit it directly.

## Function conventions

- Use Firebase Functions v2 APIs and existing Admin SDK patterns. Export every deployable function from `functions/src/index.ts`.
- Validate authentication before accessing user-scoped data, then validate every external payload field and resource authorization.
- Return stable response shapes and use `HttpsError` with deliberate public error codes/messages for callable failures. Do not leak stack traces, secrets, or sensitive document data.
- Use Firestore transactions or batches when an invariant spans multiple documents. Use server timestamps for authoritative event times and keep retry behavior/idempotency in mind.
- Keep collection paths, role checks, status values, counters, and callable names compatible with Flutter callers and security rules. Search the repository before changing any of them.
- Log enough identifiers to diagnose an operation, but never log tokens, webhook authorization values, personal data, or entire request/document payloads.
- Follow the configured ESLint rules: 2-space indentation, double quotes, TypeScript strictness, and a 120-character maximum for this package.

## Commands

Run these from `cloud_functions/functions/`:

```sh
npm run lint
npm run build
npm run serve
npm run emulators
```

`npm run serve` builds and starts only the Functions emulator. `npm run emulators` builds and starts Auth, Firestore, and Functions with the isolated `demo-prize24` project. There is currently no package test script, so do not claim unit tests passed; add targeted tests when implementing logic that can be isolated.

Run direct Firebase CLI commands from `cloud_functions/`, where `firebase.json` and `.firebaserc` live. A bare `firebase deploy` includes every configured backend resource; use an explicit `--only` target after confirming the project. Deployment is never part of routine verification.

## Operational safety

- Treat `functions/src/seed*.js` and `functions/src/delete*.js` as destructive operational utilities. Do not execute, modernize, or fold them into ordinary build work without explicit scope and a confirmed target project.
- Keep webhook secrets in Firebase/Google secret management. Do not put values into source or Markdown.
- For local RevenueCat webhook emulation, put only a dummy value in ignored `functions/.secret.local`; never let the emulator retrieve or use the production secret.
- If a function changes Firestore access patterns, review this directory's `firestore.rules` and `firestore.indexes.json`.
- Prefer emulator-based end-to-end verification of callable and transaction behavior. Never use live collections as fixtures.
