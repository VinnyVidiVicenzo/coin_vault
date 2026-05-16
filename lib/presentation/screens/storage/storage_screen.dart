import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../data/models/item.dart';
import '../../../data/models/storage_location.dart';
import '../../providers/items/items_provider.dart';
import '../../providers/storage/storage_provider.dart';
import '../../../core/theme/app_colors.dart';

class StorageScreen extends ConsumerWidget {
  const StorageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationsAsync = ref.watch(storageLocationsProvider);
    final storageAsync = ref.watch(allItemStorageProvider);
    final itemsAsync = ref.watch(itemsListProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Storage'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_home_outlined),
            tooltip: 'Add storage location',
            onPressed: () => _showAddLocationDialog(context, ref),
          ),
        ],
      ),
      body: locationsAsync.when(
        loading: () =>
            const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (locations) {
          if (locations.isEmpty) {
            return _EmptyLocationsState(
              onSetup: () => _showAddLocationDialog(context, ref),
            );
          }

          return storageAsync.when(
            loading: () =>
                const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error: $e')),
            data: (storageEntries) => itemsAsync.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
              data: (items) => _StorageBrowser(
                locations: locations,
                storageEntries: storageEntries,
                items: items,
              ),
            ),
          );
        },
      ),
    );
  }

  void _showAddLocationDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (_) => _AddLocationDialog(
        onSave: (loc) async {
          await ref.read(storageRepositoryProvider).upsertLocation(loc);
          ref.invalidate(storageLocationsProvider);
        },
      ),
    );
  }
}

// ── Container browser ────────────────────────────────────────────────

class _StorageBrowser extends StatelessWidget {
  final List<StorageLocation> locations;
  final List<ItemStorage> storageEntries;
  final List<Item> items;

  const _StorageBrowser({
    required this.locations,
    required this.storageEntries,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final itemMap = {for (final i in items) i.id: i};

    // Group by container label
    final Map<String, List<_StorageRow>> containers = {};
    final List<Item> unassigned = [];

    for (final entry in storageEntries) {
      final key = '${entry.containerType ?? 'other'}|${entry.containerLabel ?? 'Unlabeled'}';
      containers.putIfAbsent(key, () => []);
      containers[key]!.add(_StorageRow(
        storage: entry,
        item: itemMap[entry.itemId],
      ));
    }

    for (final container in containers.values) {
      container.sort((a, b) {
        final aSlot = a.storage.slotEnvelopeNumber ?? '';
        final bSlot = b.storage.slotEnvelopeNumber ?? '';
        return aSlot.compareTo(bSlot);
      });
    }

    final assignedIds = storageEntries.map((e) => e.itemId).toSet();
    for (final item in items) {
      if (!assignedIds.contains(item.id)) unassigned.add(item);
    }

    final sortedKeys = containers.keys.toList()..sort();

    return RefreshIndicator(
      onRefresh: () async {},
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Location header
          _LocationHeader(location: locations.first),
          const SizedBox(height: 16),

          // Summary chips
          Wrap(
            spacing: 8,
            children: [
              _SummaryChip(
                icon: Icons.inventory_2_outlined,
                label: '${storageEntries.length} stored',
                color: AppColors.primary,
              ),
              _SummaryChip(
                icon: Icons.warning_amber_outlined,
                label: '${unassigned.length} unassigned',
                color: unassigned.isEmpty
                    ? AppColors.success
                    : Colors.orange,
              ),
              _SummaryChip(
                icon: Icons.category_outlined,
                label: '${containers.length} container${containers.length == 1 ? '' : 's'}',
                color: AppColors.cyan,
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Containers
          for (final key in sortedKeys) ...[
            _ContainerHeader(
              containerKey: key,
              count: containers[key]!.length,
            ),
            const SizedBox(height: 8),
            ...containers[key]!.map(
              (row) => _StorageTile(row: row),
            ),
            const SizedBox(height: 20),
          ],

          // Unassigned section
          if (unassigned.isNotEmpty) ...[
            _SectionLabel(
              '${unassigned.length} unassigned item${unassigned.length == 1 ? '' : 's'}',
              color: Colors.orange,
              icon: Icons.warning_amber_outlined,
            ),
            const SizedBox(height: 8),
            ...unassigned.map((item) => _UnassignedTile(item: item)),
          ],
        ],
      ),
    );
  }
}

class _StorageRow {
  final ItemStorage storage;
  final Item? item;
  const _StorageRow({required this.storage, required this.item});
}

// ── Tiles ────────────────────────────────────────────────────────────

class _StorageTile extends StatelessWidget {
  final _StorageRow row;
  const _StorageTile({required this.row});

  @override
  Widget build(BuildContext context) {
    final item = row.item;
    final storage = row.storage;

    final title = item != null
        ? [
            item.yearStart?.toString(),
            item.series ?? item.denomination ?? item.country,
          ].whereType<String>().join(' ')
        : 'Unknown item';

    final subtitle = [
      if (storage.slotEnvelopeNumber != null) 'Slot ${storage.slotEnvelopeNumber}',
      if (storage.holderType != null)
        storage.holderType!.replaceAll('_', ' '),
      if (storage.notes != null && storage.notes!.isNotEmpty)
        '"${storage.notes}"',
    ].join(' · ');

    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        leading: _HolderIcon(holderType: storage.holderType),
        title: Text(title,
            style: const TextStyle(
                fontSize: 13, fontWeight: FontWeight.w600)),
        subtitle: subtitle.isNotEmpty
            ? Text(subtitle,
                style:
                    TextStyle(fontSize: 11, color: Colors.grey.shade500))
            : null,
        trailing: item != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (item.grade != null)
                    Text(item.grade!,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary)),
                  if (item.gradingCompany != null)
                    Text(item.gradingCompany!,
                        style: TextStyle(
                            fontSize: 10, color: Colors.grey.shade500)),
                ],
              )
            : null,
        onTap: item != null
            ? () => context.push('/items/${item.id}')
            : null,
      ),
    );
  }
}

