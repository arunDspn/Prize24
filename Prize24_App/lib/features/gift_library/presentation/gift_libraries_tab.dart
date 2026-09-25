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
    var name = library?.name ?? '';
    var description = library?.description ?? '';
    final saved = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          library == null ? 'Create Gift Library' : 'Edit Gift Library',
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: name,
              onChanged: (value) => name = value,
              decoration: const InputDecoration(labelText: 'Library name'),
            ),
            TextFormField(
              initialValue: description,
              onChanged: (value) => description = value,
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
              final submittedName = name.trim();
              final submittedDescription = description.trim();
              if (submittedName.isEmpty || submittedDescription.isEmpty) {
                return;
              }
              final service = ref.read(giftLibraryServiceProvider);
              if (library == null) {
                final userId = ref
                    .read(authControllerProvider)
                    .requireValue!
                    .userId;
                await service.createLibrary(
                  ownerVendorId: userId,
                  name: submittedName,
                  description: submittedDescription,
                );
              } else {
                await service.updateLibrary(
                  libraryId: library.id,
                  name: submittedName,
                  description: submittedDescription,
                );
              }
              if (context.mounted) Navigator.pop(context, true);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 75),
        child: FloatingActionButton.extended(
          onPressed: _openEditor,
          icon: const Icon(Icons.add_rounded),
          label: const Text('Gift Library'),
        ),
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
                          ? '${library.description}\n'
                                '${library.activeBucketCount} / 20 active buckets'
                          : '${library.description}\nArchived',
                    ),
                    isThreeLine: true,
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
  late Future<List<GiftLibraryBucketModel>> _buckets;
  late int _activeBucketCount;

  @override
  void initState() {
    super.initState();
    _activeBucketCount = widget.library.activeBucketCount;
    _reload();
  }

  void _reload() {
    _buckets = ref
        .read(giftLibraryServiceProvider)
        .listBuckets(widget.library.id);
  }

  Future<void> _openBucketEditor([GiftLibraryBucketModel? bucket]) async {
    if (bucket == null && _activeBucketCount >= 20) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('A Gift Library can have at most 20 active buckets.'),
        ),
      );
      return;
    }
    var name = bucket?.name ?? '';
    var description = bucket?.description ?? '';
    var count = bucket?.remainingCount.toString() ?? '';
    final saved = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(bucket == null ? 'Add Bucket' : 'Edit Bucket'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: name,
              onChanged: (value) => name = value,
              decoration: const InputDecoration(labelText: 'Bucket name'),
            ),
            TextFormField(
              initialValue: description,
              onChanged: (value) => description = value,
              decoration: const InputDecoration(labelText: 'Description'),
              minLines: 2,
              maxLines: 4,
            ),
            TextFormField(
              initialValue: count,
              onChanged: (value) => count = value,
              decoration: const InputDecoration(
                labelText: 'Remaining quantity',
              ),
              keyboardType: TextInputType.number,
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
              final submittedName = name.trim();
              final submittedDescription = description.trim();
              final remainingCount = int.tryParse(count.trim());
              final minimumCount = bucket == null ? 1 : 0;
              final validationMessage = bucket == null
                  ? 'Enter a name, description, and quantity '
                        'of at least 1.'
                  : 'Enter a name, description, and '
                        'non-negative quantity.';
              if (submittedName.isEmpty ||
                  submittedDescription.isEmpty ||
                  remainingCount == null ||
                  remainingCount < minimumCount) {
                ScaffoldMessenger.of(
                  this.context,
                ).showSnackBar(SnackBar(content: Text(validationMessage)));
                return;
              }
              final service = ref.read(giftLibraryServiceProvider);
              if (bucket == null) {
                await service.createBucket(
                  libraryId: widget.library.id,
                  name: submittedName,
                  description: submittedDescription,
                  remainingCount: remainingCount,
                );
              } else {
                await service.updateBucket(
                  libraryId: widget.library.id,
                  bucketId: bucket.id,
                  name: submittedName,
                  description: submittedDescription,
                  remainingCount: remainingCount,
                );
              }
              if (context.mounted) Navigator.pop(context, true);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if ((saved ?? false) && mounted) {
      setState(() {
        if (bucket == null) _activeBucketCount++;
        _reload();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.library.name)),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 75),
        child: FloatingActionButton.extended(
          onPressed: _activeBucketCount >= 20 ? null : _openBucketEditor,
          icon: const Icon(Icons.add_rounded),
          label: const Text('Bucket'),
        ),
      ),
      body: FutureBuilder<List<GiftLibraryBucketModel>>(
        future: _buckets,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Unable to load buckets: ${snapshot.error}'),
            );
          }
          final buckets = snapshot.data ?? const [];
          _activeBucketCount = buckets
              .where((bucket) => bucket.isActive)
              .length;
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
            children: [
              Text(
                'Active buckets: $_activeBucketCount / 20',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              if (buckets.isEmpty)
                const Padding(
                  padding: EdgeInsets.only(top: 48),
                  child: Center(child: Text('No buckets yet.')),
                )
              else
                ...buckets.map((bucket) {
                  final inventory = bucket.remainingCount == 0
                      ? 'Out of stock'
                      : 'Remaining: ${bucket.remainingCount}';
                  return ListTile(
                    enabled: bucket.isActive,
                    leading: const Icon(Icons.inventory_2_rounded),
                    title: Text(bucket.name),
                    subtitle: Text(
                      bucket.isActive
                          ? '${bucket.description}\n$inventory'
                          : '${bucket.description}\nArchived',
                    ),
                    isThreeLine: true,
                    trailing: bucket.isActive
                        ? PopupMenuButton<String>(
                            onSelected: (value) async {
                              if (value == 'edit') {
                                await _openBucketEditor(bucket);
                              }
                              if (value == 'archive') {
                                await ref
                                    .read(giftLibraryServiceProvider)
                                    .archiveBucket(
                                      libraryId: widget.library.id,
                                      bucketId: bucket.id,
                                    );
                                if (mounted) {
                                  setState(() {
                                    _activeBucketCount--;
                                    _reload();
                                  });
                                }
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
                }),
            ],
          );
        },
      ),
    );
  }
}
