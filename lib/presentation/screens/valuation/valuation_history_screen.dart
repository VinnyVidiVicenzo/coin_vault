import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../../../data/models/valuation.dart';
import '../../providers/valuation/valuation_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/currency_formatter.dart';

class ValuationHistoryScreen extends ConsumerWidget {
  final String itemId;
  const ValuationHistoryScreen({super.key, required this.itemId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(valuationHistoryProvider(itemId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Valuation History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/items/$itemId/valuation/add'),
          ),
        ],
      ),
      body: historyAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (history) {
          if (history.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.show_chart,
                      size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text('No valuations yet.'),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('Add valuation'),
                    onPressed: () =>
                        context.push('/items/$itemId/valuation/add'),
                  ),
                ],
              ),
            );
          }

          final sorted = [...history]
            ..sort((a, b) => a.valuationDate.compareTo(b.valuationDate));

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (sorted.length >= 2) ...[
                SizedBox(
                  height: 220,
                  child: _ValuationChart(valuations: sorted),
                ),
                const SizedBox(height: 8),
                _ValueChangeSummary(valuations: sorted),
                const SizedBox(height: 24),
              ],
              Text('All entries',
                  style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 8),
              ...history.map((v) => _ValuationTile(
                    valuation: v,
                    onDelete: () async {
                      await ref
                          .read(valuationRepositoryProvider)
                          .delete(v.id!);
                      ref.invalidate(valuationHistoryProvider(itemId));
                    },
                  )),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            context.push('/items/$itemId/valuation/add'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _ValuationChart extends StatelessWidget {
  final List<Valuation> valuations;
  const _ValuationChart({required this.valuations});

  @override
  Widget build(BuildContext context) {
    final spots = valuations.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value.estimatedValue);
    }).toList();

    final maxY = valuations.map((v) => v.estimatedValue).reduce(
            (a, b) => a > b ? a : b) *
        1.15;

    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: true, drawVerticalLine: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 60,
              getTitlesWidget: (value, _) => Text(
                CurrencyFormatter.format(value, compact: true),
                style: const TextStyle(fontSize: 10),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) {
                final idx = value.toInt();
                if (idx < 0 || idx >= valuations.length) {
                  return const SizedBox.shrink();
                }
                return Text(
                  DateFormat('MM/yy')
                      .format(valuations[idx].valuationDate),
                  style: const TextStyle(fontSize: 9),
                );
              },
            ),
          ),
          topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        minY: 0,
        maxY: maxY,
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: AppColors.primary,
            barWidth: 2.5,
            dotData: const FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              color: AppColors.primary.withValues(alpha: 0.1),
            ),
          ),
        ],
      ),
    );
  }
}

class _ValueChangeSummary extends StatelessWidget {
  final List<Valuation> valuations;
  const _ValueChangeSummary({required this.valuations});

  @override
  Widget build(BuildContext context) {
    final first = valuations.first.estimatedValue;
    final last = valuations.last.estimatedValue;
    final delta = last - first;
    final pct = first > 0 ? (delta / first * 100) : 0.0;
    final isUp = delta >= 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _StatChip(
            label: 'Current',
            value: CurrencyFormatter.format(last),
            color: AppColors.primary),
        _StatChip(
            label: 'Change',
            value: CurrencyFormatter.formatDelta(delta),
            color: isUp ? AppColors.success : AppColors.error),
        _StatChip(
            label: 'Return',
            value: '${isUp ? '+' : ''}${pct.toStringAsFixed(1)}%',
            color: isUp ? AppColors.success : AppColors.error),
      ],
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _StatChip(
      {required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(value,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: color)),
          Text(label,
              style:
                  TextStyle(fontSize: 11, color: Colors.grey.shade500)),
        ],
      );
}

class _ValuationTile extends StatelessWidget {
  final Valuation valuation;
  final VoidCallback onDelete;
  const _ValuationTile(
      {required this.valuation, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primary.withValues(alpha: 0.1),
          child: const Icon(Icons.attach_money,
              color: AppColors.primary, size: 20),
        ),
        title: Text(
          CurrencyFormatter.format(valuation.estimatedValue),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${DateFormat('MMM d, yyyy').format(valuation.valuationDate)} · '
          '${valuation.valueType.replaceAll('_', ' ')} · '
          '${valuation.valueSource}',
          style: const TextStyle(fontSize: 12),
        ),
        trailing: IconButton(
          icon:
              const Icon(Icons.delete_outline, color: Colors.grey),
          onPressed: () async {
            final ok = await showDialog<bool>(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Delete valuation?'),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancel')),
                      FilledButton(
                          style: FilledButton.styleFrom(
                              backgroundColor: AppColors.error),
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('Delete')),
                    ],
                  ),
                ) ??
                false;
            if (ok) onDelete();
          },
        ),
      ),
    );
  }
}
