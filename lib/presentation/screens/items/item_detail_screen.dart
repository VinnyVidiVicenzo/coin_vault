import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:intl/intl.dart';
import '../../../data/models/item.dart';
import '../../../data/models/storage_location.dart';
import '../../providers/items/items_provider.dart';
import '../../providers/storage/storage_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/grade_utils.dart';

class ItemDetailScreen extends ConsumerWidget {
  final String itemId;
  const ItemDetailScreen({super.key, required this.itemId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(itemDetailProvider(itemId));

    return itemAsync.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(
        appBar: AppBar(),
        body: Center(child: Text('Error: $e')),
      ),
      data: (item) {
        if (item == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: Text('Item not found.')),
          );
        }
        return _ItemDetailView(item: item);
      },
    );
  }
}

class _ItemDetailView extends ConsumerStatefulWidget {
  final Item item;
  const _ItemDetailView({required this.item});

  @override
  ConsumerState<_ItemDetailView> createState() => _ItemDetailViewState();
}

class _ItemDetailViewState extends ConsumerState<_ItemDetailView>
    with SingleTickerProviderStateMixin {
  late TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 8, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return Scaffold(
      appBar: AppBar(
        title: Text(_itemTitle(item)),
        actions: [
          IconButton(
            icon: Icon(item.isPublic ? Icons.public : Icons.public_off),
            tooltip: item.isPublic ? 'Public' : 'Private',
            onPressed: () => ref
                .read(itemsListProvider.notifier)
                .togglePublic(item.id, !item.isPublic),
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/items/${item.id}/edit'),
          ),
          PopupMenuButton<String>(
            onSelected: (v) async {
              if (v == 'delete') {
                final confirmed = await _confirmDelete(context);
                if (confirmed && context.mounted) {
                  ref.read(itemsListProvider.notifier).deleteItem(item.id);
                  context.go('/collection');
                }
              }
            },
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'delete', child: Text('Delete item')),
            ],
          ),
        ],
        bottom: TabBar(
          controller: _tabs,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Identity'),
            Tab(text: 'Images'),
            Tab(text: 'Condition'),
            Tab(text: 'Catalog Refs'),
            Tab(text: 'Notes'),
            Tab(text: 'Valuation'),
            Tab(text: 'eBay'),
            Tab(text: 'Storage'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: [
          _IdentityTab(item: item),
          _ImagesTab(item: item),
          _ConditionTab(item: item),
          _CatalogRefsTab(item: item),
          _NotesTab(item: item),
          _QuickLinkTab(
            icon: Icons.show_chart,
            label: 'View valuation history & chart',
            onTap: () => context.push('/items/${item.id}/valuation'),
          ),
          _QuickLinkTab(
            icon: Icons.sell_outlined,
            label: 'View eBay listings',
            onTap: () => context.push('/items/${item.id}/ebay'),
          ),
          _StorageTab(item: item),
        ],
      ),
    );
  }

  String _itemTitle(Item item) {
    final parts = [
      item.country,
      item.denomination,
      item.yearStart?.toString(),
    ].whereType<String>();
    return parts.isNotEmpty ? parts.join(' ') : 'Item Detail';
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Delete item?'),
            content: const Text('This cannot be undone.'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Cancel')),
              FilledButton(
                style: FilledButton.styleFrom(backgroundColor: AppColors.error),
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Delete'),
              ),
            ],
          ),
        ) ??
        false;
  }
}

// ── Identity tab ────────────────────────────────────────────────────

