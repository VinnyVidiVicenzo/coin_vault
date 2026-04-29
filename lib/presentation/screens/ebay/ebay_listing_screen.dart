import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/ebay_listing.dart';
import '../../providers/ebay/ebay_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/currency_formatter.dart';

class EbayListingScreen extends ConsumerWidget {
  final String itemId;
  const EbayListingScreen({super.key, required this.itemId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listingsAsync = ref.watch(ebayListingsProvider(itemId));

    return Scaffold(
      appBar: AppBar(title: const Text('eBay Listings')),
      body: listingsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (listings) {
          if (listings.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.sell_outlined,
                      size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text('No eBay listings yet.'),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('Add listing'),
                    onPressed: () =>
                        _showListingForm(context, ref, null),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: listings.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, i) => _ListingCard(
              listing: listings[i],
              onEdit: () => _showListingForm(context, ref, listings[i]),
              onDelete: () => ref
                  .read(ebayListingsProvider(itemId).notifier)
                  .delete(listings[i].id!),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showListingForm(context, ref, null),
        icon: const Icon(Icons.add),
        label: const Text('Add listing'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
    );
  }

  void _showListingForm(
      BuildContext context, WidgetRef ref, EbayListing? existing) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => _ListingForm(
        itemId: itemId,
        existing: existing,
        onSave: (listing) async {
          if (existing != null) {
            await ref
                .read(ebayListingsProvider(itemId).notifier)
                .updateListing(listing);
          } else {
            await ref
                .read(ebayListingsProvider(itemId).notifier)
                .add(listing);
          }
        },
      ),
    );
  }
}

class _ListingCard extends StatelessWidget {
  final EbayListing listing;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _ListingCard({
    required this.listing,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(listing.listingStatus);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    listing.listingStatus.toUpperCase(),
                    style: TextStyle(
                        color: statusColor,
                        fontSize: 11,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Spacer(),
                IconButton(
                    icon: const Icon(Icons.edit_outlined, size: 18),
                    onPressed: onEdit,
                    padding: EdgeInsets.zero),
                IconButton(
                    icon: const Icon(Icons.delete_outline,
                        size: 18, color: Colors.grey),
                    onPressed: onDelete,
                    padding: EdgeInsets.zero),
              ],
            ),
            const SizedBox(height: 8),
            if (listing.listPrice != null) ...[
              Row(
                children: [
                  _AmountField('List price',
                      CurrencyFormatter.format(listing.listPrice)),
                  if (listing.soldPrice != null)
                    _AmountField('Sold',
                        CurrencyFormatter.format(listing.soldPrice)),
                  if (listing.netProceeds != null)
                    _AmountField(
                        'Net',
                        CurrencyFormatter.format(listing.netProceeds),
                        highlight: true),
                ],
              ),
            ],
            if (listing.ebayItemNumber != null) ...[
              const SizedBox(height: 4),
              Text(
                'Item #${listing.ebayItemNumber}',
                style: TextStyle(
                    fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
            if (listing.soldDate != null) ...[
              const SizedBox(height: 4),
              Text(
                'Sold: ${listing.soldDate!.toLocal().toString().substring(0, 10)}',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _statusColor(String status) => switch (status) {
        'active' => AppColors.success,
        'sold' => AppColors.primary,
        'draft' => Colors.grey,
        'ended' || 'cancelled' => AppColors.error,
        _ => Colors.grey,
      };
}

class _AmountField extends StatelessWidget {
  final String label;
  final String value;
  final bool highlight;

  const _AmountField(this.label, this.value, {this.highlight = false});

  @override
  Widget build(BuildContext context) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: TextStyle(
                    fontSize: 11, color: Colors.grey.shade500)),
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: highlight ? AppColors.success : null,
              ),
            ),
          ],
        ),
      );
}

class _ListingForm extends ConsumerStatefulWidget {
  final String itemId;
  final EbayListing? existing;
  final Future<void> Function(EbayListing) onSave;

  const _ListingForm({
    required this.itemId,
    this.existing,
    required this.onSave,
  });

  @override
  ConsumerState<_ListingForm> createState() => _ListingFormState();
}

class _ListingFormState extends ConsumerState<_ListingForm> {
  final _urlCtrl = TextEditingController();
  final _itemNumCtrl = TextEditingController();
  final _listPriceCtrl = TextEditingController();
  final _soldPriceCtrl = TextEditingController();
  final _buyerCtrl = TextEditingController();
  final _fvfCtrl = TextEditingController();
  final _adFeeCtrl = TextEditingController();
  final _shippingCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  String _status = 'draft';
  DateTime? _listedDate;
  DateTime? _soldDate;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    if (e != null) {
      _urlCtrl.text = e.listingUrl ?? '';
      _itemNumCtrl.text = e.ebayItemNumber ?? '';
      _listPriceCtrl.text = e.listPrice?.toString() ?? '';
      _soldPriceCtrl.text = e.soldPrice?.toString() ?? '';
      _buyerCtrl.text = e.buyerUsername ?? '';
      _fvfCtrl.text = e.ebayFinalValueFee?.toString() ?? '';
      _adFeeCtrl.text = e.ebayAdFee?.toString() ?? '';
      _shippingCtrl.text = e.shippingCharged?.toString() ?? '';
      _notesCtrl.text = e.notes ?? '';
      _status = e.listingStatus;
      _listedDate = e.listedDate;
      _soldDate = e.soldDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          16, 16, 16, MediaQuery.of(context).viewInsets.bottom + 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  widget.existing != null
                      ? 'Edit listing'
                      : 'Add listing',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                if (_saving)
                  const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2))
                else
                  FilledButton(
                    onPressed: _save,
                    child: const Text('Save'),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _status,
              decoration: const InputDecoration(
                  labelText: 'Status', isDense: true),
              items: const [
                DropdownMenuItem(value: 'draft', child: Text('Draft')),
                DropdownMenuItem(
                    value: 'active', child: Text('Active')),
                DropdownMenuItem(value: 'sold', child: Text('Sold')),
                DropdownMenuItem(value: 'ended', child: Text('Ended')),
                DropdownMenuItem(
                    value: 'relisted', child: Text('Relisted')),
                DropdownMenuItem(
                    value: 'cancelled', child: Text('Cancelled')),
              ],
              onChanged: (v) => setState(() => _status = v!),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                    child: _field('eBay item #', _itemNumCtrl)),
                const SizedBox(width: 12),
                Expanded(
                    child: _field('List price', _listPriceCtrl,
                        prefix: '\$',
                        keyboard: TextInputType.number)),
              ],
            ),
            const SizedBox(height: 12),
            _field('Listing URL', _urlCtrl),
            if (_status == 'sold') ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                      child: _field('Sold price', _soldPriceCtrl,
                          prefix: '\$',
                          keyboard: TextInputType.number)),
                  const SizedBox(width: 12),
                  Expanded(child: _field('Buyer', _buyerCtrl)),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                      child: _field('FVF', _fvfCtrl,
                          prefix: '\$',
                          keyboard: TextInputType.number)),
                  const SizedBox(width: 12),
                  Expanded(
                      child: _field('Ad fee', _adFeeCtrl,
                          prefix: '\$',
                          keyboard: TextInputType.number)),
                  const SizedBox(width: 12),
                  Expanded(
                      child: _field('Shipping', _shippingCtrl,
                          prefix: '\$',
                          keyboard: TextInputType.number)),
                ],
              ),
            ],
            const SizedBox(height: 12),
            _field('Notes', _notesCtrl, maxLines: 2),
          ],
        ),
      ),
    );
  }

  Widget _field(String label, TextEditingController ctrl,
          {String? prefix,
          TextInputType? keyboard,
          int maxLines = 1}) =>
      TextFormField(
        controller: ctrl,
        keyboardType: keyboard,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixText: prefix,
          isDense: true,
        ),
      );

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      final listing = EbayListing(
        id: widget.existing?.id,
        itemId: widget.itemId,
        listingUrl:
            _urlCtrl.text.isEmpty ? null : _urlCtrl.text,
        ebayItemNumber:
            _itemNumCtrl.text.isEmpty ? null : _itemNumCtrl.text,
        listingStatus: _status,
        listPrice: double.tryParse(_listPriceCtrl.text),
        soldPrice: double.tryParse(_soldPriceCtrl.text),
        buyerUsername:
            _buyerCtrl.text.isEmpty ? null : _buyerCtrl.text,
        shippingCharged: double.tryParse(_shippingCtrl.text),
        ebayFinalValueFee: double.tryParse(_fvfCtrl.text),
        ebayAdFee: double.tryParse(_adFeeCtrl.text),
        listedDate: _listedDate,
        soldDate: _soldDate,
        notes: _notesCtrl.text.isEmpty ? null : _notesCtrl.text,
      );
      await widget.onSave(listing);
      if (mounted) Navigator.pop(context);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}
