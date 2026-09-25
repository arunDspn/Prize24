import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/features/gift_library/data/gift_library_service.dart';
import 'package:prize24_app/features/gift_library/domain/gift_library_models.dart';
import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';

abstract final class _LibraryColors {
  static const background = Color(0xFFF8FAFC);
  static const text = Color(0xFF0F172A);
  static const supporting = Color(0xFF64748B);
  static const border = Color(0xFFE2E8F0);
  static const muted = Color(0xFFF1F5F9);
  static const brandStart = Color(0xFFFF5F6D);
  static const brandEnd = Color(0xFFFFC371);
  static const green = Color(0xFF16A34A);
  static const greenSurface = Color(0xFFF0FDF4);
  static const orange = Color(0xFFEA580C);
  static const orangeSurface = Color(0xFFFFF7ED);
  static const red = Color(0xFFDC2626);
  static const redSurface = Color(0xFFFEF2F2);
  static const blue = Color(0xFF2563EB);
  static const blueSurface = Color(0xFFEFF6FF);

  static const shadow = <BoxShadow>[
    BoxShadow(color: Color(0x0D0F172A), blurRadius: 20, offset: Offset(0, 8)),
  ];
}

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
      builder: (context) => _FeatureDialog(
        icon: Icons.card_giftcard_rounded,
        title: library == null ? 'Create Gift Library' : 'Edit Gift Library',
        subtitle: library == null
            ? 'Create a reusable collection of inventory buckets.'
            : 'Update the details shown across your shops.',
        body: Column(
          children: [
            _DialogField(
              label: 'Library name',
              initialValue: name,
              icon: Icons.drive_file_rename_outline_rounded,
              onChanged: (value) => name = value,
            ),
            const SizedBox(height: 16),
            _DialogField(
              label: 'Description',
              initialValue: description,
              icon: Icons.notes_rounded,
              onChanged: (value) => description = value,
              minLines: 3,
              maxLines: 5,
            ),
          ],
        ),
        primaryLabel: 'Save',
        onPrimary: () async {
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
        builder: (context) => _FeatureDialog(
          icon: Icons.archive_rounded,
          destructive: true,
          title: 'Archive Gift Library?',
          subtitle: archiveGuidance,
          body: Row(
            children: [
              Expanded(
                child: _MetricTile(
                  value: '${usage.attachedShopCount}',
                  label: 'Attached shops',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _MetricTile(
                  value: '${usage.pendingRewardCount}',
                  label: 'Pending rewards',
                ),
              ),
            ],
          ),
          primaryLabel: 'Archive',
          primaryEnabled: usage.canArchive,
          onPrimary: () async => Navigator.pop(context, true),
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
      backgroundColor: _LibraryColors.background,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 75),
        child: _GradientActionButton(
          onPressed: _openEditor,
          icon: const Icon(Icons.add_rounded),
          label: 'Gift Library',
        ),
      ),
      body: FutureBuilder<List<GiftLibraryModel>>(
        future: _libraries,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const _FeatureState(
              icon: Icons.card_giftcard_rounded,
              title: 'Loading Gift Libraries',
              description: 'Preparing your reusable gift collections.',
              loading: true,
            );
          }
          if (snapshot.hasError) {
            return _FeatureState(
              icon: Icons.cloud_off_rounded,
              title: 'Unable to load Gift Libraries',
              description: '${snapshot.error}',
              actionLabel: 'Try again',
              onAction: () => setState(_reload),
            );
          }
          final libraries = snapshot.data ?? const [];
          if (libraries.isEmpty) {
            return _FeatureState(
              icon: Icons.card_giftcard_rounded,
              title: 'No Gift Libraries yet',
              description: 'Create a Gift Library to reuse gifts across shops.',
              actionLabel: 'Create Gift Library',
              onAction: _openEditor,
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
                return _LibraryCard(
                  library: library,
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
                  onSelected: (value) {
                    if (value == 'edit') _openEditor(library);
                    if (value == 'archive') _archive(library);
                  },
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
      builder: (context) => _FeatureDialog(
        icon: Icons.inventory_2_rounded,
        title: bucket == null ? 'Add Bucket' : 'Edit Bucket',
        subtitle: bucket == null
            ? 'Add an inventory-controlled gift to this library.'
            : 'Update the gift details or available quantity.',
        body: Column(
          children: [
            _DialogField(
              label: 'Bucket name',
              initialValue: name,
              icon: Icons.redeem_rounded,
              onChanged: (value) => name = value,
            ),
            const SizedBox(height: 16),
            _DialogField(
              label: 'Description',
              initialValue: description,
              icon: Icons.notes_rounded,
              onChanged: (value) => description = value,
              minLines: 3,
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            _DialogField(
              label: 'Remaining quantity',
              initialValue: count,
              icon: Icons.inventory_rounded,
              onChanged: (value) => count = value,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        primaryLabel: 'Save',
        onPrimary: () async {
          final submittedName = name.trim();
          final submittedDescription = description.trim();
          final remainingCount = int.tryParse(count.trim());
          final minimumCount = bucket == null ? 1 : 0;
          final validationMessage = bucket == null
              ? 'Enter a name, description, and quantity of at least 1.'
              : 'Enter a name, description, and non-negative quantity.';
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
      ),
    );
    if ((saved ?? false) && mounted) {
      setState(() {
        if (bucket == null) _activeBucketCount++;
        _reload();
      });
    }
  }

  Future<void> _archiveBucket(GiftLibraryBucketModel bucket) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => _FeatureDialog(
        icon: Icons.archive_rounded,
        destructive: true,
        title: 'Archive this bucket?',
        subtitle:
            'Archived buckets cannot be restored and their inventory '
            'will no longer be assignable.',
        body: _MetricTile(
          value: '${bucket.remainingCount}',
          label: 'Remaining inventory',
        ),
        primaryLabel: 'Archive',
        onPrimary: () async => Navigator.pop(context, true),
      ),
    );
    if (confirmed != true) return;
    await ref
        .read(giftLibraryServiceProvider)
        .archiveBucket(libraryId: widget.library.id, bucketId: bucket.id);
    if (mounted) {
      setState(() {
        _activeBucketCount--;
        _reload();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _LibraryColors.background,
      appBar: _LibraryAppBar(title: widget.library.name),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: _GradientActionButton(
          onPressed: _activeBucketCount >= 20 ? null : _openBucketEditor,
          icon: const Icon(Icons.add_rounded),
          label: 'Add Bucket',
        ),
      ),
      body: FutureBuilder<List<GiftLibraryBucketModel>>(
        future: _buckets,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const _FeatureState(
              icon: Icons.inventory_2_rounded,
              title: 'Loading buckets',
              description: 'Checking your current gift inventory.',
              loading: true,
            );
          }
          if (snapshot.hasError) {
            return _FeatureState(
              icon: Icons.cloud_off_rounded,
              title: 'Unable to load buckets',
              description: '${snapshot.error}',
              actionLabel: 'Try again',
              onAction: () => setState(_reload),
            );
          }
          final buckets = snapshot.data ?? const [];
          _activeBucketCount = buckets
              .where((bucket) => bucket.isActive)
              .length;
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 108),
            children: [
              _LibrarySummaryCard(
                library: widget.library,
                activeBucketCount: _activeBucketCount,
              ),
              const SizedBox(height: 24),
              const Text(
                'Gift inventory',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: _LibraryColors.text,
                ),
              ),
              const SizedBox(height: 12),
              if (buckets.isEmpty)
                _InlineEmptyState(
                  onAdd: _activeBucketCount >= 20 ? null : _openBucketEditor,
                )
              else
                ...buckets.map((bucket) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _BucketCard(
                      bucket: bucket,
                      onSelected: bucket.isActive
                          ? (value) async {
                              if (value == 'edit') {
                                await _openBucketEditor(bucket);
                              }
                              if (value == 'archive') {
                                await _archiveBucket(bucket);
                              }
                            }
                          : null,
                    ),
                  );
                }),
            ],
          );
        },
      ),
    );
  }
}

