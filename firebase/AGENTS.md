# Firebase configuration guide

These instructions apply to `firebase/` and extend the repository-level `AGENTS.md`.

## Scope

- `firebase.json` configures Firestore rules/indexes, local Auth/Functions/Firestore emulators, and the `functions/` scaffold.
- `firestore.rules` and `firestore.indexes.json` are the deployable rule and index paths declared by this tree's Firebase config.
- `functions/src/` is a minimal, separate Node.js 24 TypeScript scaffold. The implemented functions currently live in `../cloud_functions/functions/src/`; the two packages do not synchronize automatically.
- `firestore copy.rules` is a reference/copy file and is not the path selected by `firebase.json`.
- `.firebaserc` contains development and production aliases. Never switch aliases or deploy as part of implementation verification.

## Rules and index changes

- Treat rules as production code. Preserve least privilege, explicit authentication checks, resource ownership, and role hierarchy.
- Check both reads and writes, including create/update differences between `resource.data` and `request.resource.data`.
- Account for subcollections and `get()`/`exists()` access-call limits. Do not broaden a parent match assuming it automatically secures nested collections.
- Ensure client queries satisfy the rules and add composite indexes only for actual query shapes. Search Flutter, dashboard, and Functions code before changing a field or collection name.
- Prefer emulator-backed rules tests. If a task adds meaningful rule behavior, add a reproducible test harness rather than verifying against a live project.
- The dashboard has a separate `../commission-web-app/firestore.rules` file. Coordinate changes intentionally; do not blindly overwrite either file.

## Commands

Run Functions checks from `firebase/functions/` using Node.js 24:

```sh
npm run lint
npm run build
```

Run local Firebase services from `firebase/`:

```sh
firebase emulators:start --only auth,functions,firestore
```

The Functions package currently has no test script, and the repository has no automated Firestore rules test suite. State that limitation until tests are added. Never deploy rules, indexes, or Functions unless explicitly asked and the target alias is confirmed.