class _IdentityTab extends StatelessWidget {
  final Item item;
  const _IdentityTab({required this.item});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _DetailSection(title: 'Basic Identity', rows: [
          _Row('Type', item.itemType),
          _Row('Country', item.country),
          _Row('Issuing Authority', item.issuingAuthority),
          _Row('Denomination', item.denomination),
          _Row('Year', item.yearStart?.toString()),
          _Row('Mint Mark', item.mintMark),
          _Row('Series', item.series),
          _Row('Variety', item.variety),
        ]),
        if (item.itemType == 'coin' ||
            item.itemType == 'token' ||
            item.itemType == 'medal') ...[
          _DetailSection(title: 'Physical', rows: [
            _Row('Metal', item.metal),
            _Row('Weight', item.weightGrams != null
                ? '${item.weightGrams} g' : null),
            _Row('Diameter', item.diameterMm != null
                ? '${item.diameterMm} mm' : null),
            _Row('Edge', item.edgeType),
            _Row('Orientation', item.coinOrientation),
          ]),
        ],
        if (item.itemType == 'note') ...[
          _DetailSection(title: 'Note Details', rows: [
            _Row('Serial Number', item.serialNumber),
            _Row('Block', item.serialBlock),
            _Row('Signature Combination', item.signatureCombination),
            _Row('Seal Color', item.sealColor),
            _Row('District', item.district),
            _Row('Plate # Front', item.plateNumberFront),
            _Row('Plate # Back', item.plateNumberBack),
            _Row('Star Note', item.isStarNote ? 'Yes' : 'No'),
          ]),
        ],
        _DetailSection(title: 'Quantity', rows: [
          _Row('Type', item.quantityType),
          _Row('Quantity', item.quantity.toString()),
          if (item.duplicateCount > 0)
            _Row('Duplicates', item.duplicateCount.toString()),
        ]),
      ],
    );
  }
}

// ── Images tab ─────────────────────────────────────────────────────

class _ImagesTab extends StatelessWidget {
  final Item item;
  const _ImagesTab({required this.item});

  @override
  Widget build(BuildContext context) {
    if (item.images.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.photo_library_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('No images yet. Edit the item to add photos.'),
          ],
        ),
      );
    }

    final publicImages = item.images.where((i) => i.publicUrl != null).toList();

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: publicImages.length,
      itemBuilder: (context, index) {
        final img = publicImages[index];
        return GestureDetector(
          onTap: () => _openGallery(context, publicImages, index),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  imageUrl: img.publicUrl!,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 4,
                  left: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      img.imageType.replaceAll('_', ' '),
                      style: const TextStyle(
                          color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openGallery(BuildContext context, List images, int initialIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => _PhotoGallery(images: images, initialIndex: initialIndex),
      ),
    );
  }
}

class _PhotoGallery extends StatelessWidget {
  final List images;
  final int initialIndex;
  const _PhotoGallery({required this.images, required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: PhotoViewGallery.builder(
        itemCount: images.length,
        pageController: PageController(initialPage: initialIndex),
        builder: (_, index) => PhotoViewGalleryPageOptions(
          imageProvider: CachedNetworkImageProvider(images[index].publicUrl!),
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 2,
        ),
      ),
    );
  }
}

// ── Condition tab ───────────────────────────────────────────────────

class _ConditionTab extends StatelessWidget {
  final Item item;
  const _ConditionTab({required this.item});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (item.grade != null) ...[
          Row(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: GradeUtils.colorForNumericGrade(item.gradeNumeric),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                item.grade!,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              if (item.designation != null) ...[
                const SizedBox(width: 8),
                Chip(label: Text(item.designation!)),
              ],
            ],
          ),
          const SizedBox(height: 16),
        ],
        _DetailSection(title: 'Grading', rows: [
          _Row('Grade', item.grade),
          _Row('Grade (numeric)', item.gradeNumeric?.toString()),
          _Row('Grading Company', item.gradingCompany),
          _Row('Cert Number', item.certNumber),
          _Row('Slabbed', item.isSlabbed ? 'Yes' : 'No'),
          _Row('Details Grade', item.detailsGrade ? 'Yes' : 'No'),
          _Row('Details Note', item.detailsNote),
          _Row('Submission Status', item.submissionStatus),
        ]),
        _DetailSection(title: 'Certification', rows: [
          _Row('Designation', item.designation),
          _Row('Holder Generation', item.holderGeneration),
          _Row('Population (obverse)', item.populationObverse?.toString()),
          _Row('Population (reverse)', item.populationReverse?.toString()),
          if (item.certVerificationUrl != null)
            _Row('Cert URL', item.certVerificationUrl),
        ]),
      ],
    );
  }
}

