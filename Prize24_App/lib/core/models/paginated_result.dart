/// A generic, technology-agnostic wrapper for a single page of results.
///
/// Domain and Presentation layers only ever see this class.
/// The [cursor] is an opaque black-box token — callers must NOT inspect,
/// cast, or assume the type of [cursor]. Simply pass it back to the
/// repository to receive the next page.
///
/// When [cursor] is `null`, there are no more pages to load.
///
/// Example — checking whether more pages exist:
/// ```dart
/// if (result.hasMore) {
///   repo.fetchItems(cursor: result.cursor);
/// }
/// ```
class PaginatedResult<T> {
  const PaginatedResult({
    required this.items,
    required this.hasMore,
    this.cursor,
  });

  /// The list of domain models for this page.
  final List<T> items;

  /// Opaque cursor token that identifies the position of the last item on
  /// this page. Pass this value back to the repository as [cursor] to load
  /// the *next* page.
  ///
  /// `null` means this is the last page — there is nothing more to load.
  final Object? cursor;

  /// Convenience flag derived from [cursor]. `true` when a next page exists.
  final bool hasMore;

  /// Creates a copy of this result with the given fields replaced.
  ///
  /// To explicitly set [cursor] to `null` (i.e. mark as last page), pass
  /// `clearCursor: true` instead of `cursor: null` — this avoids the
  /// ambiguity of "null means unchanged" vs "null means no cursor".
  PaginatedResult<T> copyWith({
    List<T>? items,
    bool? hasMore,
    Object? cursor,
    bool clearCursor = false,
  }) {
    return PaginatedResult<T>(
      items: items ?? this.items,
      hasMore: hasMore ?? this.hasMore,
      cursor: clearCursor ? null : (cursor ?? this.cursor),
    );
  }

  @override
  String toString() =>
      'PaginatedResult(items: ${items.length}, hasMore: $hasMore, '
      'cursor: ${cursor != null ? '[set]' : 'null'})';
}
