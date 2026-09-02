import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prize24_app/common_widgets/buttons/app_primary_button.dart';
import 'package:prize24_app/configs/assets.dart';
import 'package:prize24_app/features/clubs/presentation/user/user_club_list/view_model/user_club_list_controller.dart';
import 'package:prize24_app/features/clubs/presentation/widgets/club_progress_card.dart';
import 'package:prize24_app/routing/app_routes.dart';

class UserClubListPage extends ConsumerWidget {
  const UserClubListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(userClubListControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Club List'),
      ),
      body: state.when(
        data: (clubs) {
          if (clubs.isEmpty) {
            return const _EmptyState();
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: clubs.length,
            itemBuilder: (context, index) {
              final club = clubs[index];
              return ClubProgressCard(
                clubData: club,
                onTap: () {
                  context.push(AppRoutes.userClubDetails, extra: club);
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) =>
            const Center(child: Text('Error loading clubs')),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Empty state
          // Add Empty Club Logo
          Image.asset(AppAssets.clubEmpty),
          const SizedBox(height: 50),
          const Text(
            'Start your first streak',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Gilroy',
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Show your QR code to our partners to unlock streaks, '
            'earn gifts, and level up with each visit.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20),

          AppPrimaryButton(
            text: 'Show My QR Code',
            onPressed: () {
              context.push(AppRoutes.qrScanScreen);
            },
            icon: Icons.qr_code,
          )
          // Add more ListTiles as needed
        ],
      ),
    );
  }
}
