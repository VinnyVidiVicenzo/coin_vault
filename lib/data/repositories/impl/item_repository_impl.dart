import '../../models/item.dart';
import '../../models/catalog_reference.dart';
import '../../models/item_image.dart';
import '../../remote/supabase/supabase_client.dart';
import '../../../core/constants/db_constants.dart';
import '../../local/app_database.dart';
import '../../../core/services/connectivity_service.dart';

class OfflineException implements Exception {
  const OfflineException();
  @override
  String toString() =>
      'You are offline. Connect to the internet to save changes.';
}

class ItemRepository {
  final AppDatabase? _db;
  final ConnectivityService? _connectivity;

  ItemRepository({AppDatabase? db, ConnectivityService? connectivity})
      : _db = db,
        _connectivity = connectivity;

  Future<bool> _isOnline() async =>
      _connectivity == null ? true : _connectivity!.isOnline;

  // ── List ──────────────────────────────────────────────────
  Future<List<Item>> fetchItems({
    String? itemType,
    String? country,
    String? gradingCompany,
    bool? isSlabbed,
    String? series,
    double? minGrade,
    double? maxGrade,
    String? mintMark,
    int? minYear,
    int? maxYear,
    String sortBy = 'date_added',
    int limit = 50,
    int offset = 0,
  }) async {
    if (!await _isOnline()) {
      return _db?.getCachedItems(
            itemType: itemType,
            country: country,
            gradingCompany: gradingCompany,
            isSlabbed: isSlabbed,
            series: series,
            minGrade: minGrade,
            maxGrade: maxGrade,
            mintMark: mintMark,
            minYear: minYear,
            maxYear: maxYear,
            sortBy: sortBy,
            limit: limit,
            offset: offset,
          ) ??
          [];
    }

    var q = supabase
        .from(DbConstants.items)
        .select('*, catalog_references(*), item_images(*)');

    if (itemType != null) q = q.eq('item_type', itemType);
    if (country != null) q = q.ilike('country', '%$country%');
    if (gradingCompany != null) q = q.eq('grading_company', gradingCompany);
    if (isSlabbed != null) q = q.eq('is_slabbed', isSlabbed);
    if (series != null &&
        series != 'All US Coins' &&
        series != 'All World & Ancient' &&
        series != 'All Paper Money' &&
        series != 'All Exonumia') {
      q = q.ilike('series', '%$series%');
    }
    if (minGrade != null) q = q.gte('grade_numeric', minGrade);
    if (maxGrade != null) q = q.lte('grade_numeric', maxGrade);
    if (mintMark != null) q = q.ilike('mint_mark', '%$mintMark%');
    if (minYear != null) q = q.gte('year_start', minYear);
    if (maxYear != null) q = q.lte('year_start', maxYear);

    final orderCol = switch (sortBy) {
      'year' => 'year_start',
      'grade' => 'grade_numeric',
      _ => 'updated_at',
    };

    final data = await q
        .order(orderCol, ascending: sortBy == 'year')
        .range(offset, offset + limit - 1) as List;
    final items =
        data.map((row) => _rowToItem(row as Map<String, dynamic>)).toList();

    // Populate cache for offline use
    if (_db != null) await _db!.cacheItems(items);

    return items;
  }

  Future<List<Item>> searchItems(String query, {int limit = 30}) async {
    if (!await _isOnline()) {
      return _db?.searchCachedItems(query) ?? [];
    }

    final data = await supabase
        .from(DbConstants.items)
        .select('*, catalog_references(*), item_images(*)')
        .textSearch('search_vector', query)
        .limit(limit) as List;
    return data.map((row) => _rowToItem(row as Map<String, dynamic>)).toList();
  }

  // ── Single item ───────────────────────────────────────────
  Future<Item?> fetchItem(String id) async {
    if (!await _isOnline()) {
      return _db?.getCachedItem(id);
    }

    final data = await supabase
        .from(DbConstants.items)
        .select('*, catalog_references(*), item_images(*)')
        .eq('id', id)
        .maybeSingle();
    if (data == null) return null;
    final item = _rowToItem(data);
    if (_db != null) await _db!.cacheItem(item);
    return item;
  }

  // ── Create ────────────────────────────────────────────────
  Future<Item> createItem(Item item) async {
    if (!await _isOnline()) throw const OfflineException();

    final payload = _itemToRow(item)
      ..remove('id')
      ..remove('created_at')
      ..remove('updated_at');
    payload['owner_id'] = supabase.auth.currentUser!.id;

    final data = await supabase
        .from(DbConstants.items)
        .insert(payload)
        .select()
        .single();

    if (item.catalogReferences.isNotEmpty) {
      final refs = item.catalogReferences
          .map((r) => _refToRow(r)
            ..['item_id'] = data['id']
            ..remove('id'))
          .toList();
      await supabase.from(DbConstants.catalogReferences).insert(refs);
    }

    final created = (await fetchItem(data['id'] as String))!;
    if (_db != null) await _db!.cacheItem(created);
    return created;
  }

  // ── Update ────────────────────────────────────────────────
  Future<Item> updateItem(Item item) async {
    if (!await _isOnline()) throw const OfflineException();

    final payload = _itemToRow(item)
      ..remove('created_at')
      ..remove('owner_id');

    await supabase
        .from(DbConstants.items)
        .update(payload)
        .eq('id', item.id);

    await supabase
        .from(DbConstants.catalogReferences)
        .delete()
        .eq('item_id', item.id);

    if (item.catalogReferences.isNotEmpty) {
      final refs = item.catalogReferences
          .map((r) => _refToRow(r)
            ..['item_id'] = item.id
            ..remove('id'))
          .toList();
      await supabase.from(DbConstants.catalogReferences).insert(refs);
    }

    final updated = (await fetchItem(item.id))!;
    if (_db != null) await _db!.cacheItem(updated);
    return updated;
  }

