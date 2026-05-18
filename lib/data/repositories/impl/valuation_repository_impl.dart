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

  // For dashboard: sum of the most-recent valuation per item.
  // Uses the current_valuations view when available (migration 001),
  // then falls back to in-memory deduplication.
  Future<double> totalCollectionValue() async {
    try {
      final data = await supabase
          .from('current_valuations')
          .select('estimated_value') as List;
      return data.fold<double>(
        0.0,
        (sum, row) => sum + ((row['estimated_value'] as num?)?.toDouble() ?? 0.0),
      );
    } catch (_) {
      // Fallback: view doesn't exist yet — deduplicate in memory
      try {
        final userId = supabase.auth.currentUser?.id;
        if (userId == null) return 0.0;

        final data = await supabase
            .from(DbConstants.valuationHistory)
            .select('item_id, estimated_value, valuation_date')
            .eq('owner_id', userId)
            .order('valuation_date', ascending: false) as List;

        final seen = <String>{};
        double total = 0.0;
        for (final row in data) {
          final itemId = row['item_id'] as String;
          if (seen.add(itemId)) {
            total += (row['estimated_value'] as num?)?.toDouble() ?? 0.0;
          }
        }
        return total;
      } catch (_) {
        return 0.0;
      }
    }
  }
}