// ── Catalog refs tab ────────────────────────────────────────────────

class _CatalogRefsTab extends StatelessWidget {
  final Item item;
  const _CatalogRefsTab({required this.item});

  @override
  Widget build(BuildContext context) {
    if (item.catalogReferences.isEmpty) {
      return const Center(child: Text('No catalog references added.'));
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: item.catalogReferences.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final ref = item.catalogReferences[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Chip(
                      label: Text(ref.catalogSystem),
                      backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      ref.referenceNumber,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                if (ref.varietyName != null) ...[
                  const SizedBox(height: 4),
                  Text(ref.varietyName!),
                ],
                if (ref.attributionConfidence != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Confidence: ${ref.attributionConfidence}',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

// ── Notes tab ──────────────────────────────────────────────────────

class _NotesTab extends StatelessWidget {
  final Item item;
  const _NotesTab({required this.item});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _DetailSection(title: 'Research & Notes', rows: [
          _Row('Historical Context', item.historicalContext),
          _Row('Attribution Notes', item.attributionNotes),
          _Row('Provenance', item.provenance),
          _Row('Internal Notes', item.internalNotes),
        ]),
      ],
    );
  }
}

// ── Quick-link tab (navigates to sub-screen) ───────────────────────

class _QuickLinkTab extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _QuickLinkTab(
      {required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) => Center(
        child: FilledButton.icon(
          icon: Icon(icon),
          label: Text(label),
          onPressed: onTap,
        ),
      );
}

// ── Shared widgets ─────────────────────────────────────────────────

class _DetailSection extends StatelessWidget {
  final String title;
  final List<_Row> rows;

  const _DetailSection({required this.title, required this.rows});

  @override
  Widget build(BuildContext context) {
    final visible = rows.where((r) => r.value != null && r.value!.isNotEmpty);
    if (visible.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: AppColors.primary)),
        const SizedBox(height: 8),
        ...visible.map((r) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 160,
                    child: Text(r.label,
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 13)),
                  ),
                  Expanded(
                    child: Text(r.value!,
                        style: const TextStyle(fontSize: 13)),
                  ),
                ],
              ),
            )),
        const Divider(height: 24),
      ],
    );
  }
}

class _Row {
  final String label;
  final String? value;
  const _Row(this.label, this.value);
}

// ── Storage tab ─────────────────────────────────────────────────────

class _StorageTab extends ConsumerWidget {
  final Item item;
  const _StorageTab({required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storageAsync = ref.watch(itemStorageProvider(item.id));

    return storageAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (storage) => storage == null
          ? _StorageEmptyState(item: item)
          : _StorageDetails(item: item, storage: storage),
    );
  }
}

class _StorageEmptyState extends ConsumerWidget {
  final Item item;
  const _StorageEmptyState({required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.inventory_2_outlined,
              size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          const Text('Not yet stored'),
          const SizedBox(height: 16),
          FilledButton.icon(
            icon: const Icon(Icons.add_location_outlined),
            label: const Text('Assign to storage'),
            onPressed: () => _showAssignSheet(context, ref, null),
          ),
        ],
      ),
    );
  }

  void _showAssignSheet(
      BuildContext context, WidgetRef ref, ItemStorage? existing) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => _AssignStorageSheet(item: item, existing: existing),
    ).then((_) => ref.invalidate(itemStorageProvider(item.id)));
  }
}

