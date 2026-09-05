# Prize24 Flutter app guide

These instructions apply to `Prize24_App/` and extend the repository-level `AGENTS.md`.

## Stack and structure

- Use the Flutter SDK pinned in `.fvmrc` (3.38.6). The package requires Dart `^3.8.0`.
- The app has `development`, `staging`, and `production` flavors with entry points in `lib/main_development.dart`, `lib/main_staging.dart`, and `lib/main_production.dart`.
- Most product code is feature-first under `lib/features/<feature>/`, commonly split into `data`, `domain`, and `presentation`. Shared services/models live under `lib/core/`; reusable widgets live under `lib/common_widgets/`.
- State management uses Riverpod. Navigation is centralized in `lib/routing/app_router.dart` and route constants in `lib/routing/app_routes.dart`.
- Firebase startup, notifications, analytics, RevenueCat, Sentry, and other process-level initialization live in `lib/bootstrap.dart`. Keep initialization ordered and failure handling explicit.

## Implementation conventions

- Match the structure of the nearest feature. Keep Firestore SDK details in data/services or repositories rather than UI widgets.
- Prefer Riverpod providers/controllers consistent with neighboring code. Keep asynchronous loading, success, and error states observable by the UI.
- Preserve serialized Firestore field names and nullability. Treat `Timestamp`, `DateTime`, document IDs, callable payloads, and enum/string values as cross-project contracts.
- Add routes and route constants together. Validate every `state.extra` cast at the call sites before changing its type.
- Keep flavor-specific Firebase options and platform configuration separate. Do not point development or staging entry points at production services.
- Put user-visible text through the localization system under `lib/l10n/arb/` when the surrounding feature is localized.
- Reuse established components and theme values before adding one-off styling. Check component-level README files where present.
- Do not edit generated `*.g.dart` or `*.freezed.dart` files directly.

## Code generation

After changing Riverpod annotations, Freezed models, or JSON-serializable models, run:

```sh
fvm dart run build_runner build --delete-conflicting-outputs
```

After changing ARB localization files, run:

```sh
fvm flutter gen-l10n
```

Review generated diffs and keep them limited to the source change.

## Run and validate

```sh
# Development app
fvm flutter run --flavor development --target lib/main_development.dart

# Focused test
fvm flutter test test/path_to_test.dart

# Full local checks
fvm dart format --output=none --set-exit-if-changed lib test
fvm flutter analyze
fvm flutter test --coverage --test-randomize-ordering-seed random
```

Use `fvm flutter pub get` after a dependency change. Avoid unrelated platform regeneration or `flutter create .`.

## Firebase and platform safety

- Use emulators or mocks for automated tests. Never make tests depend on live Firebase state.
- A callable Function change must be coordinated with `../cloud_functions/functions/src/`.
- A Firestore query/write change must be checked against `../cloud_functions/firestore.rules` and `../cloud_functions/firestore.indexes.json`.
- Keep Android/iOS/macOS/Windows/Web changes minimal and flavor-aware. Do not replace signing files, bundle IDs, package names, entitlements, or `google-services` configuration unless explicitly requested.
