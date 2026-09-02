import 'package:json_annotation/json_annotation.dart';
part 'constants.g.dart';

/// ShopStatus enum to represent the status of a shop
enum ShopStatus {
  active,
  inactive;

  // From String to ShopStatus conversion
  static ShopStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return ShopStatus.active;
      case 'inactive':
        return ShopStatus.inactive;
      default:
        throw ArgumentError('Unknown ShopStatus: $status');
    }
  }

  // From ShopStatus to String conversion
  String toShortString() {
    return toString().split('.').last;
  }
}

enum GiftType {
  code,
  auto;

  // From String to GiftType conversion
  static GiftType fromString(String type) {
    switch (type.toLowerCase()) {
      case 'code':
        return GiftType.code;
      case 'auto':
        return GiftType.auto;
      default:
        throw ArgumentError('Unknown GiftType: $type');
    }
  }

  // From GiftType to String conversion
  String toShortString() {
    return toString().split('.').last;
  }
}

@JsonEnum(alwaysCreate: true)
enum CampaignVisibility {
  @JsonKey(name: 'public')
  public,
  @JsonKey(name: 'private')
  private;

  // toString
  @override
  String toString() {
    return 'CampaignVisibility.${super.toString().split('.').last}';
  }

  // From String to CampaignVisibility conversion
  static CampaignVisibility fromString(String visibility) {
    switch (visibility.toLowerCase()) {
      case 'public':
        return CampaignVisibility.public;
      case 'private':
        return CampaignVisibility.private;
      default:
        throw ArgumentError('Unknown CampaignVisibility: $visibility');
    }
  }

  // From CampaignVisibility to String conversion
  String toShortString() {
    return toString().split('.').last;
  }
}

enum CampaignStatus {
  active,
  inactive;

  // From String to CampaignStatus conversion
  static CampaignStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return CampaignStatus.active;
      case 'inactive':
        return CampaignStatus.inactive;
      default:
        throw ArgumentError('Unknown CampaignStatus: $status');
    }
  }

  // From CampaignStatus to String conversion
  String toShortString() {
    return toString().split('.').last;
  }
}

// Friendship Actions
enum FriendshipAction {
  accept,
  reject;

  // From String to FriendshipAction conversion
  static FriendshipAction fromString(String action) {
    switch (action.toLowerCase()) {
      case 'accept':
        return FriendshipAction.accept;
      case 'reject':
        return FriendshipAction.reject;
      default:
        throw ArgumentError('Unknown FriendshipAction: $action');
    }
  }

  // From FriendshipAction to String conversion
  String toShortString() {
    return toString().split('.').last;
  }
}

// Friendship Status
enum FriendshipStatus {
  pending,
  accepted,
  rejected;

  // From String to FriendshipStatus conversion
  static FriendshipStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return FriendshipStatus.pending;
      case 'accepted':
        return FriendshipStatus.accepted;
      case 'rejected':
        return FriendshipStatus.rejected;
      default:
        throw ArgumentError('Unknown FriendshipStatus: $status');
    }
  }

  // From FriendshipStatus to String conversion
  String toShortString() {
    return toString().split('.').last;
  }
}

enum StaffRequestStatus {
  pending,
  accepted,
  rejected;

  // From String to StaffRequestStatus conversion
  static StaffRequestStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return StaffRequestStatus.pending;
      case 'accepted':
        return StaffRequestStatus.accepted;
      case 'rejected':
        return StaffRequestStatus.rejected;
      default:
        throw ArgumentError('Unknown StaffRequestStatus: $status');
    }
  }

  // From StaffRequestStatus to String conversion
  String toShortString() {
    return toString().split('.').last;
  }
}

enum StaffRequestAction {
  accept,
  reject;

  // From String to StaffRequestAction conversion
  static StaffRequestAction fromString(String action) {
    switch (action.toLowerCase()) {
      case 'accept':
        return StaffRequestAction.accept;
      case 'reject':
        return StaffRequestAction.reject;
      default:
        throw ArgumentError('Unknown StaffRequestAction: $action');
    }
  }

  // From StaffRequestAction to String conversion
  String toShortString() {
    return toString().split('.').last;
  }
}
