import 'package:flutter/material.dart';
import '../../../data/models/catalog_reference.dart';
import '../../../core/constants/db_constants.dart';

class CatalogRefForm extends StatefulWidget {
  final List<CatalogReference> initialRefs;
  final ValueChanged<List<CatalogReference>> onChanged;

  const CatalogRefForm({
    super.key,
    required this.initialRefs,
    required this.onChanged,
  });

  @override
  State<CatalogRefForm> createState() => _CatalogRefFormState();
}

class _CatalogRefFormState extends State<CatalogRefForm> {
  late List<_RefEntry> _entries;

  @override
  void initState() {
    super.initState();
    _entries = widget.initialRefs
        .map((r) => _RefEntry.fromRef(r))
        .toList();
    if (_entries.isEmpty) _entries.add(_RefEntry());
  }

  void _notify() {
    widget.onChanged(_entries
        .where((e) =>
            e.systemCtrl.text.isNotEmpty && e.numberCtrl.text.isNotEmpty)
        .map((e) => CatalogReference(
              itemId: '',
              catalogSystem: e.systemCtrl.text,
              referenceNumber: e.numberCtrl.text,
              varietyName:
                  e.varietyCtrl.text.isEmpty ? null : e.varietyCtrl.text,
              attributionConfidence: e.confidence,
              attributionSource:
                  e.sourceCtrl.text.isEmpty ? null : e.sourceCtrl.text,
              notes: e.notesCtrl.text.isEmpty ? null : e.notesCtrl.text,
            ))
        .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ..._entries.asMap().entries.map((entry) {
          final idx = entry.key;
          final e = entry.value;
          return _RefRow(
            entry: e,
            onChanged: _notify,
            onRemove: _entries.length > 1
                ? () => setState(() {
                      _entries.removeAt(idx);
                      _notify();
                    })
                : null,
          );
        }),
        TextButton.icon(
          icon: const Icon(Icons.add),
          label: const Text('Add catalog reference'),
          onPressed: () => setState(() => _entries.add(_RefEntry())),
        ),
      ],
    );
  }
}

class _RefRow extends StatelessWidget {
  final _RefEntry entry;
  final VoidCallback onChanged;
  final VoidCallback? onRemove;

  const _RefRow({
    required this.entry,
    required this.onChanged,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: DropdownButtonFormField<String>(
                    value: entry.systemCtrl.text.isEmpty
                        ? null
                        : entry.systemCtrl.text,
                    decoration: const InputDecoration(
                        labelText: 'Catalog', isDense: true),
                    items: DbConstants.catalogSystems
                        .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                        .toList(),
                    onChanged: (v) {
                      entry.systemCtrl.text = v ?? '';
                      onChanged();
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    controller: entry.numberCtrl,
                    decoration: const InputDecoration(
                        labelText: 'Number', isDense: true),
                    onChanged: (_) => onChanged(),
                  ),
                ),
                if (onRemove != null)
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline,
                        color: Colors.red),
                    onPressed: onRemove,
                    tooltip: 'Remove',
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: entry.varietyCtrl,
                    decoration: const InputDecoration(
                        labelText: 'Variety name', isDense: true),
                    onChanged: (_) => onChanged(),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: entry.confidence,
                    decoration: const InputDecoration(
                        labelText: 'Confidence', isDense: true),
                    items: const [
                      DropdownMenuItem(
                          value: 'confirmed', child: Text('Confirmed')),
                      DropdownMenuItem(
                          value: 'likely', child: Text('Likely')),
                      DropdownMenuItem(
                          value: 'possible', child: Text('Possible')),
                    ],
                    onChanged: (v) {
                      entry.confidence = v;
                      onChanged();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RefEntry {
  final systemCtrl = TextEditingController();
  final numberCtrl = TextEditingController();
  final varietyCtrl = TextEditingController();
  final sourceCtrl = TextEditingController();
  final notesCtrl = TextEditingController();
  String? confidence;

  _RefEntry();

  factory _RefEntry.fromRef(CatalogReference ref) {
    final e = _RefEntry();
    e.systemCtrl.text = ref.catalogSystem;
    e.numberCtrl.text = ref.referenceNumber;
    e.varietyCtrl.text = ref.varietyName ?? '';
    e.sourceCtrl.text = ref.attributionSource ?? '';
    e.notesCtrl.text = ref.notes ?? '';
    e.confidence = ref.attributionConfidence;
    return e;
  }
}
