import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/features/shop/domain/model/user_following_shop_model.dart';
import 'package:prize24_app/features/shop/presentation/user_shop_detail_with_streak/ui/components/club_gift_history/ui/componets/club_gifts_history_view.dart';
import 'package:prize24_app/features/shop/presentation/widgets/shop_list_with_streak.dart';

/// Color constants matching the HTML design
class _ShopDetailColors {
  static const Color pageBg = Color(0xFFF8FAFC);
  static const Color pageCard = Color(0xFFFFFFFF);
  static const Color pageSubtle = Color(0xFFE2E8F0);
  static const Color textMain = Color(0xFF0F172A);
  static const Color textSub = Color(0xFF64748B);
  static const Color brandStart = Color(0xFFEF4444);
  static const Color brandEnd = Color(0xFFF97316);
}

class UserShopDetailWithStreakPage extends ConsumerWidget {
  const UserShopDetailWithStreakPage({required this.shopData, super.key});

  final UserFollowingShopModel shopData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: _ShopDetailColors.pageBg,
      appBar: AppBar(
        backgroundColor: _ShopDetailColors.pageBg,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: _ShopDetailColors.pageSubtle),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.arrow_back,
              color: _ShopDetailColors.textSub,
              size: 20,
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Streaks',
              style: TextStyle(
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: _ShopDetailColors.textMain,
              ),
            ),
            Text(
              'Keep it up to win prizes!',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: _ShopDetailColors.textSub,
              ),
            ),
          ],
        ),
        // actions: [
        //   Container(
        //     margin: const EdgeInsets.only(right: 16),
        //     child: Container(
        //       width: 40,
        //       height: 40,
        //       decoration: BoxDecoration(
        //         color: Colors.white,
        //         shape: BoxShape.circle,
        //         border: Border.all(color: _ShopDetailColors.pageSubtle),
        //         boxShadow: [
        //           BoxShadow(
        //             color: Colors.black.withOpacity(0.05),
        //             blurRadius: 10,
        //             offset: const Offset(0, 2),
        //           ),
        //         ],
        //       ),
        //       child: IconButton(
        //         icon: const Icon(
        //           Icons.tune,
        //           color: _ShopDetailColors.textSub,
        //           size: 18,
        //         ),
        //         onPressed: () {
        //           // Filter/settings action
        //         },
        //       ),
        //     ),
        // ),
        // Show club QR code button
        // IconButton(
        //   icon: const Icon(Icons.qr_code),
        //   onPressed: () {
        //     final userId =
        //         ref.read(authControllerProvider).requireValue!.userId;
        //     showDialog<void>(
        //       context: context,
        //       builder: (context) {
        //         return AlertDialog(
        //           title: const Text('Club QR Code'),
        //           content: PrettyQrView.data(
        //             data: 'club:${clubData.clubId}|user:$userId',
        //             errorCorrectLevel: QrErrorCorrectLevel.M,
        //           ),
        //           actions: [
        //             TextButton(
        //               onPressed: () {
        //                 Navigator.of(context).pop();
        //               },
        //               child: const Text('Close'),
        //             ),
        //           ],
        //         );
        //       },
        //     );
        //   },
        // ),
        // ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          ShopListWithStreak(shopData: shopData),
          const SizedBox(height: 20),
          Expanded(
            child: ShopGiftsHistoryView(
              shopId: shopData.shopId,
            ),
          ),
        ],
      ),
    );
  }
}
