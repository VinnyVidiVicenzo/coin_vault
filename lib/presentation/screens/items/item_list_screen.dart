import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/items/items_provider.dart';
import '../../widgets/items/item_card.dart';
import '../../widgets/items/item_grid_card.dart';
import '../../widgets/common/collection_filter_panel.dart';
import '../../../core/constants/db_constants.dart';
import '../../../core/theme/app_colors.dart';

class ItemListScreen extends ConsumerStatefulWidget {
  const ItemListScreen({super.key});

  @override
  ConsumerState<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends ConsumerState<ItemListScreen> {
  final _searchCtrl = TextEditingController();
  bool _gridView = true;

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 700;
    final filter = ref.watch(itemFilterProvider);
    final notifier = ref.read(itemFilterProvider.notifier);
    final items = ref.watch(filteredItemsProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('My Collection'),
        actions: [
          // Sort dropdown
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort),
            tooltip: 'Sort',
            initialValue: filter.sortBy,
            onSelected: notifier.setSort,
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'date_added', child: Text('Date added')),
              PopupMenuItem(value: 'year', child: Text('Year (oldest first)')),
              PopupMenuItem(value: 'grade', child: Text('Grade (highest first)')),
            ],
          ),
          // Grid / List toggle
          IconButton(
            icon: Icon(_gridView ? Icons.view_list : Icons.grid_view),
            tooltip: _gridView ? 'List view' : 'Grid view',
            onPressed: () => setState(() => _gridView = !_gridView),
          ),
          // Filter button (mobile only)
          if (!isWide)
            Badge(
              isLabelVisible: filter.activeFilterCount > 0,
              label: Text(filter.activeFilterCount.toString()),
              child: IconButton(
                icon: const Icon(Icons.tune),
                tooltip: 'Filter',
                onPressed: () => showFilterSheet(context),
              ),
            ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(116),
          child: Column(
            children: [
              // Search bar
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: TextField(
                  controller: _searchCtrl,
                  decoration: InputDecoration(
                    hintText: 'Search by year, denomination, grade, cert #...',
                    prefixIcon: const Icon(Icons.search, size: 20),
                    suffixIcon: _searchCtrl.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 20),
                            onPressed: () {
                              _searchCtrl.clear();
                              notifier.setSearch(null);
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (v) =>
                      notifier.setSearch(v.isEmpty ? null : v),
                ),
              ),
              // Category tab bar
              _CategoryTabBar(),
            ],
          ),
        ),
      ),
      body: isWide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left filter sidebar
                SizedBox(
                  width: 240,
                  child: Card(
                    margin: const EdgeInsets.all(8),
                    child: CollectionFilterPanel(),
                  ),
                ),
                // Main content
                Expanded(child: _ItemsBody(gridView: _gridView)),
              ],
            )
          : _ItemsBody(gridView: _gridView),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/items/new'),
        icon: const Icon(Icons.add),
        label: const Text('Add Item'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
    );
  }
}

// ── Category tab bar ────────────────────────────────────────────────

class _CategoryTabBar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(itemFilterProvider);
    final notifier = ref.read(itemFilterProvider.notifier);

    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        children: [
          // "All" tab
          _CategoryTab(
            label: 'All',
            emoji: '📦',
            selected: filter.categoryId == null,
            onTap: () {
              notifier.setCategoryId(null);
              notifier.setSubcategory(null);
            },
          ),
          ...DbConstants.browseCategories.map((cat) => _CategoryTab(
                label: cat.label,
                emoji: cat.icon,
                selected: filter.categoryId == cat.id,
                onTap: () => notifier.setCategoryId(
                    filter.categoryId == cat.id ? null : cat.id),
              )),
        ],
      ),
    );
  }
}

class _CategoryTab extends StatelessWidget {
  final String label;
  final String emoji;
  final bool selected;
  final VoidCallback onTap;

