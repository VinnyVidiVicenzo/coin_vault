import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/models/item.dart';
import '../../../data/models/catalog_reference.dart';
import '../../../data/models/item_image.dart';
import '../../../data/remote/supabase/storage_service.dart';
import '../../providers/items/items_provider.dart';
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
  final _mintMarkCtrl = TextEditingController();
  final _seriesCtrl = TextEditingController();
  final _varietyCtrl = TextEditingController();
  bool _isPublic = false;

  // Physical — coins
  final _metalCtrl = TextEditingController();
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

  @override
  void initState() {
    super.initState();
    _loadExisting();
  }

  Future<void> _loadExisting() async {
    if (widget.itemId != null && widget.itemId != 'new') {
      final item = await ref.read(itemRepositoryProvider).fetchItem(widget.itemId!);
      if (item != null && mounted) _populateForm(item);
    }
    if (mounted) setState(() => _loading = false);
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
    _mintMarkCtrl.text = item.mintMark ?? '';
    _seriesCtrl.text = item.series ?? '';
    _varietyCtrl.text = item.variety ?? '';
    _isPublic = item.isPublic;
    _metalCtrl.text = item.metal ?? '';
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
      mintMark: _mintMarkCtrl.text.isEmpty ? null : _mintMarkCtrl.text,
      series: _seriesCtrl.text.isEmpty ? null : _seriesCtrl.text,
      variety: _varietyCtrl.text.isEmpty ? null : _varietyCtrl.text,
      isPublic: _isPublic,
      metal: _metalCtrl.text.isEmpty ? null : _metalCtrl.text,
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
              Expanded(child: _field('Country', _countryCtrl)),
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
              Expanded(child: _field('Mint Mark', _mintMarkCtrl)),
              const SizedBox(width: 12),
              Expanded(child: _field('Series', _seriesCtrl)),
            ],
          ),
          const SizedBox(height: 12),
          _field('Variety', _varietyCtrl),
        ],
      );

  Widget _coinPhysicalFields() => Column(
        children: [
          Row(
            children: [
              Expanded(child: _field('Metal', _metalCtrl)),
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
              Expanded(child: _field('Grade', _gradeCtrl,
                  hint: 'e.g. MS65, VF30')),
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

  Widget _field(
    String label,
    TextEditingController ctrl, {
    TextInputType? keyboardType,
    int maxLines = 1,
    String? hint,
  }) =>
      TextFormField(
        controller: ctrl,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(labelText: label, hintText: hint),
      );
}

class _PendingImage {
  final File file;
  final String imageType;
  _PendingImage(this.file, this.imageType);
}
