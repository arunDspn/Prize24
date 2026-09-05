# Firebase Backend Commands

Run direct Firebase CLI commands from this directory. Run npm commands from `functions/` unless a command says otherwise.

## Toolchain and install

The Functions runtime is Node.js 22, pinned by `.nvmrc` and `functions/package.json`.

```sh
nvm use
node --version
firebase --version
cd functions
npm ci
```

When using NVM, global npm tools are installed per Node.js version. If `firebase` is unavailable after `nvm use`, install the Firebase CLI for Node.js 22 before using the emulator or deployment commands.

## Lint and build

```sh
cd functions
npm run lint
npm run build
```

Use `npm run build:watch` for continuous TypeScript compilation. `functions/lib/` is generated output and must not be edited directly.

## Local emulators

The Functions package provides two emulator modes:

```sh
cd functions

# Functions only; retained for compatibility
npm run serve

# Auth + Firestore + Functions using an isolated demo project
npm run emulators
```

The full suite uses these ports:

- Auth: `9099`
- Functions: `5001`
- Firestore: `8080`
- Emulator UI: Firebase CLI default

The RevenueCat webhook binds `REVENUECAT_WEBHOOK_SECRET`. Before emulating that function, create an ignored `functions/.secret.local` containing a dummy local value:

```dotenv
REVENUECAT_WEBHOOK_SECRET=local-test-only
```

Never put the production secret in a local file, command, fixture, or log. Remove the dummy file when it is no longer needed.

## Functions shell and logs

```sh
cd functions
npm run shell
npm run logs
```

The Functions shell does not provide full cross-service Firestore/Auth emulation; prefer `npm run emulators` for integrated behavior.

## Deployment

Deployment is a production-affecting operation. Confirm the Firebase project alias first and always use an explicit target:

```sh
# Run from cloud_functions/
firebase deploy --only functions --project CONFIRMED_ALIAS
firebase deploy --only firestore --project CONFIRMED_ALIAS
firebase deploy --only functions,firestore --project CONFIRMED_ALIAS
```

Do not run a bare `firebase deploy`; this backend root now configures both Functions and Firestore. Local builds and emulator checks never require deployment.