  const _CategoryTab({
    required this.label,
    required this.emoji,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: selected ? AppColors.primary : Colors.grey.shade300,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(emoji, style: const TextStyle(fontSize: 14)),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                  color: selected ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Items body ─────────────────────────────────────────────────────

class _ItemsBody extends ConsumerWidget {
  final bool gridView;
  const _ItemsBody({required this.gridView});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(filteredItemsProvider);
    final filter = ref.watch(itemFilterProvider);
    final notifier = ref.read(itemFilterProvider.notifier);

    return items.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: AppColors.error),
            const SizedBox(height: 16),
            Text(e.toString()),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => ref.invalidate(filteredItemsProvider),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
      data: (itemList) {
        if (itemList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.monetization_on_outlined,
                    size: 80, color: Colors.grey.shade300),
                const SizedBox(height: 16),
                Text(
                  filter.hasFilters
                      ? 'No items match your filters.'
                      : 'Your collection is empty.\nTap + to add your first item.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade500),
                ),
                if (filter.hasFilters) ...[
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: notifier.reset,
                    child: const Text('Clear all filters'),
                  ),
                ],
              ],
            ),
          );
        }

        return Column(
          children: [
            // Active filter chips + count bar
            if (filter.hasFilters || itemList.isNotEmpty)
              _ResultsBar(count: itemList.length, filter: filter, notifier: notifier),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => ref.refresh(filteredItemsProvider.future),
                child: gridView
                    ? GridView.builder(
                        padding: const EdgeInsets.all(12),
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 0.72,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: itemList.length,
                        itemBuilder: (context, index) => ItemGridCard(
                          item: itemList[index],
                          onTap: () =>
                              context.push('/items/${itemList[index].id}'),
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.all(12),
                        itemCount: itemList.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (context, index) => ItemCard(
                          item: itemList[index],
                          onTap: () =>
                              context.push('/items/${itemList[index].id}'),
                        ),
                      ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// ── Results bar ────────────────────────────────────────────────────

class _ResultsBar extends StatelessWidget {
  final int count;
  final ItemFilterState filter;
  final ItemFilter notifier;

  const _ResultsBar({
    required this.count,
    required this.filter,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Text(
            '$count item${count != 1 ? 's' : ''}',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  if (filter.categoryId != null)
                    _ActiveChip(
                      label: DbConstants.browseCategories
                              .where((c) => c.id == filter.categoryId)
                              .firstOrNull
                              ?.label ??
                          filter.categoryId!,
                      onRemove: () {
                        notifier.setCategoryId(null);
                        notifier.setSubcategory(null);
                      },
                    ),
                  if (filter.subcategory != null)
                    _ActiveChip(
                      label: filter.subcategory!,
                      onRemove: () => notifier.setSubcategory(null),
                    ),
                  if (filter.gradingCompany != null)
                    _ActiveChip(
                      label: filter.gradingCompany!,
                      onRemove: () => notifier.setGradingCompany(null),
                    ),
                  if (filter.isSlabbed != null)
                    _ActiveChip(
                      label: filter.isSlabbed! ? 'Slabbed' : 'Raw',
                      onRemove: () => notifier.setSlabbed(null),
                    ),
                  if (filter.minGrade != null || filter.maxGrade != null)
                    _ActiveChip(
                      label:
                          'Grade ${filter.minGrade?.toInt()}–${filter.maxGrade?.toInt()}',
                      onRemove: () {
                        notifier.setMinGrade(null);
                        notifier.setMaxGrade(null);
                      },
                    ),
                  if (filter.minYear != null || filter.maxYear != null)
                    _ActiveChip(
                      label:
                          '${filter.minYear ?? ''}–${filter.maxYear ?? ''}',
                      onRemove: () {
                        notifier.setMinYear(null);
                        notifier.setMaxYear(null);
                      },
                    ),
                  if (filter.mintMark != null)
                    _ActiveChip(
                      label: filter.mintMark!,
                      onRemove: () => notifier.setMintMark(null),
                    ),
                ],
              ),
            ),
          ),
          if (filter.hasFilters)
            TextButton(
              onPressed: notifier.reset,
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8)),
              child: const Text('Clear all',
                  style: TextStyle(fontSize: 12)),
            ),
        ],
      ),
    );
  }
}

class _ActiveChip extends StatelessWidget {
  final String label;
  final VoidCallback onRemove;
  const _ActiveChip({required this.label, required this.onRemove});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(right: 6),
        child: Chip(
          label: Text(label, style: const TextStyle(fontSize: 11)),
          deleteIcon: const Icon(Icons.close, size: 14),
          onDeleted: onRemove,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
          backgroundColor: AppColors.primary.withValues(alpha: 0.1),
          side: BorderSide(
              color: AppColors.primary.withValues(alpha: 0.3), width: 0.5),
          labelStyle: const TextStyle(color: AppColors.primary),
          deleteIconColor: AppColors.primary,
        ),
      );
}
