import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../data/models/valuation.dart';
import '../../providers/valuation/valuation_provider.dart';
import '../../../core/constants/db_constants.dart';
import '../../../core/theme/app_colors.dart';

class AddValuationScreen extends ConsumerStatefulWidget {
  final String itemId;
  const AddValuationScreen({super.key, required this.itemId});

  @override
  ConsumerState<AddValuationScreen> createState() => _AddValuationScreenState();
}

class _AddValuationScreenState extends ConsumerState<AddValuationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _valueCtrl = TextEditingController();
  final _sourceCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();

  DateTime _date = DateTime.now();
  String _valueType = 'retail';
  String? _confidence = 'medium';
  bool _saving = false;

  @override
  void dispose() {
    _valueCtrl.dispose();
    _sourceCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      await ref.read(valuationRepositoryProvider).add(Valuation(
            itemId: widget.itemId,
            valuationDate: _date,
            estimatedValue: double.parse(_valueCtrl.text.replaceAll(',', '')),
            valueType: _valueType,
            valueSource: _sourceCtrl.text.trim(),
            confidence: _confidence,
            notes: _notesCtrl.text.isEmpty ? null : _notesCtrl.text,
          ));
      ref.invalidate(valuationHistoryProvider(widget.itemId));
      ref.invalidate(latestValuationProvider(widget.itemId));
      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Error: $e'), backgroundColor: AppColors.error),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Valuation'),
        actions: [
          if (_saving)
            const Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: Colors.white)),
            )
          else
            TextButton(
              onPressed: _save,
              child:
                  const Text('Save', style: TextStyle(color: Colors.white)),
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Date
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Valuation date'),
              subtitle: Text(
                  '${_date.year}-${_date.month.toString().padLeft(2, '0')}-${_date.day.toString().padLeft(2, '0')}'),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _date,
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (picked != null) setState(() => _date = picked);
              },
            ),
            const SizedBox(height: 16),
            // Value
            TextFormField(
              controller: _valueCtrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Estimated value (USD)',
                prefixText: '\$ ',
              ),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Required';
                if (double.tryParse(v.replaceAll(',', '')) == null) {
                  return 'Enter a valid number';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            // Value type
            DropdownButtonFormField<String>(
              value: _valueType,
              decoration: const InputDecoration(labelText: 'Value type'),
              items: const [
                DropdownMenuItem(value: 'retail', child: Text('Retail')),
                DropdownMenuItem(
                    value: 'wholesale', child: Text('Wholesale')),
                DropdownMenuItem(
                    value: 'auction_realized',
                    child: Text('Auction realized')),
                DropdownMenuItem(
                    value: 'insurance', child: Text('Insurance')),
                DropdownMenuItem(
                    value: 'dealer_quote', child: Text('Dealer quote')),
                DropdownMenuItem(
                    value: 'cac_sticker_premium',
                    child: Text('CAC sticker premium')),
              ],
              onChanged: (v) => setState(() => _valueType = v!),
            ),
            const SizedBox(height: 16),
            // Source
            Autocomplete<String>(
              optionsBuilder: (v) => DbConstants.valueSources
                  .where((s) =>
                      s.toLowerCase().contains(v.text.toLowerCase())),
              onSelected: (v) => _sourceCtrl.text = v,
              fieldViewBuilder: (_, ctrl, focusNode, onSubmit) =>
                  TextFormField(
                controller: ctrl,
                focusNode: focusNode,
                onEditingComplete: onSubmit,
                decoration:
                    const InputDecoration(labelText: 'Source'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Required' : null,
              ),
            ),
            const SizedBox(height: 16),
            // Confidence
            DropdownButtonFormField<String>(
              value: _confidence,
              decoration: const InputDecoration(labelText: 'Confidence'),
              items: const [
                DropdownMenuItem(value: 'low', child: Text('Low')),
                DropdownMenuItem(
                    value: 'medium', child: Text('Medium')),
                DropdownMenuItem(value: 'high', child: Text('High')),
              ],
              onChanged: (v) => setState(() => _confidence = v),
            ),
            const SizedBox(height: 16),
            // Notes
            TextFormField(
              controller: _notesCtrl,
              maxLines: 3,
              decoration: const InputDecoration(
                  labelText: 'Notes',
                  hintText:
                      'e.g. "Recent MS64 sold for \$340, this is AU58"'),
            ),
          ],
        ),
      ),
    );
  }
}