class _StorageDetails extends ConsumerWidget {
  final Item item;
  final ItemStorage storage;
  const _StorageDetails({required this.item, required this.storage});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Location chip
        if (storage.location != null)
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.2)),
            ),
            child: Row(
              children: [
                const Icon(Icons.home_outlined,
                    size: 18, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(storage.location!.locationName,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary)),
              ],
            ),
          ),
        const SizedBox(height: 16),

        _DetailSection(title: 'Container', rows: [
          _Row('Box / container',
              storage.containerLabel ?? storage.containerType),
          _Row('Container type',
              storage.containerType?.replaceAll('_', ' ')),
          _Row('Slot / position', storage.slotEnvelopeNumber),
          _Row('Holder type',
              storage.holderType?.replaceAll('_', ' ')),
        ]),

        if (storage.notes != null && storage.notes!.isNotEmpty)
          _DetailSection(title: 'Label / sticker text', rows: [
            _Row('Label', storage.notes),
          ]),

        _DetailSection(title: 'Status', rows: [
          _Row(
              'Last verified',
              storage.lastVerifiedDate != null
                  ? DateFormat('MMM d, yyyy')
                      .format(storage.lastVerifiedDate!)
                  : null),
          _Row('Environment notes', storage.environmentNotes),
        ]),

        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                icon: const Icon(Icons.edit_outlined),
                label: const Text('Edit assignment'),
                onPressed: () =>
                    _showAssignSheet(context, ref, storage),
              ),
            ),
            const SizedBox(width: 12),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.error),
              onPressed: () => _confirmRemove(context, ref),
              child: const Icon(Icons.delete_outline),
            ),
          ],
        ),
      ],
    );
  }

  void _showAssignSheet(
      BuildContext context, WidgetRef ref, ItemStorage? existing) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => _AssignStorageSheet(item: item, existing: existing),
    ).then((_) => ref.invalidate(itemStorageProvider(item.id)));
  }

  Future<void> _confirmRemove(BuildContext context, WidgetRef ref) async {
    final ok = await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Remove storage assignment?'),
            content: const Text(
                'The coin stays in your collection — this just removes the location record.'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Cancel')),
              FilledButton(
                style: FilledButton.styleFrom(
                    backgroundColor: AppColors.error),
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Remove'),
              ),
            ],
          ),
        ) ??
        false;
    if (ok) {
      await ref
          .read(storageRepositoryProvider)
          .delete(item.id);
      ref.invalidate(itemStorageProvider(item.id));
    }
  }
}

// ── Assign storage sheet ─────────────────────────────────────────────

class _AssignStorageSheet extends ConsumerStatefulWidget {
  final Item item;
  final ItemStorage? existing;
  const _AssignStorageSheet({required this.item, this.existing});

  @override
  ConsumerState<_AssignStorageSheet> createState() =>
      _AssignStorageSheetState();
}

