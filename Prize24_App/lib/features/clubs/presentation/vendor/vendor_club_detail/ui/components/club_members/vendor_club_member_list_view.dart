import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prize24_app/features/clubs/presentation/vendor/vendor_club_detail/ui/components/club_members/view_model/club_member_lists_controller.dart';
import 'package:prize24_app/routing/app_routes.dart';

class VendorClubMemberListView extends ConsumerWidget {
  const VendorClubMemberListView(this.clubId, {super.key});
  final String clubId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(
      clubMemberListsControllerProvider(clubId: clubId),
    );
    return state.when(
      data: (data) {
        // If empty
        if (data.isEmpty) {
          return const Center(child: Text('No members found'));
        }
        // Else show list
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: data.length,
          itemBuilder: (context, index) {
            final member = data[index];
            return ListTile(
              title: Text(member.userName),
              subtitle: Text(member.joinedAt.toString()),
              onTap: () {
                // Navigate to member detail page
                context.push(AppRoutes.clubMemberDetails, extra: member);
              },
            );
          },
        );
      },
      error: (error, stackTrace) {
        return const Center(child: Text('Error loading members'));
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
