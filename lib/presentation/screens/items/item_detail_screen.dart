import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../../../data/models/item.dart';
import '../../providers/items/items_provider.dart';
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
    _tabs = TabController(length: 7, vsync: this);
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
