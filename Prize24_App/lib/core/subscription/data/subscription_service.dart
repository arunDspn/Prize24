import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prize24_app/bootstrap.dart';
import 'package:prize24_app/core/subscription/data/subscription_metadata_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'subscription_service.g.dart';

class SubscriptionService {
  Future<SubscriptionMetadata> getEntitlementMetadata(
    String entitlementId,
  ) async {
    try {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('subscription_plans')
          .doc(entitlementId)
          .get();

      if (!docSnapshot.exists) {
        throw Exception(
          'Entitlement metadata not found for ID: $entitlementId',
        );
      }

      return SubscriptionMetadata.fromJson(docSnapshot.data()!);
    } catch (e, stackTrace) {
      logger.e(
        'Failed to get entitlement metadata for $entitlementId: $e',
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}

@Riverpod(keepAlive: true)
SubscriptionService subscriptionService(Ref ref) {
  return SubscriptionService();
}
