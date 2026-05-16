import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/acquisition.dart';
import '../../../data/repositories/impl/acquisition_repository_impl.dart';

final acquisitionRepositoryProvider =
    Provider<AcquisitionRepository>((_) => AcquisitionRepository());

final itemAcquisitionProvider =
    FutureProvider.family<Acquisition?, String>(
  (ref, itemId) =>
      ref.read(acquisitionRepositoryProvider).fetchForItem(itemId),
);
