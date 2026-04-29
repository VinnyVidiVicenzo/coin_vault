import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/models/valuation.dart';
import '../../../data/repositories/impl/valuation_repository_impl.dart';

part 'valuation_provider.g.dart';

@riverpod
ValuationRepository valuationRepository(ValuationRepositoryRef ref) =>
    ValuationRepository();

@riverpod
Future<List<Valuation>> valuationHistory(
  ValuationHistoryRef ref,
  String itemId,
) =>
    ref.read(valuationRepositoryProvider).fetchForItem(itemId);

@riverpod
Future<Valuation?> latestValuation(
  LatestValuationRef ref,
  String itemId,
) =>
    ref.read(valuationRepositoryProvider).fetchLatest(itemId);
