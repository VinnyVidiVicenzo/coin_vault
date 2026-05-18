import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/connectivity_service.dart';
import '../../data/local/app_database.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final connectivityServiceProvider =
    Provider<ConnectivityService>((_) => ConnectivityService());

final isOnlineProvider = FutureProvider<bool>((ref) =>
    ref.watch(connectivityServiceProvider).isOnline);

final onlineStreamProvider = StreamProvider<bool>((ref) =>
    ref.watch(connectivityServiceProvider).onlineStream);
