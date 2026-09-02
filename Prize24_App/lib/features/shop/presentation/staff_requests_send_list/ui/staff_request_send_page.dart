import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/common_widgets/common_widgets.dart';
import 'package:prize24_app/common_widgets/show_toast.dart';
import 'package:prize24_app/core/constants.dart';
import 'package:prize24_app/features/shop/presentation/staff_requests_send_list/view_model/staff_request_send_controller.dart';
import 'package:prize24_app/features/shop_staffs/domain/model/staff_request_send_model.dart';

part 'components/requests_list.dart';
part 'components/staff_request_card.dart';
part 'components/loading_view.dart';
part 'components/empty_view.dart';
part 'components/status_chip.dart';
part 'components/info_row.dart';

class StaffRequestSendListPage extends ConsumerStatefulWidget {
  const StaffRequestSendListPage(this.shopId, {super.key});

  final String shopId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StaffRequestSendListPageState();
}

class _StaffRequestSendListPageState
    extends ConsumerState<StaffRequestSendListPage> {
  @override
  Widget build(BuildContext context) {
    final staffRequestsAsync =
        ref.watch(staffRequestSendControllerProvider(shopId: widget.shopId));

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Staff Requests Sent',
        ),
        actions: [
          IconButton(
            onPressed: () => ref.refresh(
                staffRequestSendControllerProvider(shopId: widget.shopId)),
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(staffRequestSendControllerProvider);
        },
        child: staffRequestsAsync.when(
          loading: () => const _LoadingView(),
          error: (error, stackTrace) => _ErrorView(
            error: error.toString(),
            onRetry: () => ref.refresh(
                staffRequestSendControllerProvider(shopId: widget.shopId)),
          ),
          data: (requests) {
            if (requests.isEmpty) {
              return const _EmptyView();
            }
            return _RequestsList(requests: requests, shopId: widget.shopId);
          },
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({
    required this.error,
    required this.onRetry,
  });

  final String error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Failed to load staff requests',
              style: TextStyle(
                fontFamily: 'Gilroy',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.error,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              error,
              style: const TextStyle(
                fontFamily: 'Gilroy',
                fontSize: 14,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            TPrimaryButton(
              onPressed: onRetry,
              text: 'Try Again',
              icon: Icons.refresh,
              width: 150,
            ),
          ],
        ),
      ),
    );
  }
}