class _LibraryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _LibraryAppBar({required this.title});

  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 64,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: const Border(bottom: BorderSide(color: _LibraryColors.border)),
      leadingWidth: 68,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20, top: 12, bottom: 12),
        child: Material(
          color: _LibraryColors.muted,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () => Navigator.maybePop(context),
            child: const Icon(Icons.arrow_back_rounded, size: 20),
          ),
        ),
      ),
      title: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 19,
          fontWeight: FontWeight.w700,
          color: _LibraryColors.text,
        ),
      ),
    );
  }
}

class _LibraryCard extends StatelessWidget {
  const _LibraryCard({
    required this.library,
    required this.onTap,
    required this.onSelected,
  });

  final GiftLibraryModel library;
  final VoidCallback? onTap;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _LibraryColors.border),
        boxShadow: _LibraryColors.shadow,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _GradientIcon(
                  icon: Icons.card_giftcard_rounded,
                  size: 50,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              library.name,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: _LibraryColors.text,
                              ),
                            ),
                          ),
                          _Badge(
                            label: library.isActive ? 'Active' : 'Archived',
                            color: library.isActive
                                ? _LibraryColors.green
                                : _LibraryColors.red,
                            background: library.isActive
                                ? _LibraryColors.greenSurface
                                : _LibraryColors.redSurface,
                          ),
                        ],
                      ),
                      const SizedBox(height: 7),
                      Text(
                        library.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 13,
                          height: 1.45,
                          color: _LibraryColors.supporting,
                        ),
                      ),
                      const SizedBox(height: 13),
                      Row(
                        children: [
                          _Badge(
                            label: '${library.activeBucketCount} / 20 buckets',
                            icon: Icons.inventory_2_outlined,
                            color: _LibraryColors.blue,
                            background: _LibraryColors.blueSurface,
                          ),
                          const Spacer(),
                          if (library.isActive)
                            PopupMenuButton<String>(
                              tooltip: 'Library actions',
                              color: Colors.white,
                              padding: EdgeInsets.zero,
                              onSelected: onSelected,
                              itemBuilder: (_) => const [
                                PopupMenuItem(
                                  value: 'edit',
                                  child: Text('Edit'),
                                ),
                                PopupMenuItem(
                                  value: 'archive',
                                  child: Text('Archive'),
                                ),
                              ],
                              icon: const Icon(
                                Icons.more_horiz_rounded,
                                color: _LibraryColors.supporting,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LibrarySummaryCard extends StatelessWidget {
  const _LibrarySummaryCard({
    required this.library,
    required this.activeBucketCount,
  });

  final GiftLibraryModel library;
  final int activeBucketCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _LibraryColors.border),
        boxShadow: _LibraryColors.shadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _GradientIcon(icon: Icons.card_giftcard_rounded, size: 56),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      library.name,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: _LibraryColors.text,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      library.description,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        height: 1.4,
                        color: _LibraryColors.supporting,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Text(
                'Active bucket usage',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _LibraryColors.supporting,
                ),
              ),
              const Spacer(),
              Text(
                '$activeBucketCount / 20',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: _LibraryColors.text,
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: (activeBucketCount / 20).clamp(0, 1),
              minHeight: 8,
              backgroundColor: _LibraryColors.muted,
              color: _LibraryColors.brandStart,
            ),
          ),
        ],
      ),
    );
  }
}

