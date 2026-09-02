// import 'package:flutter/material.dart';
// import 'package:prize24_app/features/campaign/domain/models/campaign_model.dart';
// import 'package:prize24_app/features/vendor/presentation/vendor_home_content/ui/components/vendors_campaign_list/components/campaign_card.dart';
// import 'package:prize24_app/core/constants.dart';

// class CampaignListDemo extends StatelessWidget {
//   const CampaignListDemo({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Sample campaign data for demonstration
//     final sampleCampaigns = [
//       CampaignModel(
//         id: '1',
//         title: 'Summer Sale Campaign',
//         description:
//             'Get amazing discounts on all summer items. Limited time offer with exclusive deals for early birds.',
//         vendorId: 'vendor1',
//         vendorName: 'Fashion Hub',
//         totalParticipants: 125,
//         totalGifts: 50,
//         visibility: CampaignVisibility.public,
//         allowedGiftType: GiftType.auto,
//         createdAt: DateTime.now().subtract(const Duration(days: 2)),
//         updatedAt: DateTime.now().subtract(const Duration(hours: 3)),
//       ),
//       CampaignModel(
//         id: '2',
//         title: 'Tech Gadgets Giveaway',
//         description:
//             'Win the latest smartphones, laptops, and accessories. Premium tech gifts await!',
//         vendorId: 'vendor2',
//         vendorName: 'TechStore Pro',
//         totalParticipants: 89,
//         totalGifts: 25,
//         visibility: CampaignVisibility.private,
//         allowedGiftType: GiftType.code,
//         createdAt: DateTime.now().subtract(const Duration(days: 5)),
//         updatedAt: DateTime.now().subtract(const Duration(days: 1)),
//       ),
//       CampaignModel(
//         id: '3',
//         title: 'Food Festival Special',
//         description:
//             'Delicious food coupons and vouchers for the best restaurants in the city.',
//         vendorId: 'vendor3',
//         vendorName: 'Foodie Paradise',
//         totalParticipants: 234,
//         totalGifts: 100,
//         visibility: CampaignVisibility.public,
//         allowedGiftType: GiftType.auto,
//         createdAt: DateTime.now().subtract(const Duration(hours: 6)),
//         updatedAt: DateTime.now().subtract(const Duration(minutes: 30)),
//       ),
//     ];

//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: const Text(
//           'Campaign List Demo',
//           style: TextStyle(
//             color: Colors.white,
//             fontFamily: 'Gilroy',
//           ),
//         ),
//       ),
//       body: ListView.builder(
//         padding: const EdgeInsets.symmetric(vertical: 8),
//         itemCount: sampleCampaigns.length,
//         itemBuilder: (context, index) {
//           return CampaignCard(campaign: sampleCampaigns[index]);
//         },
//       ),
//     );
//   }
// }
