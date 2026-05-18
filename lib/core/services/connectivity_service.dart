import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final _connectivity = Connectivity();

  Future<bool> get isOnline async {
    final results = await _connectivity.checkConnectivity();
    return !results.contains(ConnectivityResult.none);
  }

  Stream<bool> get onlineStream => _connectivity.onConnectivityChanged
      .map((results) => !results.contains(ConnectivityResult.none));
}
