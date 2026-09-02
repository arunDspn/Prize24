# Prize24 repository guide

This file is the canonical guidance for coding agents working in this repository. It applies to the entire repository. A more specific `AGENTS.md` in a subdirectory adds to or overrides these instructions for that project.

## Repository map

- `Prize24_App/`: Flutter mobile/client application. It uses Flutter 3.38.6 through FVM, Dart 3.8+, Riverpod, GoRouter, Firebase, Freezed, and JSON serialization.
- `cloud_functions/`: the implemented Firebase Cloud Functions codebase. TypeScript source is in `functions/src/`; compiled output is in `functions/lib/`. Its package targets Node.js 22.
- `firebase/`: Firebase rules, indexes, emulator configuration, and a separate minimal Functions scaffold targeting Node.js 24. This tree is not automatically synchronized with `cloud_functions/`.
- `commission-web-app/`: React 19 / React Router 7 / Vite 8 commission dashboard backed by Firebase and deployed as Firebase Hosting output.
- `firebase/firestore copy.rules`: a named copy/reference file. Do not treat it as a deploy target unless a task explicitly names it.

There is no root package manager or root build command. Run commands from the relevant project directory.

## Working rules

1. Start by checking `git status` and reading the nearest project-level `AGENTS.md`.
2. Keep changes inside the project requested by the task. Do not refactor sibling projects incidentally.
3. Inspect the executable configuration (`pubspec.yaml`, `package.json`, `firebase.json`, `tsconfig.json`) before trusting older Markdown notes.
4. Follow nearby naming, architecture, error handling, and formatting. Preserve intentional legacy spellings in public routes, Firestore fields, and callable function names unless the task includes a migration.
5. Add or update focused tests when practical. Run the smallest relevant check first, then the project-wide checks listed below.
6. Report checks that could not run and why. Never imply that a build, test, emulator flow, or deployment was performed when it was not.

## Generated and local-only files

- Do not manually edit dependency directories or generated/build output: `node_modules/`, `.dart_tool/`, `.firebase/`, `build/`, `.react-router/`, or either Functions package's `lib/` directory.
- In Flutter, do not hand-edit `*.g.dart` or `*.freezed.dart`. Edit the source annotation/model, run code generation, and include the regenerated tracked files when needed.
- Do not modify local `.env*` files, service-account files, signing material, or IDE settings. Document new web environment variables in `commission-web-app/.env.example`.
- Update only the lockfile belonging to a dependency change: Flutter's `pubspec.lock` or the relevant npm `package-lock.json`.

## Cross-project contracts

- Callable Function names, request payloads, response shapes, and error codes are shared between `cloud_functions/functions/src/` and Flutter callers under `Prize24_App/lib/`. Search both before changing a contract.
- Firestore collection names, document fields, roles, timestamps, and subcollection paths are shared by the Flutter app, dashboard, Functions, rules, and indexes. Search the whole repository before renaming or changing their types.
- Security rules are part of feature behavior. A query or write-path change may require a coordinated update to `firebase/firestore.rules`, `firebase/firestore.indexes.json`, and relevant client code.
- The Firebase configurations are independent. Do not copy, merge, or deploy one tree over another based only on similar filenames.

## Safety and production boundaries

- Never add credentials, private keys, tokens, webhook secrets, or real user data to source, fixtures, logs, or documentation.
- Use mocks or Firebase emulators for tests. Do not read, seed, mutate, or delete live Firebase data unless the user explicitly requests the exact operation and target project.
- Do not run deployment commands, change Firebase project aliases, or select the `prod` project as part of ordinary implementation or verification.
- Scripts with names such as `seed*` and `delete*` under `cloud_functions/functions/src/` are operational and potentially destructive. Do not execute them without explicit authorization and a confirmed non-production target.
- Preserve authentication and authorization checks. Client-side route guards are not a replacement for Firestore rules or server-side checks.

## Validation matrix

| Area | Required checks after relevant changes |
| --- | --- |
| Flutter app | `cd Prize24_App && fvm dart format --output=none --set-exit-if-changed lib test`, then `fvm flutter analyze` and `fvm flutter test` |
| Implemented Cloud Functions | `cd cloud_functions/functions && npm run lint && npm run build` |
| Firebase scaffold | `cd firebase/functions && npm run lint && npm run build` |
| Commission dashboard | `cd commission-web-app && npm run typecheck && npm run build` |
| Rules or integration behavior | Exercise the affected flow against Firebase emulators; do not use production as a test environment |

If FVM is unavailable, use the pinned Flutter version from `Prize24_App/.fvmrc` rather than silently validating with an unrelated SDK.

## Definition of done

- The requested behavior is implemented with the smallest coherent change.
- Generated artifacts are regenerated from source rather than hand-edited.
- Relevant validation passes, or existing/unavoidable failures are clearly identified.
- Security rules, indexes, environment templates, and documentation are updated when the contract requires them.
- The final diff contains no secrets, local configuration, debug output, or unrelated formatting churn.
