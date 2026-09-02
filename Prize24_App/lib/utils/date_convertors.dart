import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

// Format date to  12 Sep 2024 ("dd MMM yyyy")
String formatDate1(DateTime date) {
  // Define the format "dd MMM yyyy" (e.g., 12 Sep 2024)
  final DateFormat dateFormat = DateFormat('dd MMM yyyy');

  // Return the formatted date as a string
  return dateFormat.format(date);
}

/// Converter for Firestore Timestamp to DateTime
class TimestampConverter implements JsonConverter<DateTime?, Object?> {
  const TimestampConverter();

  @override
  DateTime? fromJson(Object? json) {
    if (json == null) return null;
    if (json is Timestamp) return json.toDate();
    if (json is String) return DateTime.parse(json);
    return null;
  }

  @override
  Object? toJson(DateTime? dateTime) {
    if (dateTime == null) return null;
    return Timestamp.fromDate(dateTime);
  }
}
