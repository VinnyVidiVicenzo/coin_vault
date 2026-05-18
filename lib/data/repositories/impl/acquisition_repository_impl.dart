import '../../models/acquisition.dart';
import '../../remote/supabase/supabase_client.dart';
import '../../../core/constants/db_constants.dart';

class AcquisitionRepository {
  Future<Acquisition?> fetchForItem(String itemId) async {
    final data = await supabase
        .from(DbConstants.acquisition)
        .select()
        .eq('item_id', itemId)
        .maybeSingle();
    if (data == null) return null;
    return Acquisition.fromJson(Map<String, dynamic>.from(data));
  }

  Future<Acquisition> upsert(Acquisition acq) async {
    final payload = {
      'item_id': acq.itemId,
      'owner_id': supabase.auth.currentUser!.id,
      'purchase_date': acq.purchaseDate?.toIso8601String().substring(0, 10),
      'source_type': acq.sourceType,
      'seller_name': acq.sellerName,
      'seller_contact': acq.sellerContact,
      'lot_number': acq.lotNumber,
      'purchase_price': acq.purchasePrice,
      'buyers_premium': acq.buyersPremium,
      'shipping_cost': acq.shippingCost,
      'tax_paid': acq.taxPaid,
      'other_fees': acq.otherFees,
      'currency': acq.currency,
      'payment_method': acq.paymentMethod,
      'cost_basis_type': acq.costBasisType,
      'notes': acq.notes,
    };

    final data = await supabase
        .from(DbConstants.acquisition)
        .upsert(payload, onConflict: 'item_id')
        .select()
        .single();
    return Acquisition.fromJson(Map<String, dynamic>.from(data));
  }

  Future<void> delete(String itemId) async {
    await supabase
        .from(DbConstants.acquisition)
        .delete()
        .eq('item_id', itemId);
  }

  Future<double> totalCollectionCost() async {
    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) return 0.0;

      final data = await supabase
          .from(DbConstants.acquisition)
          .select('purchase_price, buyers_premium, shipping_cost, tax_paid, other_fees, total_cost')
          .eq('owner_id', userId) as List;

      return data.fold<double>(0.0, (sum, row) {
        // Use generated total_cost column if present, otherwise compute from parts
        final stored = (row['total_cost'] as num?)?.toDouble();
        if (stored != null) return sum + stored;
        return sum +
            ((row['purchase_price'] as num?)?.toDouble() ?? 0.0) +
            ((row['buyers_premium'] as num?)?.toDouble() ?? 0.0) +
            ((row['shipping_cost'] as num?)?.toDouble() ?? 0.0) +
            ((row['tax_paid'] as num?)?.toDouble() ?? 0.0) +
            ((row['other_fees'] as num?)?.toDouble() ?? 0.0);
      });
    } catch (_) {
      return 0.0;
    }
  }
}
