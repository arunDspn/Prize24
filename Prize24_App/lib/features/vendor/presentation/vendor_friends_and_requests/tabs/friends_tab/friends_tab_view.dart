import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prize24_app/common_widgets/show_toast.dart';
import 'package:prize24_app/features/vendor/domain/model/vendor_friend_model.dart';
import 'package:prize24_app/features/vendor/presentation/vendor_friends_and_requests/tabs/friends_tab/view_model/vendor_friends_controller.dart';
import 'package:prize24_app/routing/app_routes.dart';

// Design system colors from HTML
const Color _pageBg = Color(0xFFF8FAFC);
const Color _cardBg = Color(0xFFFFFFFF);
const Color _inputBg = Color(0xFFF1F5F9);
const Color _textMain = Color(0xFF1E293B);
const Color _textSub = Color(0xFF64748B);
const Color _brandStart = Color(0xFFEF4444);
const Color _brandEnd = Color(0xFFF97316);

class FriendsTabView extends ConsumerStatefulWidget {
  const FriendsTabView({super.key});

  @override
  ConsumerState<FriendsTabView> createState() => _FriendsTabViewState();
}

class _FriendsTabViewState extends ConsumerState<FriendsTabView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(vendorFriendsControllerProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final friendsState = ref.watch(vendorFriendsControllerProvider);

    return ColoredBox(
      color: _pageBg,
      child: RefreshIndicator(
        backgroundColor: _cardBg,
        color: _brandStart,
        onRefresh: () =>
            ref.read(vendorFriendsControllerProvider.notifier).refresh(),
        child: friendsState.when(
          data: (paginatedState) => _buildFriendsList(
            paginatedState.page,
            paginatedState.isLoadingMore,
          ),
          loading: _buildLoadingView,
          error: (error, stack) => _buildErrorView(error.toString()),
        ),
      ),
    );
  }

  Widget _buildFriendsList(
    List<VendorFriendModel> friends,
    bool isLoadingMore,
  ) {
    if (friends.isEmpty && !isLoadingMore) return _buildEmptyView();
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: friends.length + (isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == friends.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(_brandStart),
              ),
            ),
          );
        }
        return _FriendCard(friend: friends[index]);
      },
    );
  }

  Widget _buildEmptyView() {
    return Builder(
      builder: (context) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      color: _brandStart.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.people_outline,
                      size: 48,
                      color: _brandStart.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'No Friends Yet',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: _textMain,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Start adding friends to build your vendor network!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: _textSub,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () =>
                        context.push(AppRoutes.vendorSendFriendRequest),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [_brandStart, _brandEnd],
                        ),
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: _brandStart.withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.person_add, color: Colors.white, size: 18),
                          SizedBox(width: 8),
                          Text(
                            'Add Friends',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoadingView() {
    return const Center(
      child: SizedBox(
        width: 32,
        height: 32,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(_brandStart),
        ),
      ),
    );
  }

  Widget _buildErrorView(String error) {
    return Builder(
      builder: (context) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.error_outline,
                  size: 48,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Failed to Load Friends',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: _textMain,
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 8),
              Text(
                error,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: _textSub,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FriendCard extends ConsumerStatefulWidget {
  const _FriendCard({required this.friend});
  final VendorFriendModel friend;
  @override
  ConsumerState<_FriendCard> createState() => _FriendCardState();
}

class _FriendCardState extends ConsumerState<_FriendCard> {
  bool _showMenu = false;

  String _getInitials(String name) => name
      .split(' ')
      .take(2)
      .map((n) => n.isNotEmpty ? n[0] : '')
      .join()
      .toUpperCase();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _showMenu = false),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: _cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _inputBg),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [_brandStart, _brandEnd],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: _brandStart.withOpacity(0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        _getInitials(widget.friend.vendorName),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.friend.vendorName,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: _textMain,
                            fontFamily: 'Inter',
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        // const SizedBox(height: 4),
                        // Text(
                        //   'ID: ${widget.friend.userId}',
                        //   style: const TextStyle(
                        //     fontSize: 12,
                        //     color: _textSub,
                        //     fontFamily: 'Inter',
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () => setState(() => _showMenu = !_showMenu),
                  //   child: Container(
                  //     width: 32,
                  //     height: 32,
                  //     decoration: BoxDecoration(
                  //       shape: BoxShape.circle,
                  //       color: _showMenu ? _inputBg : Colors.transparent,
                  //     ),
                  //     child: const Icon(
                  //       Icons.more_vert,
                  //       size: 20,
                  //       color: _textSub,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            if (_showMenu)
              Positioned(
                right: 16,
                top: 56,
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  elevation: 8,
                  child: Container(
                    width: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: _inputBg),
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() => _showMenu = false);
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   SnackBar(
                            //     content: Text(
                            //       'Messaging ${widget.friend.vendorName}...',
                            //     ),
                            //     backgroundColor: _textMain,
                            //     behavior: SnackBarBehavior.floating,
                            //     shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(12),
                            //     ),
                            //   ),
                            // );
                            showToastAtTop(
                              context,
                              'Messaging ${widget.friend.vendorName}...',
                              true,
                            );
                          },
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.chat_bubble_outline,
                                  size: 18,
                                  color: _brandStart,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Message',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: _textMain,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(height: 1, color: _inputBg),
                        InkWell(
                          onTap: () {
                            setState(() => _showMenu = false);
                            _showRemoveDialog();
                          },
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(12),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.person_remove_outlined,
                                  size: 18,
                                  color: Colors.red,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Remove',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.red,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showRemoveDialog() {
    showDialog<void>(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: _cardBg,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 20),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person_remove_outlined,
                  size: 24,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Remove Friend',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: _textMain,
                  fontFamily: 'Inter',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Are you sure you want to remove ${widget.friend.vendorName}?',
                style: const TextStyle(
                  fontSize: 14,
                  color: _textSub,
                  fontFamily: 'Inter',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.of(ctx).pop(),
                      child: Container(
                        height: 44,
                        decoration: BoxDecoration(
                          border: Border.all(color: _inputBg),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: _textSub,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(ctx).pop();
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(
                        //     content:
                        //         Text('Removed ${widget.friend.vendorName}'),
                        //     backgroundColor: Colors.red,
                        //     behavior: SnackBarBehavior.floating,
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(12),
                        //     ),
                        //   ),
                        // );
                        showToastAtTop(
                          context,
                          'Removed ${widget.friend.vendorName}',
                          true,
                        );
                      },
                      child: Container(
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text(
                            'Remove',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
