# Prize24 Copilot instructions

Use the root `AGENTS.md` for repository-wide guidance and the nearest nested `AGENTS.md` for the project being edited.

- This is a multi-project repository; there is no root build or package-manager command.
- Keep changes scoped to `Prize24_App/`, `cloud_functions/`, `firebase/`, or `commission-web-app/` as requested.
- Never hand-edit generated Dart files, Functions `lib/` output, `.react-router/`, build output, dependency folders, or local environment files.
- Search all consumers before changing a callable Function contract or Firestore collection, field, role, timestamp, or path.
- Preserve server-side authentication/authorization and Firestore rule enforcement; UI route guards are not security boundaries.
- Never expose secrets or real user data. Use mocks and Firebase emulators for integration checks.
- Never deploy, switch Firebase aliases, use production as a test environment, or run `seed*`/`delete*` utilities unless the user explicitly requests the exact operation and target.
- Run the checks documented in the applicable `AGENTS.md`, and state clearly when a check was not run.
