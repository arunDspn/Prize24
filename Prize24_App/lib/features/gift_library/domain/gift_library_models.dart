import 'package:cloud_firestore/cloud_firestore.dart';

DateTime _readDate(Object? value) {
  if (value is Timestamp) return value.toDate();
  if (value is DateTime) return value;
  return DateTime.fromMillisecondsSinceEpoch(0);
}

class GiftLibraryModel {
  const GiftLibraryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.ownerVendorId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GiftLibraryModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data() ?? const <String, dynamic>{};
    return GiftLibraryModel(
      id: document.id,
      name: data['name'] as String? ?? '',
      description: data['description'] as String? ?? '',
      ownerVendorId: data['ownerVendorId'] as String? ?? '',
      status: data['status'] as String? ?? 'active',
      createdAt: _readDate(data['createdAt']),
      updatedAt: _readDate(data['updatedAt']),
    );
  }

  factory GiftLibraryModel.fromMap(Map<String, dynamic> data) {
    return GiftLibraryModel(
      id: data['id'] as String? ?? '',
      name: data['name'] as String? ?? '',
      description: data['description'] as String? ?? '',
      ownerVendorId: data['ownerVendorId'] as String? ?? '',
      status: data['status'] as String? ?? 'active',
      createdAt: _readDate(data['createdAt']),
      updatedAt: _readDate(data['updatedAt']),
    );
  }

  final String id;
  final String name;
  final String description;
  final String ownerVendorId;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  bool get isActive => status == 'active';
}

class LibraryGiftModel {
  const LibraryGiftModel({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LibraryGiftModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    return LibraryGiftModel.fromMap(<String, dynamic>{
      'id': document.id,
      ...?document.data(),
    });
  }

  factory LibraryGiftModel.fromMap(Map<String, dynamic> data) {
    return LibraryGiftModel(
      id: data['id'] as String? ?? '',
      name: data['name'] as String? ?? '',
      description: data['description'] as String? ?? '',
      status: data['status'] as String? ?? 'active',
      createdAt: _readDate(data['createdAt']),
      updatedAt: _readDate(data['updatedAt']),
    );
  }

  final String id;
  final String name;
  final String description;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  bool get isActive => status == 'active';
}

class AttachedGiftLibraryModel {
  const AttachedGiftLibraryModel({required this.library, required this.gifts});

  final GiftLibraryModel? library;
  final List<LibraryGiftModel> gifts;
}

class GiftLibraryUsage {
  const GiftLibraryUsage({
    required this.attachedShopCount,
    required this.pendingRewardCount,
    required this.canArchive,
  });

  factory GiftLibraryUsage.fromMap(Map<String, dynamic> data) {
    return GiftLibraryUsage(
      attachedShopCount: (data['attachedShopCount'] as num?)?.toInt() ?? 0,
      pendingRewardCount: (data['pendingRewardCount'] as num?)?.toInt() ?? 0,
      canArchive: data['canArchive'] as bool? ?? false,
    );
  }

  final int attachedShopCount;
  final int pendingRewardCount;
  final bool canArchive;
}

class RewardOpportunityListItem {
  const RewardOpportunityListItem({
    required this.id,
    required this.userId,
    required this.milestone,
    required this.cumulativeStreak,
    required this.availableSources,
    required this.cumulativeBillSum,
    required this.milestoneCycleBillSum,
    required this.createdAt,
    this.selectedSource,
  });

  factory RewardOpportunityListItem.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data() ?? const <String, dynamic>{};
    return RewardOpportunityListItem(
      id: document.id,
      userId: data['userId'] as String? ?? '',
      milestone: (data['milestone'] as num?)?.toInt() ?? 0,
      cumulativeStreak:
          (data['cumulativeStreak'] as num?)?.toInt() ??
          (data['milestone'] as num?)?.toInt() ??
          0,
      availableSources: (data['availableSources'] as List<dynamic>? ?? const [])
          .whereType<String>()
          .toList(),
      selectedSource: data['selectedSource'] as String?,
      cumulativeBillSum: (data['cumulativeBillSum'] as num?)?.toDouble() ?? 0,
      milestoneCycleBillSum:
          (data['milestoneCycleBillSum'] as num?)?.toDouble() ?? 0,
      createdAt: _readDate(data['createdAt']),
    );
  }

  final String id;
  final String userId;
  final int milestone;
  final int cumulativeStreak;
  final List<String> availableSources;
  final String? selectedSource;
  final double cumulativeBillSum;
  final double milestoneCycleBillSum;
  final DateTime createdAt;
}

class RewardResolutionResult {
  const RewardResolutionResult({
    required this.outcome,
    this.giftName,
    this.giftDescription,
    this.userGiftId,
  });

  factory RewardResolutionResult.fromMap(Map<String, dynamic> data) {
    return RewardResolutionResult(
      outcome: data['outcome'] as String? ?? 'unavailable',
      giftName: data['giftName'] as String?,
      giftDescription: data['giftDescription'] as String?,
      userGiftId: data['userGiftId'] as String?,
    );
  }

  final String outcome;
  final String? giftName;
  final String? giftDescription;
  final String? userGiftId;
}
