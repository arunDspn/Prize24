# Firebase Pagination Migration Plan

> **Status:** Planning Phase — Read this entire document before writing a single line of code.

---

## 1. Current State Analysis (What's Wrong)

### The Problem: SQL Pagination Wired to Firebase

Every method across **all 4 layers** carries `int page = 1, int limit = 10`:

```
Interface  →  Repository  →  IService  →  FirebaseService
(page, limit)  (page, limit)  (page, limit)  (page, limit but NEVER USED)
```

The Firebase implementations call `.get()` and return **all documents** every time. The `page` and `limit` params are passed all the way down but silently ignored:

```dart
// firebase_shop_service.dart (CURRENT — BAD)
Future<List<ShopOfferDto>> fetchShopOffers({
  required String shopId,
  int page = 1,   // <-- ignored
  int limit = 10, // <-- ignored
}) async {
  final snapshot = await _firestore
      .collection('shops')
      .doc(shopId)
      .collection('offers')
      .get(); // <-- fetches EVERYTHING every call

  return snapshot.docs.map((doc) => ShopOfferDto.fromJson(doc.data())).toList();
}
```

### Why This is a Problem

| Issue | Impact |
|---|---|
| No real pagination | Every list fetches the entire collection (slow, expensive) |
| SQL `page` concept leaks into Firestore | `startAfter(page * limit)` requires scanning all previous docs |
| Domain leaks: `DocumentSnapshot` cant go up to interface | Tests break if you mock with non-Firebase data |
| Presentation has no "load more" | No infinite scroll, no pull-to-refresh |

---

## 2. Architecture Decision: Opaque Cursor Pattern

### The Rule: Each Layer Owns Only Its Own Types

```
┌──────────────────────────────────────────────────────────────┐
│  PRESENTATION LAYER  (Riverpod Notifiers, UI)                │
│  - Sees: PaginatedResult<T>  cursor is Object? (black box)  │
├──────────────────────────────────────────────────────────────┤
│  DOMAIN LAYER        (Interfaces, Use Cases, Models)         │
│  - Sees: PaginatedResult<T>  cursor is Object? (black box)  │
├──────────────────────────────────────────────────────────────┤
│  DATA LAYER          (Repository Impl, IService, Firebase)   │
│  - Sees: DocumentSnapshot?   (unwraps the black box)        │
└──────────────────────────────────────────────────────────────┘
```

### The Core Idea

- **Domain/Presentation** calls the repo with an `Object? cursor` — they don't care what's inside.
- **Data layer** casts `cursor as DocumentSnapshot?` — only it knows what's inside.
- **Returning** the cursor: repository wraps the `DocumentSnapshot` back into `Object?` — making it opaque again.

---

## 3. Shared Infrastructure to Create

### 3.1 — `PaginatedResult<T>` (Domain layer — shared model)

**File:** `lib/core/models/paginated_result.dart`

```dart
@freezed
class PaginatedResult<T> with _$PaginatedResult<T> {
  const factory PaginatedResult({
    required List<T> items,
    required Object? cursor,   // opaque token — null means no more pages
    @Default(false) bool hasMore,
  }) = _PaginatedResult;
}
```

`cursor == null` is the signal that we are on the **last page**.  
`hasMore` is a convenience flag derived from `cursor != null`.

### 3.2 — `FirebasePage<T>` (Data layer — internal only)

**File:** `lib/core/data/firebase_page.dart`

```dart
// INTERNAL to Data layer only — NEVER import this in Domain or Presentation
class FirebasePage<T> {
  const FirebasePage({required this.items, this.lastDoc});
  final List<T> items;
  final DocumentSnapshot<Map<String, dynamic>>? lastDoc;  // the raw cursor

  bool get hasMore => lastDoc != null;

  PaginatedResult<T> toDomain() => PaginatedResult(
    items: items,
    cursor: lastDoc,          // wrapped as Object?
    hasMore: hasMore,
  );
}
```

---

## 4. Layer-by-Layer Changes

### 4.1 Domain Interface (`IShopRepository` and others)

**BEFORE:**
```dart
Future<List<ShopOfferModel>> listShopOffers({
  required String shopId,
  int page = 1,
  int limit = 10,
});
```

**AFTER:**
```dart
Future<PaginatedResult<ShopOfferModel>> listShopOffers({
  required String shopId,
  Object? cursor,         // opaque Firestore cursor
  int limit = 20,
});
```

**Key rules:**
- Remove `int page` completely — it has no meaning in Firestore
- Replace `List<T>` return with `PaginatedResult<T>`
- Add `Object? cursor` (nullable = first page)
- Keep `int limit` — the data layer will forward it to Firestore `.limit()`

### 4.2 Service Interface (`IShopService` and others)

The service interface **is already in the data layer**, so it can use `DocumentSnapshot` directly.

**BEFORE:**
```dart
Future<List<ShopOfferDto>> fetchShopOffers({
  required String shopId,
  int page = 1,
  int limit = 10,
});
```

