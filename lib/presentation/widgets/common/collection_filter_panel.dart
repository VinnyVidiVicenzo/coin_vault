import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/items/items_provider.dart';
import '../../../core/constants/db_constants.dart';
import '../../../core/theme/app_colors.dart';

/// Sidebar filter panel — used on wide screens (Mac/tablet).
/// On mobile, wrap in a bottom sheet via [showFilterSheet].
class CollectionFilterPanel extends ConsumerWidget {
  final bool compact;
  const CollectionFilterPanel({super.key, this.compact = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(itemFilterProvider);
    final notifier = ref.read(itemFilterProvider.notifier);

    final category = filter.categoryId == null
        ? null
        : DbConstants.browseCategories
            .where((c) => c.id == filter.categoryId)
            .firstOrNull;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!compact) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Filters',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15)),
                if (filter.hasFilters)
                  TextButton(
                    onPressed: notifier.reset,
                    child: const Text('Clear all'),
                  ),
              ],
            ),
            const Divider(),
          ],

          // ── Subcategory (shown when a category is selected) ──
          if (category != null) ...[
            _SectionLabel('Series / Type'),
            DropdownButtonFormField<String>(
              value: filter.subcategory,
              decoration: const InputDecoration(
                  hintText: 'All', isDense: true, border: OutlineInputBorder()),
              isExpanded: true,
              items: category.subcategories
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
              onChanged: (v) => notifier.setSubcategory(
                  v?.startsWith('All') == true ? null : v),
            ),
            const SizedBox(height: 16),
          ],

          // ── Grade range ──
          _SectionLabel('Grade'),
          DropdownButtonFormField<String>(
            value: _gradeLabel(filter.minGrade, filter.maxGrade),
            decoration: const InputDecoration(
                hintText: 'Any grade',
                isDense: true,
                border: OutlineInputBorder()),
            isExpanded: true,
            items: [
              const DropdownMenuItem(value: 'any', child: Text('Any grade')),
              ...DbConstants.gradeRanges.map((g) =>
                  DropdownMenuItem(value: g.label, child: Text(g.label))),
            ],
            onChanged: (v) {
              if (v == null || v == 'any') {
                notifier.setMinGrade(null);
                notifier.setMaxGrade(null);
              } else {
                final range = DbConstants.gradeRanges
                    .where((g) => g.label == v)
                    .firstOrNull;
                if (range != null) {
                  notifier.setMinGrade(range.min.toDouble());
                  notifier.setMaxGrade(range.max.toDouble());
                }
              }
            },
          ),
          const SizedBox(height: 16),

          // ── Certification ──
          _SectionLabel('Certification'),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: DbConstants.gradingCompanies.map((gc) {
              final selected = filter.gradingCompany == gc;
              return FilterChip(
                label: Text(gc),
                selected: selected,
                onSelected: (_) =>
                    notifier.setGradingCompany(selected ? null : gc),
                selectedColor: AppColors.primary.withValues(alpha: 0.15),
                checkmarkColor: AppColors.primary,
                labelStyle: TextStyle(
                    fontSize: 12,
                    color: selected ? AppColors.primary : null),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),

          // ── Slabbed / Raw ──
          _SectionLabel('Holder'),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'any', label: Text('Any')),
              ButtonSegment(value: 'slabbed', label: Text('Slabbed')),
              ButtonSegment(value: 'raw', label: Text('Raw')),
            ],
            selected: {
              filter.isSlabbed == null
                  ? 'any'
                  : filter.isSlabbed!
                      ? 'slabbed'
                      : 'raw'
            },
            onSelectionChanged: (s) {
              final v = s.first;
              notifier.setSlabbed(
                  v == 'any' ? null : v == 'slabbed' ? true : false);
            },
            style: ButtonStyle(
              textStyle: WidgetStateProperty.all(
                  const TextStyle(fontSize: 12)),
            ),
          ),
          const SizedBox(height: 16),

          // ── Year range ──
          _SectionLabel('Year Range'),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: filter.minYear?.toString(),
                  decoration: const InputDecoration(
                      hintText: 'From', isDense: true, border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                  onChanged: (v) => notifier.setMinYear(int.tryParse(v)),
                ),
              ),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text('–')),
              Expanded(
                child: TextFormField(
                  initialValue: filter.maxYear?.toString(),
                  decoration: const InputDecoration(
                      hintText: 'To', isDense: true, border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                  onChanged: (v) => notifier.setMaxYear(int.tryParse(v)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // ── Mint Mark ──
          _SectionLabel('Mint Mark'),
          DropdownButtonFormField<String>(
            value: filter.mintMark,
            decoration: const InputDecoration(
                hintText: 'Any',
                isDense: true,
                border: OutlineInputBorder()),
            isExpanded: true,
            items: [
              const DropdownMenuItem(value: null, child: Text('Any mint mark')),
              ...DbConstants.mintMarks.map((m) =>
                  DropdownMenuItem(value: m, child: Text(m))),
            ],
            onChanged: notifier.setMintMark,
          ),
          const SizedBox(height: 24),

          if (compact)
            FilledButton(
              onPressed: () => Navigator.pop(context),
              style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(44)),
              child: Text(filter.activeFilterCount > 0
                  ? 'Show results (${filter.activeFilterCount} filter${filter.activeFilterCount > 1 ? 's' : ''})'
                  : 'Show results'),
            ),
        ],
      ),
    );
  }

  String _gradeLabel(double? min, double? max) {
    if (min == null && max == null) return 'any';
    for (final g in DbConstants.gradeRanges) {
      if (g.min == min?.toInt() && g.max == max?.toInt()) return g.label;
    }
    return 'any';
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(text,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.primary)),
      );
}

void showFilterSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
    builder: (_) => DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (_, ctrl) => Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            width: 36,
            height: 4,
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2)),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Row(
              children: [
                Text('Filter Collection',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: SingleChildScrollView(
              controller: ctrl,
              child: const CollectionFilterPanel(compact: true),
            ),
          ),
        ],
      ),
    ),
  );
}
