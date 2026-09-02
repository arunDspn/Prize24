// ignore_for_file: always_use_package_imports

// ⚠️  DATA LAYER ONLY — do NOT import this file from Domain or Presentation.
//
// This class is an internal helper that carries the raw Firestore
// [DocumentSnapshot] cursor alongside a page of DTO results. It converts
// to the domain-layer [PaginatedResult] — wrapping the snapshot as an
// opaque [Object?] — via [toDomain].

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prize24_app/core/models/paginated_result.dart';

/// Internal Data-layer wrapper for a single page of Firestore query results.
///
/// [T] is the DTO type. After mapping DTOs → domain models, call [toDomain]
/// to get a [PaginatedResult] that is safe to return across the repository
/// boundary.
class FirebasePage<T> {
  const FirebasePage({required this.items, this.lastDoc});

  /// The DTOs for this page.
  final List<T> items;

  /// The [DocumentSnapshot] of the *last* document on this page.
  ///
  /// Pass this to `Query.startAfterDocument(lastDoc)` to fetch the next page.
  /// `null` indicates this is the final page (fewer docs than `limit` were
  /// returned).
  final DocumentSnapshot<Map<String, dynamic>>? lastDoc;

  /// Whether there is a next page to load.
  bool get hasMore => lastDoc != null;

  /// Maps each DTO with [mapper] and wraps [lastDoc] as an opaque [Object?]
  /// cursor inside a [PaginatedResult].
  ///
  /// Usage in a repository implementation:
  /// ```dart
  /// final page = await _service.fetchOffers(shopId: shopId, cursor: cursor);
  /// return page.toDomain((dto) => dto.toDomain());
  /// ```
  PaginatedResult<R> toDomain<R>(R Function(T dto) mapper) {
    return PaginatedResult<R>(
      items: items.map(mapper).toList(),
      cursor: lastDoc, // wrapped opaque — callers see Object?
      hasMore: hasMore,
    );
  }
}
