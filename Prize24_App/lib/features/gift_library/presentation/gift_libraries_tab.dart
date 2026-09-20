import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/features/gift_library/data/gift_library_service.dart';
import 'package:prize24_app/features/gift_library/domain/gift_library_models.dart';
import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';

class GiftLibrariesTab extends ConsumerStatefulWidget {
  const GiftLibrariesTab({super.key});

  @override
  ConsumerState<GiftLibrariesTab> createState() => _GiftLibrariesTabState();
}

class _GiftLibrariesTabState extends ConsumerState<GiftLibrariesTab> {
  late Future<List<GiftLibraryModel>> _libraries;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    final userId = ref.read(authControllerProvider).requireValue!.userId;
    _libraries = ref
        .read(giftLibraryServiceProvider)
        .listOwnedLibraries(userId);
  }

  Future<void> _openEditor([GiftLibraryModel? library]) async {
    final nameController = TextEditingController(text: library?.name);
    final descriptionController = TextEditingController(
      text: library?.description,
    );
    final saved = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          library == null ? 'Create Gift Library' : 'Edit Gift Library',
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Library name'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              minLines: 2,
              maxLines: 4,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              final name = nameController.text.trim();
              final description = descriptionController.text.trim();
              if (name.isEmpty || description.isEmpty) return;
              final service = ref.read(giftLibraryServiceProvider);
              if (library == null) {
                final userId = ref
                    .read(authControllerProvider)
                    .requireValue!
                    .userId;
                await service.createLibrary(
                  ownerVendorId: userId,
                  name: name,
                  description: description,
                );
              } else {
                await service.updateLibrary(
                  libraryId: library.id,
                  name: name,
                  description: description,
                );
              }
              if (context.mounted) Navigator.pop(context, true);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
    nameController.dispose();
    descriptionController.dispose();
    if ((saved ?? false) && mounted) setState(_reload);
  }

  Future<void> _archive(GiftLibraryModel library) async {
    try {
      final service = ref.read(giftLibraryServiceProvider);
      final usage = await service.getLibraryUsage(library.id);
      if (!mounted) return;
      final archiveGuidance = usage.canArchive
          ? 'The library can be archived.'
          : 'Detach it from all shops and resolve pending rewards first.';
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Archive Gift Library?'),
          content: Text(
            'Attached shops: ${usage.attachedShopCount}\n'
            'Pending rewards: ${usage.pendingRewardCount}\n\n'
            '$archiveGuidance',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: usage.canArchive
                  ? () => Navigator.pop(context, true)
                  : null,
              child: const Text('Archive'),
            ),
          ],
        ),
      );
      if (confirmed != true) return;
      await service.archiveLibrary(library.id);
      if (mounted) setState(_reload);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unable to archive library: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openEditor,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Gift Library'),
      ),
      body: FutureBuilder<List<GiftLibraryModel>>(
        future: _libraries,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Unable to load Gift Libraries: ${snapshot.error}'),
            );
          }
          final libraries = snapshot.data ?? const [];
          if (libraries.isEmpty) {
            return const Center(
              child: Text('Create a Gift Library to reuse gifts across shops.'),
            );
          }
          return RefreshIndicator(
            onRefresh: () async => setState(_reload),
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
              itemCount: libraries.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final library = libraries[index];
                return Card(
                  child: ListTile(
                    enabled: library.isActive,
                    leading: const CircleAvatar(
                      child: Icon(Icons.card_giftcard_rounded),
                    ),
                    title: Text(library.name),
                    subtitle: Text(
                      library.isActive
                          ? library.description
                          : '${library.description}\nArchived',
                    ),
                    isThreeLine: !library.isActive,
                    onTap: library.isActive
                        ? () async {
                            await Navigator.of(context).push<void>(
                              MaterialPageRoute(
                                builder: (_) =>
                                    GiftLibraryDetailPage(library: library),
                              ),
                            );
                            if (mounted) setState(_reload);
                          }
                        : null,
                    trailing: library.isActive
                        ? PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'edit') _openEditor(library);
                              if (value == 'archive') _archive(library);
                            },
                            itemBuilder: (_) => const [
                              PopupMenuItem(value: 'edit', child: Text('Edit')),
                              PopupMenuItem(
                                value: 'archive',
                                child: Text('Archive'),
                              ),
                            ],
                          )
                        : null,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class GiftLibraryDetailPage extends ConsumerStatefulWidget {
  const GiftLibraryDetailPage({required this.library, super.key});

  final GiftLibraryModel library;

  @override
  ConsumerState<GiftLibraryDetailPage> createState() =>
      _GiftLibraryDetailPageState();
}

class _GiftLibraryDetailPageState extends ConsumerState<GiftLibraryDetailPage> {
  late Future<List<LibraryGiftModel>> _gifts;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    _gifts = ref.read(giftLibraryServiceProvider).listGifts(widget.library.id);
  }

  Future<void> _openGiftEditor([LibraryGiftModel? gift]) async {
    final nameController = TextEditingController(text: gift?.name);
    final descriptionController = TextEditingController(
      text: gift?.description,
    );
    final saved = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(gift == null ? 'Add Gift' : 'Edit Gift'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Gift name'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              minLines: 2,
              maxLines: 4,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              final name = nameController.text.trim();
              final description = descriptionController.text.trim();
              if (name.isEmpty || description.isEmpty) return;
              final service = ref.read(giftLibraryServiceProvider);
              if (gift == null) {
                await service.createGift(
                  libraryId: widget.library.id,
                  name: name,
                  description: description,
                );
              } else {
                await service.updateGift(
                  libraryId: widget.library.id,
                  giftId: gift.id,
                  name: name,
                  description: description,
                );
              }
              if (context.mounted) Navigator.pop(context, true);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
    nameController.dispose();
    descriptionController.dispose();
    if ((saved ?? false) && mounted) setState(_reload);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.library.name)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openGiftEditor,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Gift'),
      ),
      body: FutureBuilder<List<LibraryGiftModel>>(
        future: _gifts,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final gifts = snapshot.data ?? const [];
          if (gifts.isEmpty) return const Center(child: Text('No gifts yet.'));
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
            itemCount: gifts.length,
            separatorBuilder: (_, _) => const Divider(),
            itemBuilder: (context, index) {
              final gift = gifts[index];
              return ListTile(
                enabled: gift.isActive,
                leading: const Icon(Icons.redeem_rounded),
                title: Text(gift.name),
                subtitle: Text(
                  gift.isActive
                      ? gift.description
                      : '${gift.description}\nArchived',
                ),
                isThreeLine: !gift.isActive,
                trailing: gift.isActive
                    ? PopupMenuButton<String>(
                        onSelected: (value) async {
                          if (value == 'edit') await _openGiftEditor(gift);
                          if (value == 'archive') {
                            await ref
                                .read(giftLibraryServiceProvider)
                                .archiveGift(
                                  libraryId: widget.library.id,
                                  giftId: gift.id,
                                );
                            if (mounted) setState(_reload);
                          }
                        },
                        itemBuilder: (_) => const [
                          PopupMenuItem(value: 'edit', child: Text('Edit')),
                          PopupMenuItem(
                            value: 'archive',
                            child: Text('Archive'),
                          ),
                        ],
                      )
                    : null,
              );
            },
          );
        },
      ),
    );
  }
}