**AFTER:**
```dart
Future<FirebasePage<ShopOfferDto>> fetchShopOffers({
  required String shopId,
  DocumentSnapshot<Map<String, dynamic>>? cursor,
  int limit = 20,
});
```

### 4.3 Firebase Service Implementation

**BEFORE:**
```dart
final snapshot = await _firestore
    .collection('shops')
    .doc(shopId)
    .collection('offers')
    .get();
```

**AFTER:**
```dart
Future<FirebasePage<ShopOfferDto>> fetchShopOffers({
  required String shopId,
  DocumentSnapshot<Map<String, dynamic>>? cursor,
  int limit = 20,
}) async {
  var query = _firestore
      .collection('shops')
      .doc(shopId)
      .collection('offers')
      .orderBy('createdAt', descending: true)  // ← REQUIRED for cursors
      .limit(limit);                            // ← Actually limit now!

  if (cursor != null) {
    query = query.startAfterDocument(cursor);   // ← Cursor magic
  }

  final snapshot = await query.get();
  final dtos = snapshot.docs
      .map((doc) => ShopOfferDto.fromJson(doc.data()).copyWith(id: doc.id))
      .toList();

  // If we got fewer than `limit` items, there are no more pages
  final lastDoc = snapshot.docs.length == limit ? snapshot.docs.last : null;

  return FirebasePage(items: dtos, lastDoc: lastDoc);
}
```

### 4.4 Repository Implementation

**BEFORE:**
```dart
@override
Future<List<ShopOfferModel>> listShopOffers({
  required String shopId,
  int page = 1,
  int limit = 10,
}) async {
  final offerDtos = await _shopService.fetchShopOffers(
    shopId: shopId,
    page: page,
    limit: limit,
  );
  return offerDtos.map((dto) => dto.toDomain()).toList();
}
```

**AFTER:**
```dart
@override
Future<PaginatedResult<ShopOfferModel>> listShopOffers({
  required String shopId,
  Object? cursor,
  int limit = 20,
}) async {
  final page = await _shopService.fetchShopOffers(
    shopId: shopId,
    cursor: cursor as DocumentSnapshot<Map<String, dynamic>>?,  // ← cast
    limit: limit,
  );
  return PaginatedResult(
    items: page.items.map((dto) => dto.toDomain()).toList(),
    cursor: page.lastDoc,   // re-wrap as Object?
    hasMore: page.hasMore,
  );
}
```

### 4.5 Presentation (Riverpod Notifiers)

**New pattern — two-stage state:**

```dart
@freezed
class OfferListState with _$OfferListState {
  const factory OfferListState({
    @Default([]) List<ShopOfferModel> items,
    Object? cursor,                    // null = first/last page
    @Default(false) bool hasMore,
    @Default(false) bool isLoadingMore, // for the "loading" spinner at bottom
  }) = _OfferListState;
}

@riverpod
class ShopOfferListController extends _$ShopOfferListController {
  @override
  Future<OfferListState> build({required String shopId}) async {
    final result = await ref.read(shopRepositoryProvider).listShopOffers(
      shopId: shopId,
    );
    return OfferListState(
      items: result.items,
      cursor: result.cursor,
      hasMore: result.hasMore,
    );
  }

  // Triggered by "scroll to bottom" or "load more" button
  Future<void> fetchMore() async {
    final current = state.valueOrNull;
    if (current == null || !current.hasMore || current.isLoadingMore) return;

    state = AsyncData(current.copyWith(isLoadingMore: true));

    try {
      final result = await ref.read(shopRepositoryProvider).listShopOffers(
        shopId: shopId,
        cursor: current.cursor,
      );
      state = AsyncData(current.copyWith(
        items: [...current.items, ...result.items],
        cursor: result.cursor,
        hasMore: result.hasMore,
        isLoadingMore: false,
      ));
    } catch (e, st) {
      state = AsyncData(current.copyWith(isLoadingMore: false));
      // optionally handle error
    }
  }

  // Pull-to-refresh: reset cursor to null, re-fetch first page
  Future<void> refresh() async {
    state = const AsyncLoading();
    ref.invalidateSelf();
    await future; // wait for build() to complete
  }
}
```

---

## 5. Features to Migrate (Full Scope Checklist)

The following methods use `int page = 1, int limit = N` and need migration:

### `IShopRepository` / `ShopRepository` / `IShopService` / `FirebaseShopService`

| Method | Collection Path | Suggested `orderBy` |
|---|---|---|
| `listAllShopsOfVendor` | `shops` | `createdAt desc` |
| `fetchShopFollowers` | `shops/{shopId}/followers` | `followedAt desc` |
| `listUserFollowedShops` | `users/{userId}/followedShops` | `followedAt desc` |
| `getShopStaffs` | `shops/{shopId}/staffs` | `addedAt desc` |
| `viewFollowerStreakLogs` | `shops/{shopId}/followers/{userId}/checkInLogs` | `checkedInAt desc` |
| `listShopOffers` | `shops/{shopId}/offers` | `createdAt desc` |

### Other Features (scan and update)

