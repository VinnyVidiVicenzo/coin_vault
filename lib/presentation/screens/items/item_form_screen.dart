import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../data/models/item.dart';
import '../../../data/models/acquisition.dart';
import '../../../data/models/catalog_reference.dart';
import '../../../data/models/item_image.dart';
import '../../../data/remote/supabase/storage_service.dart';
import '../../../data/repositories/impl/acquisition_repository_impl.dart';
import '../../providers/items/items_provider.dart';
import '../../providers/acquisition/acquisition_provider.dart';
import '../../widgets/forms/catalog_ref_form.dart';
import '../../../core/constants/db_constants.dart';
import '../../../core/theme/app_colors.dart';

class ItemFormScreen extends ConsumerStatefulWidget {
  final String? itemId;
  const ItemFormScreen({super.key, this.itemId});

  @override
  ConsumerState<ItemFormScreen> createState() => _ItemFormScreenState();
}

class _ItemFormScreenState extends ConsumerState<ItemFormScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _loading = true;
  bool _saving = false;

  // Item type drives which field sections are shown
  String _itemType = 'coin';

  // Identity controllers
  final _countryCtrl = TextEditingController();
  final _issuingCtrl = TextEditingController();
  final _denomCtrl = TextEditingController();
  final _denomNumCtrl = TextEditingController();
  final _yearStartCtrl = TextEditingController();
  final _yearEndCtrl = TextEditingController();
  String? _mintMark;
  String? _series;
  final _varietyCtrl = TextEditingController();
  bool _isPublic = false;

  // Physical — coins
  String? _metal;
  final _weightCtrl = TextEditingController();
  final _diameterCtrl = TextEditingController();
  String? _edgeType;
  String? _coinOrientation;

  // Physical — notes
  final _noteWidthCtrl = TextEditingController();
  final _noteHeightCtrl = TextEditingController();

  // Coin descriptions
  final _obverseCtrl = TextEditingController();
  final _reverseCtrl = TextEditingController();
  final _edgeDescCtrl = TextEditingController();
  final _dieMarkersCtrl = TextEditingController();

  // Note fields
  final _serialCtrl = TextEditingController();
  final _serialBlockCtrl = TextEditingController();
  final _sigCombCtrl = TextEditingController();
  final _sealColorCtrl = TextEditingController();
  final _districtCtrl = TextEditingController();
  final _plateFrontCtrl = TextEditingController();
  final _plateBackCtrl = TextEditingController();
  bool _isStarNote = false;

  // Condition
  final _gradeCtrl = TextEditingController();
  final _gradeNumCtrl = TextEditingController();
  String? _gradingCompany;
  final _certCtrl = TextEditingController();
  bool _isSlabbed = false;
  bool _detailsGrade = false;
  final _detailsNoteCtrl = TextEditingController();
  String? _submissionStatus = 'raw';
  String? _designation;
  final _holderGenCtrl = TextEditingController();
  final _popObverseCtrl = TextEditingController();
  final _popReverseCtrl = TextEditingController();
  final _certUrlCtrl = TextEditingController();

  // Quantity
  String _quantityType = 'single';
  final _quantityCtrl = TextEditingController(text: '1');
  final _dupCountCtrl = TextEditingController(text: '0');

  // Notes
  final _historicalCtrl = TextEditingController();
  final _attributionCtrl = TextEditingController();
  final _provenanceCtrl = TextEditingController();
  final _internalCtrl = TextEditingController();

  // Catalog references
  List<CatalogReference> _catalogRefs = [];

  // Pending image uploads
  final List<_PendingImage> _pendingImages = [];
  String? _existingItemId;

  // Acquisition
  DateTime? _purchaseDate;
  String? _sourceType;
  String _costBasisType = 'known';
  String? _paymentMethod;
  final _sellerNameCtrl = TextEditingController();
  final _sellerContactCtrl = TextEditingController();
  final _lotNumberCtrl = TextEditingController();
  final _purchasePriceCtrl = TextEditingController();
  final _buyersPremiumCtrl = TextEditingController();
  final _shippingCostCtrl = TextEditingController();
  final _taxPaidCtrl = TextEditingController();
  final _otherFeesCtrl = TextEditingController();
  final _acqNotesCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    for (final ctrl in [
      _purchasePriceCtrl,
      _buyersPremiumCtrl,
      _shippingCostCtrl,
      _taxPaidCtrl,
      _otherFeesCtrl,
    ]) {
      ctrl.addListener(_rebuildForTotal);
    }
    _loadExisting();
  }

  void _rebuildForTotal() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    for (final ctrl in [
      _countryCtrl, _issuingCtrl, _denomCtrl, _denomNumCtrl,
      _yearStartCtrl, _yearEndCtrl, _varietyCtrl,
      _weightCtrl, _diameterCtrl,
      _noteWidthCtrl, _noteHeightCtrl,
      _obverseCtrl, _reverseCtrl, _edgeDescCtrl, _dieMarkersCtrl,
      _serialCtrl, _serialBlockCtrl, _sigCombCtrl, _sealColorCtrl,
      _districtCtrl, _plateFrontCtrl, _plateBackCtrl,
      _gradeCtrl, _gradeNumCtrl, _certCtrl, _detailsNoteCtrl,
      _holderGenCtrl, _popObverseCtrl, _popReverseCtrl, _certUrlCtrl,
      _quantityCtrl, _dupCountCtrl,
      _historicalCtrl, _attributionCtrl, _provenanceCtrl, _internalCtrl,
      _sellerNameCtrl, _sellerContactCtrl, _lotNumberCtrl,
      _purchasePriceCtrl, _buyersPremiumCtrl, _shippingCostCtrl,
      _taxPaidCtrl, _otherFeesCtrl, _acqNotesCtrl,
    ]) {
      ctrl.dispose();
    }
    super.dispose();
  }

  Future<void> _loadExisting() async {
    if (widget.itemId != null && widget.itemId != 'new') {
      final itemFuture =
          ref.read(itemRepositoryProvider).fetchItem(widget.itemId!);
      final acqFuture = ref
          .read(acquisitionRepositoryProvider)
          .fetchForItem(widget.itemId!);

      final item = await itemFuture;
      final acq = await acqFuture;

      if (mounted) {
        if (item != null) _populateForm(item);
        if (acq != null) _populateAcquisition(acq);
      }
    }
    if (mounted) setState(() => _loading = false);
  }

  void _populateAcquisition(Acquisition acq) {
    _purchaseDate = acq.purchaseDate;
    _sourceType = acq.sourceType;
    _costBasisType = acq.costBasisType;
    _paymentMethod = acq.paymentMethod;
    _sellerNameCtrl.text = acq.sellerName ?? '';
    _sellerContactCtrl.text = acq.sellerContact ?? '';
    _lotNumberCtrl.text = acq.lotNumber ?? '';
    _purchasePriceCtrl.text = acq.purchasePrice?.toString() ?? '';
    _buyersPremiumCtrl.text = acq.buyersPremium?.toString() ?? '';
    _shippingCostCtrl.text = acq.shippingCost?.toString() ?? '';
    _taxPaidCtrl.text = acq.taxPaid?.toString() ?? '';
    _otherFeesCtrl.text = acq.otherFees?.toString() ?? '';
    _acqNotesCtrl.text = acq.notes ?? '';
  }

  void _populateForm(Item item) {
    _existingItemId = item.id;
    _itemType = item.itemType;
    _countryCtrl.text = item.country ?? '';
    _issuingCtrl.text = item.issuingAuthority ?? '';
    _denomCtrl.text = item.denomination ?? '';
    _denomNumCtrl.text = item.denominationNumeric?.toString() ?? '';
    _yearStartCtrl.text = item.yearStart?.toString() ?? '';
    _yearEndCtrl.text = item.yearEnd?.toString() ?? '';
    _mintMark = item.mintMark;
    _series = item.series;
    _varietyCtrl.text = item.variety ?? '';
    _isPublic = item.isPublic;
    _metal = item.metal;
    _weightCtrl.text = item.weightGrams?.toString() ?? '';
    _diameterCtrl.text = item.diameterMm?.toString() ?? '';
    _edgeType = item.edgeType;
    _coinOrientation = item.coinOrientation;
    _noteWidthCtrl.text = item.noteWidthMm?.toString() ?? '';
    _noteHeightCtrl.text = item.noteHeightMm?.toString() ?? '';
    _obverseCtrl.text = item.obverseDescription ?? '';
    _reverseCtrl.text = item.reverseDescription ?? '';
    _edgeDescCtrl.text = item.edgeDescription ?? '';
    _dieMarkersCtrl.text = item.dieMarkers ?? '';
    _serialCtrl.text = item.serialNumber ?? '';
    _serialBlockCtrl.text = item.serialBlock ?? '';
    _sigCombCtrl.text = item.signatureCombination ?? '';
    _sealColorCtrl.text = item.sealColor ?? '';
    _districtCtrl.text = item.district ?? '';
    _plateFrontCtrl.text = item.plateNumberFront ?? '';
    _plateBackCtrl.text = item.plateNumberBack ?? '';
    _isStarNote = item.isStarNote;
    _gradeCtrl.text = item.grade ?? '';
    _gradeNumCtrl.text = item.gradeNumeric?.toString() ?? '';
    _gradingCompany = item.gradingCompany;
    _certCtrl.text = item.certNumber ?? '';
    _isSlabbed = item.isSlabbed;
    _detailsGrade = item.detailsGrade;
    _detailsNoteCtrl.text = item.detailsNote ?? '';
    _submissionStatus = item.submissionStatus;
    _designation = item.designation;
    _holderGenCtrl.text = item.holderGeneration ?? '';
    _popObverseCtrl.text = item.populationObverse?.toString() ?? '';
    _popReverseCtrl.text = item.populationReverse?.toString() ?? '';
    _certUrlCtrl.text = item.certVerificationUrl ?? '';
    _quantityType = item.quantityType;
    _quantityCtrl.text = item.quantity.toString();
    _dupCountCtrl.text = item.duplicateCount.toString();
    _historicalCtrl.text = item.historicalContext ?? '';
    _attributionCtrl.text = item.attributionNotes ?? '';
    _provenanceCtrl.text = item.provenance ?? '';
    _internalCtrl.text = item.internalNotes ?? '';
    _catalogRefs = item.catalogReferences;
  }

  Item _buildItem() {
    const id = '';
    return Item(
      id: _existingItemId ?? id,
      ownerId: '',
      itemType: _itemType,
      country: _countryCtrl.text.isEmpty ? null : _countryCtrl.text,
      issuingAuthority: _issuingCtrl.text.isEmpty ? null : _issuingCtrl.text,
      denomination: _denomCtrl.text.isEmpty ? null : _denomCtrl.text,
      denominationNumeric: double.tryParse(_denomNumCtrl.text),
      yearStart: int.tryParse(_yearStartCtrl.text),
      yearEnd: int.tryParse(_yearEndCtrl.text),
      mintMark: _mintMark,
      series: _series,
      variety: _varietyCtrl.text.isEmpty ? null : _varietyCtrl.text,
      isPublic: _isPublic,
      metal: _metal,
      weightGrams: double.tryParse(_weightCtrl.text),
      diameterMm: double.tryParse(_diameterCtrl.text),
      edgeType: _edgeType,
      coinOrientation: _coinOrientation,
      noteWidthMm: double.tryParse(_noteWidthCtrl.text),
      noteHeightMm: double.tryParse(_noteHeightCtrl.text),
      obverseDescription: _obverseCtrl.text.isEmpty ? null : _obverseCtrl.text,
      reverseDescription: _reverseCtrl.text.isEmpty ? null : _reverseCtrl.text,
      edgeDescription: _edgeDescCtrl.text.isEmpty ? null : _edgeDescCtrl.text,
      dieMarkers: _dieMarkersCtrl.text.isEmpty ? null : _dieMarkersCtrl.text,
      serialNumber: _serialCtrl.text.isEmpty ? null : _serialCtrl.text,
      serialBlock: _serialBlockCtrl.text.isEmpty ? null : _serialBlockCtrl.text,
      signatureCombination: _sigCombCtrl.text.isEmpty ? null : _sigCombCtrl.text,
      sealColor: _sealColorCtrl.text.isEmpty ? null : _sealColorCtrl.text,
      district: _districtCtrl.text.isEmpty ? null : _districtCtrl.text,
      plateNumberFront: _plateFrontCtrl.text.isEmpty ? null : _plateFrontCtrl.text,
      plateNumberBack: _plateBackCtrl.text.isEmpty ? null : _plateBackCtrl.text,
      isStarNote: _isStarNote,
      grade: _gradeCtrl.text.isEmpty ? null : _gradeCtrl.text,
      gradeNumeric: double.tryParse(_gradeNumCtrl.text),
      gradingCompany: _gradingCompany,
      certNumber: _certCtrl.text.isEmpty ? null : _certCtrl.text,
      isSlabbed: _isSlabbed,
      detailsGrade: _detailsGrade,
      detailsNote: _detailsNoteCtrl.text.isEmpty ? null : _detailsNoteCtrl.text,
      submissionStatus: _submissionStatus ?? 'raw',
      designation: _designation,
      holderGeneration: _holderGenCtrl.text.isEmpty ? null : _holderGenCtrl.text,
      populationObverse: int.tryParse(_popObverseCtrl.text),
      populationReverse: int.tryParse(_popReverseCtrl.text),
      certVerificationUrl: _certUrlCtrl.text.isEmpty ? null : _certUrlCtrl.text,
      quantityType: _quantityType,
      quantity: int.tryParse(_quantityCtrl.text) ?? 1,
      duplicateCount: int.tryParse(_dupCountCtrl.text) ?? 0,
      historicalContext: _historicalCtrl.text.isEmpty ? null : _historicalCtrl.text,
      attributionNotes: _attributionCtrl.text.isEmpty ? null : _attributionCtrl.text,
      provenance: _provenanceCtrl.text.isEmpty ? null : _provenanceCtrl.text,
      internalNotes: _internalCtrl.text.isEmpty ? null : _internalCtrl.text,
      catalogReferences: _catalogRefs,
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      final repo = ref.read(itemRepositoryProvider);
      final storageService = StorageService();
      final item = _buildItem();

      final saved = _existingItemId != null
          ? await repo.updateItem(item)
          : await repo.createItem(item);

      // Upload any pending images
      for (final pending in _pendingImages) {
        final path = await storageService.uploadItemImage(
          itemId: saved.id,
          imageType: pending.imageType,
          file: pending.file,
          isPublic: _isPublic,
        );
        final publicUrl = _isPublic
            ? storageService.getPublicUrl(path)
            : null;
        await repo.addImageRecord(ItemImage(
          itemId: saved.id,
          imageType: pending.imageType,
          storagePath: path,
          publicUrl: publicUrl,
          isPublic: _isPublic,
        ));
      }

      // Save acquisition if any cost data has been entered
      final hasAcqData = _purchaseDate != null ||
          _sourceType != null ||
          _purchasePriceCtrl.text.isNotEmpty;
      if (hasAcqData) {
        await ref.read(acquisitionRepositoryProvider).upsert(
              Acquisition(
                itemId: saved.id,
                purchaseDate: _purchaseDate,
                sourceType: _sourceType,
                sellerName: _sellerNameCtrl.text.isEmpty
                    ? null
                    : _sellerNameCtrl.text,
                sellerContact: _sellerContactCtrl.text.isEmpty
                    ? null
                    : _sellerContactCtrl.text,
                lotNumber: _lotNumberCtrl.text.isEmpty
                    ? null
                    : _lotNumberCtrl.text,
                purchasePrice: double.tryParse(_purchasePriceCtrl.text),
                buyersPremium: double.tryParse(_buyersPremiumCtrl.text),
                shippingCost: double.tryParse(_shippingCostCtrl.text),
                taxPaid: double.tryParse(_taxPaidCtrl.text),
                otherFees: double.tryParse(_otherFeesCtrl.text),
                paymentMethod: _paymentMethod,
                costBasisType: _costBasisType,
                notes:
                    _acqNotesCtrl.text.isEmpty ? null : _acqNotesCtrl.text,
              ),
            );
      }

      ref.read(itemsListProvider.notifier).refresh();

      if (mounted) {
        context.go('/items/${saved.id}');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _pickImage(String imageType) async {
    final picker = ImagePicker();
    final xFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 90);
    if (xFile != null) {
      setState(() {
        _pendingImages.add(_PendingImage(File(xFile.path), imageType));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final isEdit = _existingItemId != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Item' : 'Add Item'),
        actions: [
          if (_saving)
            const Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox(
                width: 20, height: 20,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: Colors.white),
              ),
            )
          else
            TextButton(
              onPressed: _save,
              child: const Text('Save', style: TextStyle(color: Colors.white)),
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _sectionHeader('Item Type'),
            _itemTypeSelector(),
            const SizedBox(height: 16),

            _sectionHeader('Basic Identity'),
            _identityFields(),
            const SizedBox(height: 16),

            if (_itemType == 'coin' || _itemType == 'token' || _itemType == 'medal') ...[
              _sectionHeader('Physical Details (Coin)'),
              _coinPhysicalFields(),
              const SizedBox(height: 16),
              _sectionHeader('Obverse / Reverse / Edge'),
              _coinDescriptionFields(),
              const SizedBox(height: 16),
            ],

            if (_itemType == 'note') ...[
              _sectionHeader('Physical Details (Note)'),
              _notePhysicalFields(),
              const SizedBox(height: 16),
              _sectionHeader('Note-Specific Fields'),
              _noteSpecificFields(),
              const SizedBox(height: 16),
            ],

            _sectionHeader('Condition & Certification'),
            _conditionFields(),
            const SizedBox(height: 16),

            _sectionHeader('Catalog References'),
            CatalogRefForm(
              initialRefs: _catalogRefs,
              onChanged: (refs) => setState(() => _catalogRefs = refs),
            ),
            const SizedBox(height: 16),

            _sectionHeader('Quantity'),
            _quantityFields(),
            const SizedBox(height: 16),

            _sectionHeader('Images'),
            _imageSection(),
            const SizedBox(height: 16),

            _sectionHeader('Notes & Research'),
            _notesFields(),
            const SizedBox(height: 16),

            _sectionHeader('Acquisition'),
            _acquisitionFields(),
            const SizedBox(height: 16),

            _sectionHeader('Visibility'),
            SwitchListTile(
              title: const Text('Public on website'),
              subtitle: const Text('Show this item on vincenzofazeli.com'),
              value: _isPublic,
              onChanged: (v) => setState(() => _isPublic = v),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(title,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: AppColors.primary)),
      );

  Widget _itemTypeSelector() => Wrap(
        spacing: 8,
        children: DbConstants.itemTypes.map((type) {
          final selected = _itemType == type;
          return FilterChip(
            label: Text(type[0].toUpperCase() + type.substring(1)),
            selected: selected,
            onSelected: (_) => setState(() => _itemType = type),
            selectedColor: AppColors.primary.withValues(alpha: 0.2),
            checkmarkColor: AppColors.primary,
          );
        }).toList(),
      );

  Widget _identityFields() => Column(
        children: [
          Row(
            children: [
              Expanded(child: _autocompleteField(
                label: 'Country',
                controller: _countryCtrl,
                options: DbConstants.countries,
              )),
              const SizedBox(width: 12),
              Expanded(child: _field('Issuing Authority', _issuingCtrl)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _field('Denomination', _denomCtrl)),
              const SizedBox(width: 12),
              Expanded(child: _field('Value (numeric)', _denomNumCtrl,
                  keyboardType: TextInputType.number)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _field('Year', _yearStartCtrl,
                  keyboardType: TextInputType.number)),
              const SizedBox(width: 12),
              Expanded(child: _field('Year end (sets)', _yearEndCtrl,
                  keyboardType: TextInputType.number)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _mintMark,
                  decoration: const InputDecoration(labelText: 'Mint Mark'),
                  isExpanded: true,
                  items: [
                    const DropdownMenuItem(value: null, child: Text('— None —')),
                    ...DbConstants.mintMarks.map((m) =>
                        DropdownMenuItem(value: m, child: Text(m))),
                  ],
                  onChanged: (v) => setState(() => _mintMark = v),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _series,
                  decoration: const InputDecoration(labelText: 'Series'),
                  isExpanded: true,
                  items: [
                    const DropdownMenuItem(value: null, child: Text('— None —')),
                    ..._seriesOptions().map((s) =>
                        DropdownMenuItem(value: s, child: Text(s))),
                  ],
                  onChanged: (v) => setState(() => _series = v),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _field('Variety', _varietyCtrl),
        ],
      );

  List<String> _seriesOptions() {
    if (_itemType == 'note') {
      return DbConstants.browseCategories
          .firstWhere((c) => c.id == 'paper_money')
          .subcategories
          .where((s) => !s.startsWith('All'))
          .toList();
    }
    if (_itemType == 'token' || _itemType == 'medal') {
      return DbConstants.browseCategories
          .firstWhere((c) => c.id == 'exonumia')
          .subcategories
          .where((s) => !s.startsWith('All'))
          .toList();
    }
    // coin — show US + World subcategories
    return [
      ...DbConstants.browseCategories
          .firstWhere((c) => c.id == 'us_coins')
          .subcategories
          .where((s) => !s.startsWith('All')),
      ...DbConstants.browseCategories
          .firstWhere((c) => c.id == 'world_coins')
          .subcategories
          .where((s) => !s.startsWith('All')),
    ];
  }

  Widget _coinPhysicalFields() => Column(
        children: [
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _metal,
                  decoration: const InputDecoration(labelText: 'Metal'),
                  isExpanded: true,
                  items: [
                    const DropdownMenuItem(value: null, child: Text('— Select —')),
                    ...DbConstants.metals.map((m) =>
                        DropdownMenuItem(value: m, child: Text(m))),
                  ],
                  onChanged: (v) => setState(() => _metal = v),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(child: _field('Weight (g)', _weightCtrl,
                  keyboardType: TextInputType.number)),
              const SizedBox(width: 12),
              Expanded(child: _field('Diameter (mm)', _diameterCtrl,
                  keyboardType: TextInputType.number)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _edgeType,
                  decoration: const InputDecoration(labelText: 'Edge Type'),
                  items: const [
                    DropdownMenuItem(value: 'reeded', child: Text('Reeded')),
                    DropdownMenuItem(value: 'plain', child: Text('Plain')),
                    DropdownMenuItem(value: 'lettered', child: Text('Lettered')),
                    DropdownMenuItem(value: 'segmented', child: Text('Segmented')),
                    DropdownMenuItem(value: 'other', child: Text('Other')),
                  ],
                  onChanged: (v) => setState(() => _edgeType = v),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _coinOrientation,
                  decoration: const InputDecoration(labelText: 'Orientation'),
                  items: const [
                    DropdownMenuItem(value: 'coin', child: Text('Coin turn')),
                    DropdownMenuItem(value: 'medal', child: Text('Medal turn')),
                  ],
                  onChanged: (v) => setState(() => _coinOrientation = v),
                ),
              ),
            ],
          ),
        ],
      );

  Widget _coinDescriptionFields() => Column(
        children: [
          _field('Obverse description', _obverseCtrl, maxLines: 2),
          const SizedBox(height: 12),
          _field('Reverse description', _reverseCtrl, maxLines: 2),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _field('Edge description', _edgeDescCtrl)),
              const SizedBox(width: 12),
              Expanded(child: _field('Die markers', _dieMarkersCtrl)),
            ],
          ),
        ],
      );

  Widget _notePhysicalFields() => Row(
        children: [
          Expanded(child: _field('Width (mm)', _noteWidthCtrl,
              keyboardType: TextInputType.number)),
          const SizedBox(width: 12),
          Expanded(child: _field('Height (mm)', _noteHeightCtrl,
              keyboardType: TextInputType.number)),
        ],
      );

  Widget _noteSpecificFields() => Column(
        children: [
          Row(
            children: [
              Expanded(child: _field('Serial Number', _serialCtrl)),
              const SizedBox(width: 12),
              Expanded(child: _field('Block', _serialBlockCtrl)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _field('Signature Combination', _sigCombCtrl)),
              const SizedBox(width: 12),
              Expanded(child: _field('Seal Color', _sealColorCtrl)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _field('District', _districtCtrl)),
              const SizedBox(width: 12),
              Expanded(child: _field('Plate # Front', _plateFrontCtrl)),
              const SizedBox(width: 12),
              Expanded(child: _field('Plate # Back', _plateBackCtrl)),
            ],
          ),
          SwitchListTile(
            title: const Text('Star / Replacement Note'),
            value: _isStarNote,
            onChanged: (v) => setState(() => _isStarNote = v),
            contentPadding: EdgeInsets.zero,
          ),
        ],
      );

  Widget _conditionFields() => Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _autocompleteField(
                  label: 'Grade',
                  controller: _gradeCtrl,
                  options: _itemType == 'note'
                      ? DbConstants.noteGrades
                      : DbConstants.coinGrades,
                  onSelected: (g) {
                    _gradeCtrl.text = g;
                    // Auto-fill numeric from grade string (e.g. "MS-65" → 65)
                    final num = RegExp(r'(\d+)$').firstMatch(g)?.group(1);
                    if (num != null) _gradeNumCtrl.text = num;
                    setState(() {});
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(child: _field('Grade (numeric)', _gradeNumCtrl,
                  keyboardType: TextInputType.number)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _gradingCompany,
                  decoration:
                      const InputDecoration(labelText: 'Grading Company'),
                  items: DbConstants.gradingCompanies
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (v) => setState(() {
                    _gradingCompany = v;
                    if (v != null && v != 'Raw') _isSlabbed = true;
                  }),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(child: _field('Cert Number', _certCtrl)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: CheckboxListTile(
                  title: const Text('Slabbed'),
                  value: _isSlabbed,
                  onChanged: (v) => setState(() => _isSlabbed = v!),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              Expanded(
                child: CheckboxListTile(
                  title: const Text('Details grade'),
                  value: _detailsGrade,
                  onChanged: (v) => setState(() => _detailsGrade = v!),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
          if (_detailsGrade) ...[
            const SizedBox(height: 12),
            _field('Details note (e.g. cleaned, holed)', _detailsNoteCtrl),
          ],
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _designation,
                  decoration: const InputDecoration(labelText: 'Designation'),
                  items: [null, ...DbConstants.designations]
                      .map((d) => DropdownMenuItem(
                          value: d, child: Text(d ?? 'None')))
                      .toList(),
                  onChanged: (v) => setState(() => _designation = v),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _submissionStatus,
                  decoration:
                      const InputDecoration(labelText: 'Status'),
                  items: const [
                    DropdownMenuItem(value: 'raw', child: Text('Raw')),
                    DropdownMenuItem(
                        value: 'submitted', child: Text('Submitted')),
                    DropdownMenuItem(
                        value: 'returned', child: Text('Returned')),
                    DropdownMenuItem(
                        value: 'crossed', child: Text('Crossed over')),
                    DropdownMenuItem(
                        value: 'reholdered', child: Text('Reholdered')),
                  ],
                  onChanged: (v) => setState(() => _submissionStatus = v),
                ),
              ),
            ],
          ),
          if (_isSlabbed) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _field('Holder generation', _holderGenCtrl)),
                const SizedBox(width: 12),
                Expanded(child: _field('Pop obverse', _popObverseCtrl,
                    keyboardType: TextInputType.number)),
                const SizedBox(width: 12),
                Expanded(child: _field('Pop reverse', _popReverseCtrl,
                    keyboardType: TextInputType.number)),
              ],
            ),
            const SizedBox(height: 12),
            _field('Cert verification URL', _certUrlCtrl,
                keyboardType: TextInputType.url),
          ],
        ],
      );

  Widget _quantityFields() => Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<String>(
              value: _quantityType,
              decoration: const InputDecoration(labelText: 'Type'),
              items: const [
                DropdownMenuItem(value: 'single', child: Text('Single')),
                DropdownMenuItem(value: 'roll', child: Text('Roll')),
                DropdownMenuItem(
                    value: 'partial_roll', child: Text('Partial roll')),
                DropdownMenuItem(value: 'lot', child: Text('Lot')),
                DropdownMenuItem(value: 'set', child: Text('Set')),
              ],
              onChanged: (v) => setState(() => _quantityType = v!),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: _field('Quantity', _quantityCtrl,
              keyboardType: TextInputType.number)),
          const SizedBox(width: 12),
          Expanded(child: _field('Duplicates', _dupCountCtrl,
              keyboardType: TextInputType.number)),
        ],
      );

  Widget _imageSection() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _imagePickerButton('Obverse', Icons.circle_outlined),
              _imagePickerButton('Reverse', Icons.circle),
              _imagePickerButton('Edge', Icons.horizontal_rule),
              _imagePickerButton('Slab front', Icons.verified_outlined),
              _imagePickerButton('Close-up', Icons.zoom_in),
              _imagePickerButton('Receipt', Icons.receipt_outlined),
            ],
          ),
          if (_pendingImages.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text('${_pendingImages.length} image(s) pending upload',
                style: const TextStyle(color: AppColors.primary)),
          ],
        ],
      );

  Widget _imagePickerButton(String label, IconData icon) => OutlinedButton.icon(
        icon: Icon(icon, size: 16),
        label: Text(label),
        onPressed: () => _pickImage(label.toLowerCase().replaceAll(' ', '_')),
      );

  Widget _notesFields() => Column(
        children: [
          _field('Historical context', _historicalCtrl, maxLines: 3),
          const SizedBox(height: 12),
          _field('Attribution notes', _attributionCtrl, maxLines: 2),
          const SizedBox(height: 12),
          _field('Provenance', _provenanceCtrl, maxLines: 2),
          const SizedBox(height: 12),
          _field('Internal notes (private)', _internalCtrl, maxLines: 2),
        ],
      );

  Widget _acquisitionFields() {
    final computed = (double.tryParse(_purchasePriceCtrl.text) ?? 0) +
        (double.tryParse(_buyersPremiumCtrl.text) ?? 0) +
        (double.tryParse(_shippingCostCtrl.text) ?? 0) +
        (double.tryParse(_taxPaidCtrl.text) ?? 0) +
        (double.tryParse(_otherFeesCtrl.text) ?? 0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Date + source
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _purchaseDate ?? DateTime.now(),
                    firstDate: DateTime(1800),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) setState(() => _purchaseDate = picked);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Purchase date',
                    suffixIcon: Icon(Icons.calendar_today_outlined, size: 18),
                  ),
                  child: Text(
                    _purchaseDate != null
                        ? DateFormat('MMM d, yyyy').format(_purchaseDate!)
                        : 'Tap to select',
                    style: TextStyle(
                      color: _purchaseDate != null ? null : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DropdownButtonFormField<String>(
                value: _sourceType,
                decoration: const InputDecoration(labelText: 'Source'),
                items: const [
                  DropdownMenuItem(value: 'dealer', child: Text('Dealer')),
                  DropdownMenuItem(value: 'auction', child: Text('Auction')),
                  DropdownMenuItem(
                      value: 'estate', child: Text('Estate sale')),
                  DropdownMenuItem(value: 'trade', child: Text('Trade')),
                  DropdownMenuItem(value: 'gift', child: Text('Gift')),
                  DropdownMenuItem(
                      value: 'inherited', child: Text('Inherited')),
                  DropdownMenuItem(value: 'found', child: Text('Found')),
                  DropdownMenuItem(
                      value: 'unknown', child: Text('Unknown')),
                ],
                onChanged: (v) => setState(() => _sourceType = v),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Cost basis + payment method
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                value: _costBasisType,
                decoration: const InputDecoration(labelText: 'Cost basis'),
                items: const [
                  DropdownMenuItem(
                      value: 'known', child: Text('Known cost')),
                  DropdownMenuItem(
                      value: 'gifted', child: Text('Gifted (no cost)')),
                  DropdownMenuItem(
                      value: 'inherited', child: Text('Inherited')),
                  DropdownMenuItem(
                      value: 'found', child: Text('Found')),
                  DropdownMenuItem(
                      value: 'unknown', child: Text('Unknown cost')),
                ],
                onChanged: (v) =>
                    setState(() => _costBasisType = v ?? 'known'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DropdownButtonFormField<String>(
                value: _paymentMethod,
                decoration:
                    const InputDecoration(labelText: 'Payment method'),
                items: const [
                  DropdownMenuItem(value: 'cash', child: Text('Cash')),
                  DropdownMenuItem(value: 'check', child: Text('Check')),
                  DropdownMenuItem(
                      value: 'credit_card', child: Text('Credit card')),
                  DropdownMenuItem(
                      value: 'paypal', child: Text('PayPal')),
                  DropdownMenuItem(
                      value: 'wire', child: Text('Wire transfer')),
                  DropdownMenuItem(value: 'trade', child: Text('Trade')),
                  DropdownMenuItem(value: 'other', child: Text('Other')),
                ],
                onChanged: (v) => setState(() => _paymentMethod = v),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Seller info
        Row(
          children: [
            Expanded(child: _field('Seller / dealer name', _sellerNameCtrl)),
            const SizedBox(width: 12),
            Expanded(
                child: _field('Seller contact / URL', _sellerContactCtrl)),
          ],
        ),
        const SizedBox(height: 12),
        _field('Auction lot number', _lotNumberCtrl),
        const SizedBox(height: 16),

        // Costs
        Text('Costs',
            style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
                child: _field('Hammer / purchase price', _purchasePriceCtrl,
                    keyboardType: TextInputType.number, prefix: '\$')),
            const SizedBox(width: 12),
            Expanded(
                child: _field("Buyer's premium", _buyersPremiumCtrl,
                    keyboardType: TextInputType.number, prefix: '\$')),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
                child: _field('Shipping', _shippingCostCtrl,
                    keyboardType: TextInputType.number, prefix: '\$')),
            const SizedBox(width: 12),
            Expanded(
                child: _field('Tax paid', _taxPaidCtrl,
                    keyboardType: TextInputType.number, prefix: '\$')),
            const SizedBox(width: 12),
            Expanded(
                child: _field('Other fees', _otherFeesCtrl,
                    keyboardType: TextInputType.number, prefix: '\$')),
          ],
        ),
        const SizedBox(height: 12),

        // Live total banner
        if (computed > 0)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(10),
              border:
                  Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
            ),
            child: Row(
              children: [
                const Icon(Icons.calculate_outlined,
                    size: 16, color: AppColors.primary),
                const SizedBox(width: 8),
                Text('Total cost: ',
                    style: TextStyle(
                        fontSize: 13, color: Colors.grey.shade600)),
                Text(
                  '\$${computed.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 6),
                Text('(saved to DB)',
                    style: TextStyle(
                        fontSize: 11, color: Colors.grey.shade400)),
              ],
            ),
          ),
        const SizedBox(height: 12),

        _field('Acquisition notes', _acqNotesCtrl, maxLines: 2),
      ],
    );
  }

  Widget _field(
    String label,
    TextEditingController ctrl, {
    TextInputType? keyboardType,
    int maxLines = 1,
    String? hint,
    String? prefix,
  }) =>
      TextFormField(
        controller: ctrl,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixText: prefix,
        ),
      );

  Widget _autocompleteField({
    required String label,
    required TextEditingController controller,
    required List<String> options,
    void Function(String)? onSelected,
  }) {
    return Autocomplete<String>(
      initialValue: TextEditingValue(text: controller.text),
      optionsBuilder: (value) {
        if (value.text.isEmpty) return const [];
        final q = value.text.toLowerCase();
        return options.where((o) => o.toLowerCase().contains(q)).take(8);
      },
      onSelected: (selection) {
        controller.text = selection;
        onSelected?.call(selection);
        setState(() {});
      },
      fieldViewBuilder: (context, textCtrl, focusNode, onSubmitted) {
        // Keep external controller in sync
        textCtrl.text = controller.text;
        textCtrl.selection = TextSelection.collapsed(offset: textCtrl.text.length);
        return TextFormField(
          controller: textCtrl,
          focusNode: focusNode,
          decoration: InputDecoration(labelText: label),
          onChanged: (v) => controller.text = v,
        );
      },
    );
  }
}

class _PendingImage {
  final File file;
  final String imageType;
  _PendingImage(this.file, this.imageType);
}
