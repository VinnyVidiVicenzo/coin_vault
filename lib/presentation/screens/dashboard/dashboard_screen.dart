import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/items/items_provider.dart';
import '../../../core/theme/app_colors.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(itemsListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Coin Vault'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(itemsListProvider.notifier).refresh(),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Collection Overview',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            items.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text('Error: $e'),
              data: (list) => _StatsGrid(items: list),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Quick Actions',
                    style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: 12),
            _QuickActionsRow(),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Items',
                    style: Theme.of(context).textTheme.titleMedium),
                TextButton(
                  onPressed: () => context.go('/collection'),
                  child: const Text('View all'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            items.when(
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
              data: (list) => Column(
                children: list.take(5).map((item) {
                  return ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: AppColors.primary,
                      child: Icon(Icons.monetization_on, color: Colors.white, size: 20),
                    ),
                    title: Text(
                      [
                        item.country,
                        item.denomination,
                        item.yearStart?.toString(),
                      ].whereType<String>().join(' • '),
                    ),
                    subtitle: item.grade != null ? Text(item.grade!) : null,
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.push('/items/${item.id}'),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatsGrid extends StatelessWidget {
  final List items;
  const _StatsGrid({required this.items});

  @override
  Widget build(BuildContext context) {
    final byType = <String, int>{};
    for (final item in items) {
      byType[item.itemType] = (byType[item.itemType] ?? 0) + 1;
    }
    final slabbed = items.where((i) => i.isSlabbed).length;

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.6,
      children: [
        _StatCard(
          label: 'Total Items',
          value: items.length.toString(),
          icon: Icons.inventory_2_outlined,
          color: AppColors.primary,
        ),
        _StatCard(
          label: 'Slabbed',
          value: slabbed.toString(),
          icon: Icons.verified_outlined,
          color: AppColors.accent,
          iconColor: AppColors.accentDark,
          textColor: AppColors.accentDark,
        ),
        _StatCard(
          label: 'Coins',
          value: (byType['coin'] ?? 0).toString(),
          icon: Icons.circle_outlined,
          color: Colors.blue,
        ),
        _StatCard(
          label: 'Notes',
          value: (byType['note'] ?? 0).toString(),
          icon: Icons.article_outlined,
          color: Colors.green,
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final Color? iconColor;
  final Color? textColor;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor ?? color, size: 24),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: textColor ?? color,
                      ),
                ),
                Text(label,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ActionButton(
            icon: Icons.add_circle_outline,
            label: 'Add Item',
            onTap: () => context.push('/items/new'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _ActionButton(
            icon: Icons.search,
            label: 'Search',
            onTap: () => context.push('/search'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _ActionButton(
            icon: Icons.location_on_outlined,
            label: 'Storage',
            onTap: () => context.push('/storage'),
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Icon(icon, color: AppColors.primary),
              const SizedBox(height: 6),
              Text(label, style: Theme.of(context).textTheme.labelSmall),
            ],
          ),
        ),
      ),
    );
  }
}
