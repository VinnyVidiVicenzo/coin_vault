import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/items/items_provider.dart';
import '../../widgets/items/item_card.dart';
import '../../widgets/common/collection_filter_panel.dart';
import '../../../core/theme/app_colors.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _searchCtrl = TextEditingController();
  final _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final q = ref.read(itemFilterProvider).searchQuery;
      if (q != null) _searchCtrl.text = q;
      _focus.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filter = ref.watch(itemFilterProvider);
    final notifier = ref.read(itemFilterProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Search bar ──────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: TextField(
                controller: _searchCtrl,
                focusNode: _focus,
                decoration: InputDecoration(
                  hintText: 'Year, denomination, cert #, country...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchCtrl.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchCtrl.clear();
                            notifier.setSearch(null);
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28),
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28),
                    borderSide:
                        const BorderSide(color: AppColors.primary, width: 1.5),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                ),
                onChanged: (v) => notifier.setSearch(v.isEmpty ? null : v),
              ),
            ),

            // ── Quick filter chips ──────────────────────────────────
            _QuickFilterRow(filter: filter, notifier: notifier),

            // ── Results count bar ───────────────────────────────────
            if (filter.hasFilters) _ResultsCountBar(filter: filter, notifier: notifier),

            // ── Results or empty state ──────────────────────────────
            Expanded(
              child: filter.hasFilters
                  ? _ResultsList()
                  : _EmptyState(
                      onSuggestionTap: (label, apply) {
                        apply(notifier);
                        _focus.unfocus();
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Quick filter chips ────────────────────────────────────────────────────────

class _QuickFilterRow extends StatelessWidget {
  final ItemFilterState filter;
  final ItemFilter notifier;

  const _QuickFilterRow({required this.filter, required this.notifier});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          // Type chips
          _QuickChip(
            label: 'Coins',
            selected: filter.itemType == 'coin',
            onTap: () => notifier.setType(
                filter.itemType == 'coin' ? null : 'coin'),
          ),
          _QuickChip(
            label: 'Notes',
            selected: filter.itemType == 'note',
            onTap: () => notifier.setType(
                filter.itemType == 'note' ? null : 'note'),
          ),
          _QuickChip(
            label: 'Tokens',
            selected: filter.itemType == 'token',
            onTap: () => notifier.setType(
                filter.itemType == 'token' ? null : 'token'),
          ),
          const _Divider(),
          // Slabbed / Raw
          _QuickChip(
            label: 'Slabbed',
            icon: Icons.verified_outlined,
            selected: filter.isSlabbed == true,
            onTap: () => notifier.setSlabbed(
                filter.isSlabbed == true ? null : true),
          ),
          _QuickChip(
            label: 'Raw',
            selected: filter.isSlabbed == false,
            onTap: () => notifier.setSlabbed(
                filter.isSlabbed == false ? null : false),
          ),
          const _Divider(),
          // More filters
          _MoreFiltersChip(activeCount: filter.activeFilterCount),
        ],
      ),
    );
  }
}

class _QuickChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool selected;
  final VoidCallback onTap;

  const _QuickChip({
    required this.label,
    this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(right: 8, top: 4, bottom: 4),
        child: FilterChip(
          label: icon != null
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, size: 14,
                        color: selected ? AppColors.primary : Colors.black54),
                    const SizedBox(width: 4),
                    Text(label),
                  ],
                )
              : Text(label),
          selected: selected,
          onSelected: (_) => onTap(),
          selectedColor: AppColors.primary.withValues(alpha: 0.15),
          checkmarkColor: AppColors.primary,
          labelStyle: TextStyle(
            fontSize: 13,
            color: selected ? AppColors.primary : Colors.black87,
          ),
          visualDensity: VisualDensity.compact,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          side: BorderSide(
            color: selected
                ? AppColors.primary.withValues(alpha: 0.4)
                : Colors.grey.shade300,
          ),
          backgroundColor: Colors.white,
          showCheckmark: false,
          padding: const EdgeInsets.symmetric(horizontal: 4),
        ),
      );
}

