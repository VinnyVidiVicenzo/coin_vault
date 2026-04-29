import '../../models/valuation.dart';
import '../../remote/supabase/supabase_client.dart';
import '../../../core/constants/db_constants.dart';

class ValuationRepository {
  Future<List<Valuation>> fetchForItem(String itemId) async {
    final data = await supabase
        .from(DbConstants.valuationHistory)
        .select()
        .eq('item_id', itemId)
        .order('valuation_date', ascending: false) as List;
    return data
        .map((r) => Valuation.fromJson(Map<String, dynamic>.from(r)))
        .toList();
  }

  Future<Valuation?> fetchLatest(String itemId) async {
    final data = await supabase
        .from(DbConstants.valuationHistory)
        .select()
        .eq('item_id', itemId)
        .order('valuation_date', ascending: false)
        .limit(1)
        .maybeSingle();
    if (data == null) return null;
    return Valuation.fromJson(Map<String, dynamic>.from(data));
  }

  Future<Valuation> add(Valuation v) async {
    final data = await supabase
        .from(DbConstants.valuationHistory)
        .insert({
          'item_id': v.itemId,
          'owner_id': supabase.auth.currentUser!.id,
          'valuation_date': v.valuationDate.toIso8601String().substring(0, 10),
          'estimated_value': v.estimatedValue,
          'currency': v.currency,
          'value_type': v.valueType,
          'value_source': v.valueSource,
          'confidence': v.confidence,
          'notes': v.notes,
        })
        .select()
        .single();
    return Valuation.fromJson(Map<String, dynamic>.from(data));
  }

  Future<void> delete(String valuationId) async {
    await supabase
        .from(DbConstants.valuationHistory)
        .delete()
        .eq('id', valuationId);
  }

  // For dashboard: sum of latest valuation per item
  Future<double> totalCollectionValue() async {
    final userId = supabase.auth.currentUser!.id;
    final data = await supabase
        .rpc('current_valuations_sum', params: {'p_owner': userId})
        .maybeSingle();
    return (data as num?)?.toDouble() ?? 0.0;
  }
}