  // ── Delete ────────────────────────────────────────────────
  Future<void> deleteItem(String id) async {
    if (!await _isOnline()) throw const OfflineException();

    await supabase.from(DbConstants.items).delete().eq('id', id);
    if (_db != null) await _db!.deleteCachedItem(id);
  }

  // ── Toggle public ─────────────────────────────────────────
  Future<void> setPublic(String id, bool isPublic) async {
    if (!await _isOnline()) throw const OfflineException();

    await supabase
        .from(DbConstants.items)
        .update({'is_public': isPublic}).eq('id', id);
  }

  // ── Image record ──────────────────────────────────────────
  Future<ItemImage> addImageRecord(ItemImage image) async {
    if (!await _isOnline()) throw const OfflineException();

    final data = await supabase
        .from(DbConstants.itemImages)
        .insert({
          'item_id': image.itemId,
          'image_type': image.imageType,
          'storage_path': image.storagePath,
          'public_url': image.publicUrl,
          'is_public': image.isPublic,
          'display_order': image.displayOrder,
          'caption': image.caption,
          'owner_id': supabase.auth.currentUser!.id,
        })
        .select()
        .single();
    return ItemImage.fromJson(Map<String, dynamic>.from(data));
  }

  Future<void> deleteImageRecord(String imageId) async {
    if (!await _isOnline()) throw const OfflineException();

    await supabase.from(DbConstants.itemImages).delete().eq('id', imageId);
  }

  // ── Dashboard stats ───────────────────────────────────────
  Future<Map<String, dynamic>> fetchStats() async {
    final userId = supabase.auth.currentUser!.id;
    final countResult = await supabase
        .from(DbConstants.items)
        .select('id')
        .eq('owner_id', userId);
    final total = (countResult as List).length;

    final ebayActive = await supabase
        .from(DbConstants.ebayListings)
        .select('id')
        .eq('owner_id', userId)
        .eq('listing_status', 'active');

    return {
      'total_items': total,
      'active_ebay': (ebayActive as List).length,
    };
  }

  // ── Serialization helpers ─────────────────────────────────
  Item _rowToItem(Map<String, dynamic> row) {
    final refs = (row['catalog_references'] as List? ?? [])
        .map((r) => CatalogReference.fromJson(Map<String, dynamic>.from(r)))
        .toList();
    final images = (row['item_images'] as List? ?? [])
        .map((i) => ItemImage.fromJson(Map<String, dynamic>.from(i)))
        .toList();
    final cleaned = Map<String, dynamic>.from(row)
      ..remove('catalog_references')
      ..remove('item_images')
      ..remove('search_vector');
    return Item.fromJson(cleaned).copyWith(
      catalogReferences: refs,
      images: images,
    );
  }

  Map<String, dynamic> _itemToRow(Item item) => {
        'id': item.id,
        'owner_id': item.ownerId,
        'item_type': item.itemType,
        'country': item.country,
        'issuing_authority': item.issuingAuthority,
        'denomination': item.denomination,
        'denomination_numeric': item.denominationNumeric,
        'year_start': item.yearStart,
        'year_end': item.yearEnd,
        'mint_mark': item.mintMark,
        'series': item.series,
        'variety': item.variety,
        'is_public': item.isPublic,
        'metal': item.metal,
        'weight_grams': item.weightGrams,
        'diameter_mm': item.diameterMm,
        'edge_type': item.edgeType,
        'coin_orientation': item.coinOrientation,
        'note_width_mm': item.noteWidthMm,
        'note_height_mm': item.noteHeightMm,
        'obverse_description': item.obverseDescription,
        'reverse_description': item.reverseDescription,
        'edge_description': item.edgeDescription,
        'die_markers': item.dieMarkers,
        'serial_number': item.serialNumber,
        'serial_block': item.serialBlock,
        'signature_combination': item.signatureCombination,
        'seal_color': item.sealColor,
        'district': item.district,
        'plate_number_front': item.plateNumberFront,
        'plate_number_back': item.plateNumberBack,
        'is_star_note': item.isStarNote,
        'grade': item.grade,
        'grade_numeric': item.gradeNumeric,
        'grading_company': item.gradingCompany,
        'cert_number': item.certNumber,
        'is_slabbed': item.isSlabbed,
        'details_grade': item.detailsGrade,
        'details_note': item.detailsNote,
        'defects': item.defects,
        'designation': item.designation,
        'holder_generation': item.holderGeneration,
        'population_obverse': item.populationObverse,
        'population_reverse': item.populationReverse,
        'cert_verification_url': item.certVerificationUrl,
        'submission_status': item.submissionStatus,
        'quantity_type': item.quantityType,
        'quantity': item.quantity,
        'duplicate_count': item.duplicateCount,
        'historical_context': item.historicalContext,
        'attribution_notes': item.attributionNotes,
        'provenance': item.provenance,
        'research_links': item.researchLinks,
        'internal_notes': item.internalNotes,
      };

  Map<String, dynamic> _refToRow(CatalogReference ref) => {
        'item_id': ref.itemId,
        'catalog_system': ref.catalogSystem,
        'reference_number': ref.referenceNumber,
        'variety_name': ref.varietyName,
        'die_pair': ref.diePair,
        'attribution_confidence': ref.attributionConfidence,
        'attribution_source': ref.attributionSource,
        'notes': ref.notes,
      };
}