- `lib/features/campaign/` — has offset simulation, needs full replacement
- `lib/features/gift/` — has `page`/`limit` params + `_validatePaginationParams`
- `lib/features/subscriptions/` — scan for `page`/`limit`
- `lib/features/coupons/` — scan for `page`/`limit`
- `lib/features/happy_hours/` — scan for `page`/`limit`

---

## 6. Pull-to-Refresh Strategy

Pull-to-Refresh is a **cursor reset**.

```dart
// In the controller
Future<void> refresh() async {
  // Option A: Simple — invalidate and let build() re-run (re-fetches page 1)
  ref.invalidateSelf();

  // Option B: Manual — preserves state during refresh (shows old data while loading)
  state = AsyncData(state.valueOrNull!.copyWith(isLoadingMore: true));
  final result = await ref.read(shopRepositoryProvider).listShopOffers(
    shopId: shopId,
    cursor: null,   // ← cursor = null means start over
  );
  state = AsyncData(OfferListState(
    items: result.items,
    cursor: result.cursor,
    hasMore: result.hasMore,
  ));
}
```

**In the UI:**
```dart
RefreshIndicator(
  onRefresh: () => ref.read(shopOfferListControllerProvider(shopId: shopId).notifier).refresh(),
  child: ListView.builder(
    controller: _scrollController, // add scroll listener for "load more"
    ...
  ),
)
```

**Scroll-to-bottom trigger:**
```dart
// In initState / build
_scrollController.addListener(() {
  if (_scrollController.position.pixels >=
      _scrollController.position.maxScrollExtent - 200) {
    ref.read(shopOfferListControllerProvider(shopId: shopId).notifier).fetchMore();
  }
});
```

---

## 7. Important: `orderBy` is Required for Firestore Cursors

`startAfterDocument` will only work correctly when the query has an `orderBy` clause. Without `orderBy`, the cursor position is **undefined**.

Every Firestore collection that will be paginated **must** have a consistent timestamp field to order by. The standard field name convention is `createdAt`.

If a collection currently lacks a `createdAt` field on its documents, that field must be added as part of this migration.

---

## 8. Migration Phases (Recommended Order)

```
Phase 0: Create shared infrastructure
  └── lib/core/models/paginated_result.dart
  └── lib/core/data/firebase_page.dart

Phase 1: Migrate shop/offers (smallest, most isolated feature)
  └── IShopService.fetchShopOffers
  └── FirebaseShopService.fetchShopOffers
  └── IShopRepository.listShopOffers
  └── ShopRepository.listShopOffers
  └── ShopOfferListController (presentation)
  └── ShopOffersListPage UI (infinite scroll + refresh)
  → Run, test, verify before moving on

Phase 2: Migrate remaining shop sub-collections
  └── fetchShopFollowers
  └── getShopStaffs
  └── viewFollowerStreakLogs
  └── listShopOffers (done)

Phase 3: Migrate top-level shop queries
  └── listAllShopsOfVendor
  └── listUserFollowedShops

Phase 4: Migrate campaign, gift, coupons, happy_hours features
  └── Scan each feature, apply same pattern

Phase 5: Cleanup
  └── Remove all `int page = 1` parameters from everywhere
  └── Run `build_runner` to regenerate `.g.dart` files
  └── Fix all compile errors
```

---

## 9. What Does NOT Change

| What | Why |
|---|---|
| Single-document fetches (e.g. `getShopDetails`, `getShopOfferById`) | Not lists, no pagination needed |
| Cloud Function calls (e.g. `checkInUser`, `followShop`) | CF manages its own pagination |
| Non-Firestore list queries (e.g. `getStaffsShops` with `whereIn`) | Already bounded by the `shopIds` list |
| Model/DTO classes (`ShopOfferModel`, `ShopOfferDto`) | No change needed |

---

## 10. Pre-Work for Each Collection

Before implementing cursors on a collection, answer these questions:

1. **Does every document in this collection have a `createdAt` / `addedAt` / `followedAt` field?**
   - If NO → the migration must also ensure new documents get a timestamp, or use a different field.

2. **What is the correct sort order for the user?**
   - Most recent first? → `orderBy('createdAt', descending: true)`
   - Oldest first? → `orderBy('createdAt')`

3. **Is there a Composite Index needed?**
   - If you `where()` + `orderBy()` on different fields → Firestore requires a composite index.
   - Example: `.where('shopId', ...).orderBy('createdAt')` → needs index.

---

## 11. Summary: What We're Building

```
Domain/Presentation sees:
  PaginatedResult<T> { items, cursor: Object?, hasMore }

Data Layer uses:
  FirebasePage<T> { items, lastDoc: DocumentSnapshot? }

Firestore queries use:
  .orderBy('createdAt', descending: true)
  .limit(20)
  .startAfterDocument(cursor)   // cursor = null → no startAfter = first page
```

**No SQL `page` concept. No "fetch all and skip" anti-pattern. Real Firestore cursor pagination.**

---

*Next step: Confirm this plan, then begin with Phase 0 + Phase 1 (shop offers).*
