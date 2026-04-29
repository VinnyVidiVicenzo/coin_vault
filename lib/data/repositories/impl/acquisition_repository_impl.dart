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
}