class _MoreFiltersChip extends ConsumerWidget {
  final int activeCount;
  const _MoreFiltersChip({required this.activeCount});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Padding(
        padding: const EdgeInsets.only(right: 8, top: 4, bottom: 4),
        child: ActionChip(
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.tune, size: 14, color: Colors.black54),
              const SizedBox(width: 4),
              const Text('Filters',
                  style: TextStyle(fontSize: 13, color: Colors.black87)),
              if (activeCount > 0) ...[
                const SizedBox(width: 4),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '$activeCount',
                    style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ],
          ),
          onPressed: () => showFilterSheet(context),
          backgroundColor: Colors.white,
          side: BorderSide(color: Colors.grey.shade300),
          visualDensity: VisualDensity.compact,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: const EdgeInsets.symmetric(horizontal: 4),
        ),
      );
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
        child: VerticalDivider(
            width: 1, thickness: 1, color: Colors.grey.shade300),
      );
}

// ── Results count bar ─────────────────────────────────────────────────────────

class _ResultsCountBar extends ConsumerWidget {
  final ItemFilterState filter;
  final ItemFilter notifier;

  const _ResultsCountBar({required this.filter, required this.notifier});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final results = ref.watch(filteredItemsProvider);
    final count = results.valueOrNull?.length;

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          if (count != null)
            Text(
              '$count result${count != 1 ? 's' : ''}',
              style: const TextStyle(
                  fontSize: 13, fontWeight: FontWeight.w600),
            )
          else
            const SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          const Spacer(),
          TextButton(
            onPressed: notifier.reset,
            style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8)),
            child: const Text('Clear all',
                style: TextStyle(fontSize: 12, color: AppColors.primary)),
          ),
        ],
      ),
    );
  }
}

// ── Results list ──────────────────────────────────────────────────────────────

class _ResultsList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final results = ref.watch(filteredItemsProvider);

    return results.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: AppColors.error),
            const SizedBox(height: 12),
            Text(e.toString(), textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => ref.invalidate(filteredItemsProvider),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
      data: (items) {
        if (items.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search_off,
                    size: 64, color: Colors.grey.shade300),
                const SizedBox(height: 16),
                Text(
                  'No items match your search.',
                  style: TextStyle(color: Colors.grey.shade500),
                ),
                const SizedBox(height: 16),
                Consumer(builder: (_, ref, __) => OutlinedButton(
                  onPressed: ref.read(itemFilterProvider.notifier).reset,
                  child: const Text('Clear filters'),
                )),
              ],
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: items.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, i) => ItemCard(
            item: items[i],
            onTap: () => context.push('/items/${items[i].id}'),
          ),
        );
      },
    );
  }
}

// ── Empty state ───────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  final void Function(String label, void Function(ItemFilter) apply) onSuggestionTap;

  const _EmptyState({required this.onSuggestionTap});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick searches',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade500,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _suggestions.map((s) => _SuggestionCard(
              icon: s.icon,
              label: s.label,
              subtitle: s.subtitle,
              onTap: () => onSuggestionTap(s.label, s.apply),
            )).toList(),
          ),
          const SizedBox(height: 32),
          Text(
            'Browse by filters',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade500,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),
          const CollectionFilterPanel(),
        ],
      ),
    );
  }
}

class _SuggestionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final VoidCallback onTap;

  const _SuggestionCard({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final w = (MediaQuery.of(context).size.width - 52) / 2;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: w,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 18, color: AppColors.primary),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w600)),
                  Text(subtitle,
                      style: TextStyle(
                          fontSize: 11, color: Colors.grey.shade500)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SuggestionDef {
  final IconData icon;
  final String label;
  final String subtitle;
  final void Function(ItemFilter) apply;

  const _SuggestionDef({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.apply,
  });
}

const _suggestions = [
  _SuggestionDef(
    icon: Icons.verified_outlined,
    label: 'Slabbed only',
    subtitle: 'PCGS, NGC, PMG...',
    apply: _applySlabbed,
  ),
  _SuggestionDef(
    icon: Icons.star_outline,
    label: 'Gem grade',
    subtitle: 'MS65 and above',
    apply: _applyGem,
  ),
  _SuggestionDef(
    icon: Icons.flag_outlined,
    label: 'US Coins',
    subtitle: 'All American coinage',
    apply: _applyUS,
  ),
  _SuggestionDef(
    icon: Icons.article_outlined,
    label: 'Paper Money',
    subtitle: 'Notes & currency',
    apply: _applyNotes,
  ),
];

void _applySlabbed(ItemFilter n) => n.setSlabbed(true);
void _applyGem(ItemFilter n) {
  n.setMinGrade(65);
  n.setMaxGrade(70);
}
void _applyUS(ItemFilter n) {
  n.setCategoryId('us_coins');
}
void _applyNotes(ItemFilter n) => n.setType('note');