class _AssignStorageSheetState
    extends ConsumerState<_AssignStorageSheet> {
  String _containerType = 'slab_box';
  final _containerLabelCtrl = TextEditingController();
  final _slotCtrl = TextEditingController();
  String _holderType = 'slab';
  final _flipLabelCtrl = TextEditingController();
  final _envNotesCtrl = TextEditingController();
  DateTime? _lastVerified;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    if (e != null) {
      _containerType = e.containerType ?? 'slab_box';
      _containerLabelCtrl.text = e.containerLabel ?? '';
      _slotCtrl.text = e.slotEnvelopeNumber ?? '';
      _holderType = e.holderType ?? 'slab';
      _flipLabelCtrl.text = e.notes ?? '';
      _envNotesCtrl.text = e.environmentNotes ?? '';
      _lastVerified = e.lastVerifiedDate;
    } else {
      // Pre-fill holder type from item's is_slabbed flag
      _holderType = widget.item.isSlabbed ? 'slab' : '2x2_flip';
      _containerType = widget.item.isSlabbed ? 'slab_box' : 'flip_box';
    }
  }

  @override
  void dispose() {
    _containerLabelCtrl.dispose();
    _slotCtrl.dispose();
    _flipLabelCtrl.dispose();
    _envNotesCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locationsAsync = ref.watch(storageLocationsProvider);

    return Padding(
      padding: EdgeInsets.fromLTRB(
          16, 16, 16, MediaQuery.of(context).viewInsets.bottom + 24),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text(
                  widget.existing != null
                      ? 'Edit storage'
                      : 'Assign to storage',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                if (_saving)
                  const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2))
                else
                  FilledButton(
                      onPressed: () => _save(locationsAsync.valueOrNull),
                      child: const Text('Save')),
              ],
            ),
            const SizedBox(height: 20),

            // Container type + label
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _containerType,
                    decoration:
                        const InputDecoration(labelText: 'Container type', isDense: true),
                    items: const [
                      DropdownMenuItem(
                          value: 'slab_box', child: Text('Slab box')),
                      DropdownMenuItem(
                          value: 'flip_box', child: Text('Flip box')),
                      DropdownMenuItem(
                          value: 'display', child: Text('Display case')),
                      DropdownMenuItem(
                          value: 'album', child: Text('Album')),
                      DropdownMenuItem(
                          value: 'other', child: Text('Other')),
                    ],
                    onChanged: (v) => setState(() {
                      _containerType = v ?? 'slab_box';
                      // Auto-switch holder type with container type
                      if (v == 'slab_box') _holderType = 'slab';
                      if (v == 'flip_box') _holderType = '2x2_flip';
                      if (v == 'album') _holderType = 'album_page';
                    }),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _containerLabelCtrl,
                    decoration: const InputDecoration(
                        labelText: 'Box / container name',
                        hintText: 'e.g. Slab Box 1',
                        isDense: true),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Slot + holder type
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _slotCtrl,
                    decoration: const InputDecoration(
                        labelText: 'Slot / position',
                        hintText: 'e.g. Row 2, Slot 4',
                        isDense: true),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _holderType,
                    decoration: const InputDecoration(
                        labelText: 'Holder type', isDense: true),
                    items: const [
                      DropdownMenuItem(
                          value: 'slab', child: Text('Slab')),
                      DropdownMenuItem(
                          value: '2x2_flip',
                          child: Text('2×2 flip')),
                      DropdownMenuItem(
                          value: 'capsule', child: Text('Capsule')),
                      DropdownMenuItem(
                          value: 'album_page',
                          child: Text('Album page')),
                      DropdownMenuItem(
                          value: 'currency_sleeve',
                          child: Text('Currency sleeve')),
                      DropdownMenuItem(
                          value: 'raw', child: Text('Raw / loose')),
                    ],
                    onChanged: (v) =>
                        setState(() => _holderType = v ?? '2x2_flip'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Flip label (what's written/stickered on the flip)
            TextFormField(
              controller: _flipLabelCtrl,
              decoration: const InputDecoration(
                labelText: 'Label / sticker text on flip',
                hintText: 'e.g. "1881-S MS65" or "raw circulated"',
                isDense: true,
              ),
            ),
            const SizedBox(height: 12),

            // Last verified date
            GestureDetector(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _lastVerified ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                );
                if (picked != null) {
                  setState(() => _lastVerified = picked);
                }
              },
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Last verified date',
                  suffixIcon:
                      Icon(Icons.calendar_today_outlined, size: 16),
                  isDense: true,
                ),
                child: Text(
                  _lastVerified != null
                      ? DateFormat('MMM d, yyyy').format(_lastVerified!)
                      : 'Tap to set (optional)',
                  style: TextStyle(
                    color:
                        _lastVerified != null ? null : Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller: _envNotesCtrl,
              decoration: const InputDecoration(
                labelText: 'Environment notes (optional)',
                hintText: 'e.g. "with silica packet"',
                isDense: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save(List<StorageLocation>? locations) async {
    if (locations == null || locations.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Set up a storage location first (go to Storage tab).'),
        ),
      );
      return;
    }

    setState(() => _saving = true);
    try {
      final location = locations.first;
      await ref.read(storageRepositoryProvider).upsert(
            ItemStorage(
              itemId: widget.item.id,
              storageLocationId: location.id!,
              containerType: _containerType,
              containerLabel: _containerLabelCtrl.text.isEmpty
                  ? null
                  : _containerLabelCtrl.text,
              slotEnvelopeNumber:
                  _slotCtrl.text.isEmpty ? null : _slotCtrl.text,
              holderType: _holderType,
              notes: _flipLabelCtrl.text.isEmpty
                  ? null
                  : _flipLabelCtrl.text,
              environmentNotes: _envNotesCtrl.text.isEmpty
                  ? null
                  : _envNotesCtrl.text,
              lastVerifiedDate: _lastVerified,
            ),
          );
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}
