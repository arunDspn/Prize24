# Implemented Cloud Functions guide

These instructions apply to `cloud_functions/` and extend the repository-level `AGENTS.md`.

## Scope and architecture

- This tree contains the implemented Firebase Functions used by the clients. TypeScript source is in `functions/src/`; `functions/src/index.ts` is the public export surface.
- `functions/package.json` targets Node.js 22. Use a compatible local Node version for install, build, emulator, and deployment work.
- Feature modules are grouped by domain, including campaign gifts/sharing, shop relationships, vendor friendships, account lifecycle, and the RevenueCat webhook.
- `functions/lib/` is TypeScript output and is ignored by lint. Never edit it directly.
- The sibling `../firebase/functions/` directory is a separate minimal scaffold. Do not assume edits here update it.

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
```

`npm run serve` builds and starts the Functions emulator. There is currently no package test script, so do not claim unit tests passed; add targeted tests when implementing logic that can be isolated.

Run Firebase CLI commands from `cloud_functions/`, where `firebase.json` and `.firebaserc` live. Deployment is an explicit production-affecting action and is never part of routine verification.

## Operational safety

- Treat `functions/src/seed*.js` and `functions/src/delete*.js` as destructive operational utilities. Do not execute, modernize, or fold them into ordinary build work without explicit scope and a confirmed target project.
- Keep webhook secrets in Firebase/Google secret management. Do not put values into source or Markdown.
- If a function changes Firestore access patterns, review `../firebase/firestore.rules` and `../firebase/firestore.indexes.json` even though this Firebase config deploys only Functions.
- Prefer emulator-based end-to-end verification of callable and transaction behavior. Never use live collections as fixtures.
