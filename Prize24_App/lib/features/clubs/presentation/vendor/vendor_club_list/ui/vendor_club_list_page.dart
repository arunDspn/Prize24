import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prize24_app/features/clubs/presentation/vendor/vendor_club_list/view_model/vendor_club_list_controller.dart';
import 'package:prize24_app/routing/app_routes.dart';

class VendorClubListPage extends ConsumerWidget {
  const VendorClubListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(vendorClubListControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vendor Club List'),
      ),
      body: state.when(
        data: (data) {
          if (data.isEmpty) {
            return const Center(
              child: Text('No clubs available. Tap + to create one.'),
            );
          }
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final club = data[index];
              return ListTile(
                title: Text(club.name),
                subtitle: Text(club.description),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  context.push(AppRoutes.vendorClubDetails, extra: club);
                },
              );
            },
          );
        },
        error: (error, stackTrace) {
          return Center(
            child: Text('Error loading clubs'),
          );
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(AppRoutes.createClub);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