class _BucketCard extends StatelessWidget {
  const _BucketCard({required this.bucket, required this.onSelected});

  final GiftLibraryBucketModel bucket;
  final ValueChanged<String>? onSelected;

  @override
  Widget build(BuildContext context) {
    final archived = !bucket.isActive;
    final empty = bucket.remainingCount == 0;
    final low = bucket.remainingCount > 0 && bucket.remainingCount <= 5;
    final color = archived || empty
        ? _LibraryColors.red
        : low
        ? _LibraryColors.orange
        : _LibraryColors.green;
    final surface = archived || empty
        ? _LibraryColors.redSurface
        : low
        ? _LibraryColors.orangeSurface
        : _LibraryColors.greenSurface;
    final label = archived
        ? 'Archived'
        : empty
        ? 'Out of stock'
        : low
        ? 'Low stock · ${bucket.remainingCount}'
        : '${bucket.remainingCount} remaining';
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _LibraryColors.border),
        boxShadow: _LibraryColors.shadow,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(Icons.inventory_2_rounded, color: color),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bucket.name,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _LibraryColors.text,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  bucket.description,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13,
                    height: 1.4,
                    color: _LibraryColors.supporting,
                  ),
                ),
                const SizedBox(height: 12),
                _Badge(
                  label: label,
                  icon: archived
                      ? Icons.archive_outlined
                      : Icons.inventory_2_outlined,
                  color: color,
                  background: surface,
                ),
              ],
            ),
          ),
          if (onSelected != null)
            PopupMenuButton<String>(
              tooltip: 'Bucket actions',
              color: Colors.white,
              padding: EdgeInsets.zero,
              onSelected: onSelected,
              itemBuilder: (_) => const [
                PopupMenuItem(value: 'edit', child: Text('Edit')),
                PopupMenuItem(value: 'archive', child: Text('Archive')),
              ],
            ),
        ],
      ),
    );
  }
}

