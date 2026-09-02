class CFSpecificConvertors {
  /// Used to convert response of Cloud Functions from
  /// Map<Object?, Object?> to Map<String, dynamic>
  /// Recursively converts a Map with Object keys to Map<String, dynamic>
  static Map<String, dynamic> convertCFMapToStringDynamic(Object? data) {
    if (data is Map) {
      return Map<String, dynamic>.fromEntries(
        data.entries.map((entry) {
          final key = entry.key.toString();
          final value = entry.value;

          if (value is Map) {
            return MapEntry(key, convertCFMapToStringDynamic(value));
          } else if (value is List) {
            return MapEntry(key, _convertListItems(value));
          } else {
            return MapEntry(key, value);
          }
        }),
      );
    }
    return {}; // Return empty map as fallback
  }

  /// Helper method to process list items
  static List<dynamic> _convertListItems(List<dynamic> items) {
    return items.map((item) {
      if (item is Map) {
        return convertCFMapToStringDynamic(item);
      } else if (item is List) {
        return _convertListItems(item);
      } else {
        return item;
      }
    }).toList();
  }
}
