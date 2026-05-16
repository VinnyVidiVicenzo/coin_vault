import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/repositories/impl/acquisition_repository_impl.dart';
import '../../../data/repositories/impl/valuation_repository_impl.dart';
import '../../../data/repositories/impl/ebay_repository_impl.dart';

class DashboardStats {
  final double totalCost;
  final double currentValue;
  final int activeListings;
  final double totalListedValue;

  const DashboardStats({
    required this.totalCost,
    required this.currentValue,
    required this.activeListings,
    required this.totalListedValue,
  });

  double get gain => currentValue - totalCost;
  double get gainPct => totalCost > 0 ? gain / totalCost * 100 : 0.0;
  bool get hasFinancialData => totalCost > 0 || currentValue > 0;
}

final dashboardStatsProvider = FutureProvider<DashboardStats>((ref) async {
  final acqRepo = AcquisitionRepository();
  final valRepo = ValuationRepository();
  final ebayRepo = EbayRepository();

  // Fire all three requests in parallel
  final costFuture = acqRepo.totalCollectionCost();
  final valueFuture = valRepo.totalCollectionValue();
  final ebayFuture = ebayRepo.fetchActive();

  final totalCost = await costFuture;
  final currentValue = await valueFuture;
  final activeListings = await ebayFuture;

  final totalListedValue = activeListings.fold<double>(
    0.0,
    (sum, l) => sum + (l.listPrice ?? 0.0),
  );

  return DashboardStats(
    totalCost: totalCost,
    currentValue: currentValue,
    activeListings: activeListings.length,
    totalListedValue: totalListedValue,
  );
});
