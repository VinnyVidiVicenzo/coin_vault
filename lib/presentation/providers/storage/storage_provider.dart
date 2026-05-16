import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/storage_location.dart';
import '../../../data/repositories/impl/storage_repository_impl.dart';

final storageRepositoryProvider =
    Provider<StorageRepository>((_) => StorageRepository());

final storageLocationsProvider = FutureProvider<List<StorageLocation>>(
  (ref) => ref.read(storageRepositoryProvider).fetchLocations(),
);

final itemStorageProvider =
    FutureProvider.family<ItemStorage?, String>(
  (ref, itemId) =>
      ref.read(storageRepositoryProvider).fetchForItem(itemId),
);

final allItemStorageProvider = FutureProvider<List<ItemStorage>>(
  (ref) => ref.read(storageRepositoryProvider).fetchAll(),
);
