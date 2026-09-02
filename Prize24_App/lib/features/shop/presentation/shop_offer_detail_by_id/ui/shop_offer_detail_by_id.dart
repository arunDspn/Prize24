import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/features/shop/presentation/shop_offer_detail_by_id/view_model/shop_offer_by_id_controller.dart';

class ShopOfferDetailById extends ConsumerWidget {
  const ShopOfferDetailById({
    required this.shopOfferId,
    required this.shopId,
    super.key,
  });
  final String shopOfferId;
  final String shopId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(
      shopOfferByIdControllerProvider(
        shopOfferId: shopOfferId,
        shopId: shopId, // You might want to pass the actual shopId here
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offer Details'),
      ),
      body: state.when(
        data: (shopOffer) {
          if (shopOffer == null) {
            return const Center(
              child: Text('Shop Offer not found'),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  shopOffer.name,
                ),
                const SizedBox(height: 8),
                Text(shopOffer.description),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
