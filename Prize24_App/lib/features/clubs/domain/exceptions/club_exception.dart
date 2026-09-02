/// Base exception class for all club-related errors
abstract class ClubException implements Exception {
  final String message;
  final String? userId;
  final String? clubId;
  final String? vendorId;

  const ClubException({
    required this.message,
    this.userId,
    this.clubId,
    this.vendorId,
  });

  @override
  String toString() => message;
}
