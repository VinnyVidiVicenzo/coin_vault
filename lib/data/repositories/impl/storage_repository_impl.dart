import '../../models/storage_location.dart';
import '../../remote/supabase/supabase_client.dart';
import '../../../core/constants/db_constants.dart';

class StorageRepository {
  // ── Locations ───────────────────────────────────────────────────

  Future<List<StorageLocation>> fetchLocations() async {
    final data = await supabase
        .from(DbConstants.storageLocations)
        .select()
        .eq('is_active', true)
        .order('location_name') as List;
    return data
        .map((r) => StorageLocation.fromJson(Map<String, dynamic>.from(r)))
        .toList();
  }

  Future<StorageLocation> upsertLocation(StorageLocation loc) async {
    final payload = <String, dynamic>{
      'owner_id': supabase.auth.currentUser!.id,
      'location_name': loc.locationName,
      'location_type': loc.locationType,
      'environment_notes': loc.environmentNotes,
      'is_active': loc.isActive,
    };
    if (loc.id != null) payload['id'] = loc.id!;

    final data = await supabase
        .from(DbConstants.storageLocations)
        .upsert(payload)
        .select()
        .single();
    return StorageLocation.fromJson(Map<String, dynamic>.from(data));
  }

  // ── Item storage assignments ────────────────────────────────────

  Future<ItemStorage?> fetchForItem(String itemId) async {
    final data = await supabase
        .from(DbConstants.itemStorage)
        .select('*, storage_locations(*)')
        .eq('item_id', itemId)
        .maybeSingle();
    if (data == null) return null;
    return _parse(data);
  }

  Future<List<ItemStorage>> fetchAll() async {
    final data = await supabase
        .from(DbConstants.itemStorage)
        .select('*, storage_locations(*)')
        .order('container_label') as List;
    return data.map((r) => _parse(r)).toList();
  }

  Future<ItemStorage> upsert(ItemStorage s) async {
    final payload = <String, dynamic>{
      'item_id': s.itemId,
      'storage_location_id': s.storageLocationId,
      'owner_id': supabase.auth.currentUser!.id,
      'container_type': s.containerType,
      'container_label': s.containerLabel,
      'slot_envelope_number': s.slotEnvelopeNumber,
      'holder_type': s.holderType,
      'environment_notes': s.environmentNotes,
      'last_verified_date':
          s.lastVerifiedDate?.toIso8601String().substring(0, 10),
      'notes': s.notes,
    };

    final data = await supabase
        .from(DbConstants.itemStorage)
        .upsert(payload, onConflict: 'item_id')
        .select()
        .single();
    return _parse(data);
  }

  Future<void> delete(String itemId) async {
    await supabase
        .from(DbConstants.itemStorage)
        .delete()
        .eq('item_id', itemId);
  }

  // Supabase returns nested table as 'storage_locations', but the model field
  // is named 'location'. Extract and re-attach manually.
  ItemStorage _parse(Map<dynamic, dynamic> raw) {
    final row = Map<String, dynamic>.from(raw);
    final locData = row.remove('storage_locations');
    final storage = ItemStorage.fromJson(row);
    if (locData != null) {
      return storage.copyWith(
        location: StorageLocation.fromJson(Map<String, dynamic>.from(locData)),
      );
    }
    return storage;
  }
}