class _UnassignedTile extends StatelessWidget {
  final Item item;
  const _UnassignedTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final title = [
      item.yearStart?.toString(),
      item.series ?? item.denomination ?? item.country,
    ].whereType<String>().join(' ');

    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.shade100),
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        leading: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.help_outline,
              color: Colors.orange, size: 20),
        ),
        title: Text(title.isEmpty ? 'Unnamed item' : title,
            style: const TextStyle(
                fontSize: 13, fontWeight: FontWeight.w600)),
        subtitle: Text(
          item.grade != null
              ? '${item.gradingCompany ?? ''} ${item.grade}'.trim()
              : item.itemType,
          style:
              TextStyle(fontSize: 11, color: Colors.grey.shade500),
        ),
        trailing: TextButton(
          onPressed: () => context.push('/items/${item.id}'),
          child: const Text('Assign', style: TextStyle(fontSize: 12)),
        ),
      ),
    );
  }
}

// ── Supporting widgets ───────────────────────────────────────────────

class _LocationHeader extends StatelessWidget {
  final StorageLocation location;
  const _LocationHeader({required this.location});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryMid, AppColors.primarySurface],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.home_outlined,
                color: Colors.white, size: 24),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                location.locationName,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              if (location.locationType != null)
                Text(
                  location.locationType!.replaceAll('_', ' '),
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 12,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ContainerHeader extends StatelessWidget {
  final String containerKey;
  final int count;
  const _ContainerHeader(
      {required this.containerKey, required this.count});

  @override
  Widget build(BuildContext context) {
    final parts = containerKey.split('|');
    final type = parts[0];
    final label = parts.length > 1 ? parts[1] : 'Unlabeled';

    final icon = switch (type) {
      'slab_box' => Icons.verified_outlined,
      'flip_box' => Icons.grid_view_outlined,
      'display' => Icons.visibility_outlined,
      _ => Icons.inventory_2_outlined,
    };

    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.primary),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 13,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            count.toString(),
            style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: AppColors.primary),
          ),
        ),
      ],
    );
  }
}

class _HolderIcon extends StatelessWidget {
  final String? holderType;
  const _HolderIcon({this.holderType});

  @override
  Widget build(BuildContext context) {
    final (icon, color) = switch (holderType) {
      'slab' => (Icons.verified, AppColors.cyan),
      '2x2_flip' || 'flip_2x2' => (Icons.grid_view, AppColors.primary),
      'capsule' => (Icons.circle_outlined, Colors.teal),
      'album_page' => (Icons.menu_book_outlined, Colors.brown),
      _ => (Icons.inventory_2_outlined, Colors.grey),
    };

    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }
}

class _SummaryChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _SummaryChip(
      {required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) => Chip(
        avatar: Icon(icon, size: 14, color: color),
        label: Text(label,
            style: TextStyle(
                fontSize: 11,
                color: color,
                fontWeight: FontWeight.w600)),
        backgroundColor: color.withValues(alpha: 0.08),
        side: BorderSide(color: color.withValues(alpha: 0.2)),
        padding: EdgeInsets.zero,
      );
}

class _SectionLabel extends StatelessWidget {
  final String text;
  final Color color;
  final IconData icon;
  const _SectionLabel(this.text,
      {required this.color, required this.icon});

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(text,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: color)),
        ],
      );
}

// ── Empty state ──────────────────────────────────────────────────────

class _EmptyLocationsState extends StatelessWidget {
  final VoidCallback onSetup;
  const _EmptyLocationsState({required this.onSetup});

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.home_outlined,
                  size: 72, color: Colors.grey),
              const SizedBox(height: 16),
              const Text(
                'No storage locations yet',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Set up your first storage location to start tracking where each coin lives.',
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.grey.shade600, fontSize: 14),
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Set up Home Collection'),
                onPressed: onSetup,
              ),
            ],
          ),
        ),
      );
}

// ── Add location dialog ──────────────────────────────────────────────

class _AddLocationDialog extends StatefulWidget {
  final Future<void> Function(StorageLocation) onSave;
  const _AddLocationDialog({required this.onSave});

  @override
  State<_AddLocationDialog> createState() => _AddLocationDialogState();
}

class _AddLocationDialogState extends State<_AddLocationDialog> {
  final _nameCtrl =
      TextEditingController(text: 'Home Collection');
  String _type = 'home_safe';
  bool _saving = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Storage location'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameCtrl,
            decoration:
                const InputDecoration(labelText: 'Location name'),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _type,
            decoration: const InputDecoration(labelText: 'Type'),
            items: const [
              DropdownMenuItem(
                  value: 'home_safe', child: Text('Home safe')),
              DropdownMenuItem(
                  value: 'bank_box',
                  child: Text('Bank safe deposit box')),
              DropdownMenuItem(
                  value: 'display', child: Text('Display case')),
              DropdownMenuItem(
                  value: 'storage_unit',
                  child: Text('Storage unit')),
              DropdownMenuItem(
                  value: 'other', child: Text('Other')),
            ],
            onChanged: (v) => setState(() => _type = v ?? 'home_safe'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        if (_saving)
          const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2))
        else
          FilledButton(
            onPressed: () async {
              setState(() => _saving = true);
              await widget.onSave(StorageLocation(
                locationName: _nameCtrl.text.trim().isEmpty
                    ? 'Home Collection'
                    : _nameCtrl.text.trim(),
                locationType: _type,
              ));
              if (mounted) Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
      ],
    );
  }
}
