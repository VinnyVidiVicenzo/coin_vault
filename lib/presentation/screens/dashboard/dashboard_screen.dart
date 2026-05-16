import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/items/items_provider.dart';
import '../../providers/dashboard/dashboard_provider.dart';
import '../../widgets/common/gradient_card.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/currency_formatter.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(itemsListProvider);
    final statsAsync = ref.watch(dashboardStatsProvider);

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                gradient: AppColors.accentGradient,
                borderRadius: BorderRadius.circular(7),
              ),
              child: const Icon(Icons.monetization_on,
                  color: AppColors.primary, size: 18),
            ),
            const SizedBox(width: 10),
            const Text('Coin Vault'),
          ],
        ),
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
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
          children: [
            // ── Hero stats card ──────────────────────────────
            items.when(
              loading: () => const _HeroSkeleton(),
              error: (_, __) => const SizedBox.shrink(),
              data: (list) {
                final slabbed = list.where((i) => i.isSlabbed).length;
                final coins = list.where((i) => i.itemType == 'coin').length;
                final notes = list.where((i) => i.itemType == 'note').length;

                return GradientCard(
                  colors: [AppColors.primaryMid, AppColors.primarySurface],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Your Collection',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.7),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.accent.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: AppColors.accent.withValues(alpha: 0.3)),
                            ),
                            child: const Text('ACTIVE',
                                style: TextStyle(
                                    color: AppColors.accent,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          GlowingStat(
                              value: list.length.toString(),
                              label: 'TOTAL ITEMS',
                              color: AppColors.accent),
                          const SizedBox(width: 32),
                          GlowingStat(
                              value: slabbed.toString(),
                              label: 'SLABBED',
                              color: AppColors.cyan),
                          const SizedBox(width: 32),
                          GlowingStat(
                              value: coins.toString(),
                              label: 'COINS',
                              color: Colors.white),
                          const SizedBox(width: 32),
                          GlowingStat(
                              value: notes.toString(),
                              label: 'NOTES',
                              color: Colors.white70),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Progress bar — slabbed ratio
                      if (list.isNotEmpty) ...[
                        Text(
                          '${((slabbed / list.length) * 100).toStringAsFixed(0)}% slabbed',
                          style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontSize: 11),
                        ),
                        const SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: slabbed / list.length,
                            backgroundColor:
                                Colors.white.withValues(alpha: 0.1),
                            valueColor: const AlwaysStoppedAnimation(
                                AppColors.cyan),
                            minHeight: 5,
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            // ── Financial overview ───────────────────────────
            statsAsync.when(
              loading: () => Container(
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              error: (_, __) => const SizedBox.shrink(),
              data: (stats) => stats.hasFinancialData
                  ? _FinancialCard(stats: stats)
                  : const SizedBox.shrink(),
            ),

            const SizedBox(height: 20),

            // ── Quick actions ────────────────────────────────
            _SectionLabel('Quick Actions'),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _ActionButton(
                    icon: Icons.add_circle_outline,
                    label: 'Add Item',
                    color: AppColors.primaryMid,
                    onTap: () => context.push('/items/new'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _ActionButton(
                    icon: Icons.grid_view,
                    label: 'Browse',
                    color: AppColors.primaryLight,
                    onTap: () => context.go('/collection'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _ActionButton(
                    icon: Icons.location_on_outlined,
                    label: 'Storage',
                    color: const Color(0xFF1A3A5C),
                    onTap: () => context.push('/storage'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ── Integrations ─────────────────────────────────
            _SectionLabel('Integrations'),
            const SizedBox(height: 10),

            // eBay
            _IntegrationCard(
              title: 'eBay',
              subtitle: 'Connect your seller account to sync listings',
              logoWidget: _EbayLogo(),
              connected: false,
              statusLabel: 'Not connected',
              colors: [const Color(0xFF0064D2), const Color(0xFF003D7A)],
              onConnect: () => _showEbayConnectDialog(context),
              onManage: () => context.push('/integrations/ebay'),
            ),

            const SizedBox(height: 12),

            // WordPress / Website
            _IntegrationCard(
              title: 'vincenzofazeli.com',
              subtitle: 'Publish your collection to your WordPress site',
              logoWidget: _WpLogo(),
              connected: false,
              statusLabel: 'Not connected',
              colors: [const Color(0xFF21759B), const Color(0xFF0F3D52)],
              onConnect: () => _showWpConnectDialog(context),
              onManage: () => context.push('/integrations/wordpress'),
            ),

            const SizedBox(height: 24),

            // ── Recent items ─────────────────────────────────
            Row(
              children: [
                const Expanded(child: _SectionLabel('Recent Items')),
                TextButton(
                  onPressed: () => context.go('/collection'),
                  child: const Text('View all',
                      style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            items.when(
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
              data: (list) => Column(
                children: list.take(5).map((item) {
                  final parts = [
                    item.yearStart?.toString(),
                    item.series ?? item.denomination ?? item.country,
                  ].whereType<String>();

                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.grey.shade100),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.monetization_on,
                            color: AppColors.accent, size: 20),
                      ),
                      title: Text(
                        parts.join(' '),
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                      subtitle: item.grade != null
                          ? Text(
                              '${item.gradingCompany ?? ''} ${item.grade ?? ''}',
                              style: const TextStyle(fontSize: 11),
                            )
                          : null,
                      trailing: const Icon(Icons.chevron_right,
                          size: 18, color: Colors.grey),
                      onTap: () => context.push('/items/${item.id}'),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEbayConnectDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            _EbayLogo(),
            const SizedBox(width: 10),
            const Text('Connect eBay'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'To connect your eBay seller account you need a free eBay Developer account.',
              style: TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 16),
            _StepItem(
                number: '1',
                text: 'Go to developer.ebay.com and create a free account'),
            _StepItem(
                number: '2',
                text: 'Create an application and copy your Client ID & Secret'),
            _StepItem(
                number: '3',
                text:
                    'Return here and paste your credentials to activate sync'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.cyan.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: AppColors.cyan.withValues(alpha: 0.2)),
              ),
              child: const Text(
                'Once connected, Coin Vault will automatically track your eBay listings and mark items as sold.',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Later'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: open developer.ebay.com
            },
            child: const Text('Open eBay Developer'),
          ),
        ],
      ),
    );
  }

  void _showWpConnectDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            _WpLogo(),
            const SizedBox(width: 10),
            const Text('Connect Website'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Publish your collection to vincenzofazeli.com so visitors can browse your coins.',
              style: TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 16),
            _StepItem(
                number: '1',
                text:
                    'In Claude.ai chat, type /mcp and select "claude.ai WordPress.com"'),
            _StepItem(
                number: '2',
                text: 'Log in with your WordPress.com account'),
            _StepItem(
                number: '3',
                text:
                    'Claude will install the Coin Vault plugin and display your collection'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF21759B).withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: const Color(0xFF21759B).withValues(alpha: 0.2)),
              ),
              child: const Text(
                'Items marked as "Public" in the app will appear on your website automatically.',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Later'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }
}

// ── Widgets ─────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: AppColors.primary,
          letterSpacing: 0.3,
        ),
      );
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color, color.withValues(alpha: 0.8)],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(icon, color: Colors.white, size: 24),
              const SizedBox(height: 6),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
}

class _IntegrationCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget logoWidget;
  final bool connected;
  final String statusLabel;
  final List<Color> colors;
  final VoidCallback onConnect;
  final VoidCallback onManage;

  const _IntegrationCard({
    required this.title,
    required this.subtitle,
    required this.logoWidget,
    required this.connected,
    required this.statusLabel,
    required this.colors,
    required this.onConnect,
    required this.onManage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Logo container
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: colors,
                ),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Center(child: logoWidget),
            ),
            const SizedBox(width: 14),
            // Title & subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 14)),
                  const SizedBox(height: 3),
                  Text(subtitle,
                      style: TextStyle(
                          fontSize: 11, color: Colors.grey.shade500),
                      maxLines: 2),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(
                          color: connected
                              ? AppColors.success
                              : Colors.grey.shade300,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        statusLabel,
                        style: TextStyle(
                          fontSize: 11,
                          color: connected
                              ? AppColors.success
                              : Colors.grey.shade400,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            // Connect / Manage button
            ElevatedButton(
              onPressed: connected ? onManage : onConnect,
              style: ElevatedButton.styleFrom(
                backgroundColor: connected
                    ? AppColors.surface
                    : AppColors.primaryMid,
                foregroundColor:
                    connected ? AppColors.primaryMid : Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                textStyle: const TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w600),
              ),
              child: Text(connected ? 'Manage' : 'Connect'),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepItem extends StatelessWidget {
  final String number;
  final String text;
  const _StepItem({required this.number, required this.text});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: AppColors.primaryMid,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(number,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(text, style: const TextStyle(fontSize: 12)),
            ),
          ],
        ),
      );
}

class _EbayLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Text(
        'eBay',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          fontSize: 14,
          fontStyle: FontStyle.italic,
        ),
      );
}

class _WpLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      const Icon(Icons.language, color: Colors.white, size: 22);
}

class _HeroSkeleton extends StatelessWidget {
  const _HeroSkeleton();

  @override
  Widget build(BuildContext context) => Container(
        height: 140,
        decoration: BoxDecoration(
          color: AppColors.primaryMid.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(20),
        ),
      );
}

class _FinancialCard extends StatelessWidget {
  final DashboardStats stats;
  const _FinancialCard({required this.stats});

  @override
  Widget build(BuildContext context) {
    final isGain = stats.gain >= 0;
    final gainColor = isGain ? AppColors.success : AppColors.error;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.account_balance_wallet_outlined,
                  size: 16, color: AppColors.primary),
              const SizedBox(width: 6),
              Text(
                'Financial Overview',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                  letterSpacing: 0.3,
                ),
              ),
              const Spacer(),
              if (stats.activeListings > 0)
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: AppColors.success.withValues(alpha: 0.3)),
                  ),
                  child: Text(
                    '${stats.activeListings} on eBay',
                    style: const TextStyle(
                      color: AppColors.success,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _FinStat(
                label: 'COST BASIS',
                value: CurrencyFormatter.format(stats.totalCost),
                color: Colors.grey.shade700,
              ),
              _FinDivider(),
              _FinStat(
                label: 'EST. VALUE',
                value: stats.currentValue > 0
                    ? CurrencyFormatter.format(stats.currentValue)
                    : '—',
                color: AppColors.primary,
              ),
              if (stats.totalCost > 0 && stats.currentValue > 0) ...[
                _FinDivider(),
                _FinStat(
                  label: 'GAIN / LOSS',
                  value:
                      '${isGain ? '+' : ''}${CurrencyFormatter.format(stats.gain)}\n'
                      '${isGain ? '+' : ''}${stats.gainPct.toStringAsFixed(1)}%',
                  color: gainColor,
                ),
              ],
            ],
          ),
          if (stats.activeListings > 0 && stats.totalListedValue > 0) ...[
            const SizedBox(height: 10),
            Divider(height: 1, color: Colors.grey.shade100),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.sell_outlined,
                    size: 14, color: AppColors.success),
                const SizedBox(width: 6),
                Text(
                  '${stats.activeListings} active listing${stats.activeListings == 1 ? '' : 's'} · '
                  '${CurrencyFormatter.format(stats.totalListedValue)} listed',
                  style: TextStyle(
                      fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _FinStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _FinStat(
      {required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade400,
                    letterSpacing: 0.8)),
            const SizedBox(height: 3),
            Text(value,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: color)),
          ],
        ),
      );
}

class _FinDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        width: 1,
        height: 36,
        color: Colors.grey.shade100,
        margin: const EdgeInsets.symmetric(horizontal: 12),
      );
}