class _GradientIcon extends StatelessWidget {
  const _GradientIcon({required this.icon, required this.size});

  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_LibraryColors.brandStart, _LibraryColors.brandEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(size * .3),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33FF5F6D),
            blurRadius: 12,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Icon(icon, color: Colors.white, size: size * .48),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({
    required this.label,
    required this.color,
    required this.background,
    this.icon,
  });

  final String label;
  final Color color;
  final Color background;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 5),
          ],
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _GradientActionButton extends StatelessWidget {
  const _GradientActionButton({
    required this.onPressed,
    required this.icon,
    required this.label,
  });

  final VoidCallback? onPressed;
  final Widget icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    return Container(
      decoration: BoxDecoration(
        color: enabled ? null : _LibraryColors.border,
        gradient: enabled
            ? const LinearGradient(
                colors: [_LibraryColors.brandStart, _LibraryColors.brandEnd],
              )
            : null,
        borderRadius: BorderRadius.circular(18),
        boxShadow: enabled ? _LibraryColors.shadow : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(18),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 52),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: IconTheme(
                data: const IconThemeData(color: Colors.white, size: 21),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    icon,
                    const SizedBox(width: 9),
                    Text(
                      label,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FeatureState extends StatelessWidget {
  const _FeatureState({
    required this.icon,
    required this.title,
    required this.description,
    this.loading = false,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String description;
  final bool loading;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(28),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 420),
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: _LibraryColors.border),
            boxShadow: _LibraryColors.shadow,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _GradientIcon(icon: icon, size: 58),
              const SizedBox(height: 18),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: _LibraryColors.text,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13,
                  height: 1.5,
                  color: _LibraryColors.supporting,
                ),
              ),
              if (loading) ...[
                const SizedBox(height: 20),
                const CircularProgressIndicator(
                  color: _LibraryColors.brandStart,
                  strokeWidth: 2.5,
                ),
              ],
              if (actionLabel != null && onAction != null) ...[
                const SizedBox(height: 20),
                FilledButton.icon(
                  onPressed: onAction,
                  icon: const Icon(Icons.refresh_rounded),
                  label: Text(actionLabel!),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(0, 46),
                    backgroundColor: _LibraryColors.brandStart,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _InlineEmptyState extends StatelessWidget {
  const _InlineEmptyState({required this.onAdd});

  final VoidCallback? onAdd;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _LibraryColors.border),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.inventory_2_outlined,
            size: 38,
            color: _LibraryColors.supporting,
          ),
          const SizedBox(height: 12),
          const Text(
            'No buckets yet.',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: _LibraryColors.text,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Add your first gift and set its available quantity.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 13,
              color: _LibraryColors.supporting,
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: onAdd,
            icon: const Icon(Icons.add_rounded),
            label: const Text('Add Bucket'),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(0, 44),
              foregroundColor: _LibraryColors.brandStart,
              side: const BorderSide(color: _LibraryColors.brandStart),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DialogField extends StatelessWidget {
  const _DialogField({
    required this.label,
    required this.initialValue,
    required this.icon,
    required this.onChanged,
    this.minLines = 1,
    this.maxLines = 1,
    this.keyboardType,
  });

  final String label;
  final String initialValue;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final int minLines;
  final int maxLines;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: _LibraryColors.text,
          ),
        ),
        const SizedBox(height: 7),
        TextFormField(
          initialValue: initialValue,
          onChanged: onChanged,
          minLines: minLines,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: const TextStyle(fontFamily: 'Inter', fontSize: 14),
          decoration: InputDecoration(
            filled: true,
            fillColor: _LibraryColors.muted,
            prefixIcon: Icon(icon, color: _LibraryColors.supporting),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: _LibraryColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: _LibraryColors.brandStart,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _LibraryColors.muted,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: _LibraryColors.text,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 11,
              color: _LibraryColors.supporting,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureDialog extends StatefulWidget {
  const _FeatureDialog({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.body,
    required this.primaryLabel,
    required this.onPrimary,
    this.primaryEnabled = true,
    this.destructive = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Widget body;
  final String primaryLabel;
  final Future<void> Function() onPrimary;
  final bool primaryEnabled;
  final bool destructive;

  @override
  State<_FeatureDialog> createState() => _FeatureDialogState();
}

class _FeatureDialogState extends State<_FeatureDialog> {
  bool _busy = false;

  Future<void> _submit() async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      await widget.onPrimary();
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unable to complete action: $error')),
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final accent = widget.destructive
        ? _LibraryColors.red
        : _LibraryColors.brandStart;
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 480),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: _LibraryColors.border),
          boxShadow: _LibraryColors.shadow,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: widget.destructive
                          ? _LibraryColors.redSurface
                          : null,
                      gradient: widget.destructive
                          ? null
                          : const LinearGradient(
                              colors: [
                                _LibraryColors.brandStart,
                                _LibraryColors.brandEnd,
                              ],
                            ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(
                      widget.icon,
                      color: widget.destructive
                          ? _LibraryColors.red
                          : Colors.white,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 19,
                            fontWeight: FontWeight.w800,
                            color: _LibraryColors.text,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          widget.subtitle,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            height: 1.4,
                            color: _LibraryColors.supporting,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: 'Close',
                    onPressed: _busy ? null : () => Navigator.pop(context),
                    style: IconButton.styleFrom(
                      backgroundColor: _LibraryColors.muted,
                    ),
                    icon: const Icon(Icons.close_rounded, size: 20),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              widget.body,
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _busy ? null : () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                        foregroundColor: _LibraryColors.text,
                        side: const BorderSide(color: _LibraryColors.border),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: !_busy && widget.primaryEnabled
                          ? _submit
                          : null,
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                        backgroundColor: accent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: _busy
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(widget.primaryLabel),
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
