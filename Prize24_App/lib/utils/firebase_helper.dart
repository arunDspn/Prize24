import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHelper {
  ///  Helper functions for Timestamp conversion
  /// Convert JSON to Timestamp
  /// Used for Firestore deserialization
  static Timestamp timestampFromJson(dynamic json) {
    if (json is Timestamp) {
      return json;
    }
    if (json is Map<String, dynamic>) {
      return Timestamp(
        (json['_seconds'] as num?)?.toInt() ?? 0,
        (json['_nanoseconds'] as num?)?.toInt() ?? 0,
      );
    }
    if (json is int) {
      return Timestamp.fromMillisecondsSinceEpoch(json);
    }
    throw ArgumentError('Cannot convert $json to Timestamp');
  }

  /// Convert Timestamp to JSON
  /// Used for Firestore serialization
  static dynamic timestampToJson(Timestamp timestamp) {
    return {
      '_seconds': timestamp.seconds,
      '_nanoseconds': timestamp.nanoseconds,
    };
  }

  /// Convert nullable Timestamp to JSON
  /// Used for Firestore serialization
  static dynamic nullableTimestampToJson(Timestamp? timestamp) {
    if (timestamp == null) {
      return null;
    }
    return {
      '_seconds': timestamp.seconds,
      '_nanoseconds': timestamp.nanoseconds,
    };
  }

  /// Helper functions for nullable Timestamp conversion
  /// Convert JSON to nullable Timestamp
  /// Used for Firestore deserialization
  static Timestamp? nullableTimestampFromJson(dynamic json) {
    if (json == null) {
      return null;
    }
    if (json is Timestamp) {
      return json;
    }
    if (json is Map<String, dynamic>) {
      return Timestamp(
        (json['_seconds'] as num?)?.toInt() ?? 0,
        (json['_nanoseconds'] as num?)?.toInt() ?? 0,
      );
    }
    if (json is int) {
      return Timestamp.fromMillisecondsSinceEpoch(json);
    }
    throw ArgumentError('Cannot convert $json to Timestamp');
  }
}
