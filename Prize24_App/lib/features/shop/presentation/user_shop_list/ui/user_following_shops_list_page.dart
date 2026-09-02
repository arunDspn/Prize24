import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prize24_app/configs/assets.dart';
import 'package:prize24_app/features/shop/presentation/user_shop_list/view_model/user_following_shops_list_controller.dart';
import 'package:prize24_app/features/shop/presentation/widgets/shop_list_with_streak.dart';
import 'package:prize24_app/features/shop/presentation/widgets/view_model/user_shop_notification_controller.dart';
import 'package:prize24_app/routing/app_routes.dart';

class UserFollowingShopsListPage extends ConsumerWidget {
  const UserFollowingShopsListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listState = ref.watch(userFollowingShopsListControllerProvider);

    ref.listen(
      userShopNotificationControllerProvider,
      (previous, next) {
        next.whenOrNull(
          data: (data) {
            if (data != null) {
              // Update the shop notification status in the list controller
              ref
                  .read(userFollowingShopsListControllerProvider.notifier)
                  .updateShopNotificationStatus(
                    shopId: data.$1,
                    enable: data.$2,
                  );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    data.$2
                        ? 'Notifications enabled for shop'
                        : 'Notifications disabled for shop',
                  ),
                ),
              );
            }
          },
        );
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Streaks'),
        centerTitle: true,
        elevation: 0,
        // actions: [
        //   // Icon Button to scan QR code and follow new shops
        //   IconButton(
        //     icon: const Icon(Icons.qr_code_scanner),
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute<void>(
        //           builder: (context) {
        //             // Navigate to the QR code scanning page
        //             return UserScanShopQrToFollowPage(
        //               onCodeDetected: (code) {
        //                 // Handle the scanned QR code here
        //                 // For example, follow the shop with the given code
        //               },
        //             );
        //           },
        //         ),
        //       );
        //     },
        //     tooltip: 'Scan QR Code to Follow Shop',
        //   ),
        // ],
      ),
      body: listState.when(
        data: (data) {
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(userFollowingShopsListControllerProvider);
            },
            child: data.isEmpty
                ? ListView(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height - 200,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Icon(
                              //   Icons.store_outlined,
                              //   size: 64,
                              //   color: Colors.grey[400],
                              // ),
                              Image.asset(
                                AppAssets.shopFollowingEmpty,
                                fit: BoxFit.contain,
                                scale: 1,
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Start your first streak',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  'Show your QR code to our partners to unlock streaks, earn gifts, and level up with each visit.',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[500],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final shop = data[index];
                      return ShopListWithStreak(
                        shopData: shop,
                        onTap: () {
                          context.push(AppRoutes.userShopDetails, extra: shop);
                        },
                      );
                    },
                  ),
          );
        },
        error: (error, stackTrace) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.red[300],
                ),
                const SizedBox(height: 16),
                Text(
                  'Error loading shops',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    error.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    ref.invalidate(userFollowingShopsListControllerProvider);
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                ),
              ],
            ),
          );
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
