import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity _connectivity = Connectivity();

  NetworkInfoImpl();

  @override
  Future<bool> get isConnected => _connectivity
      .checkConnectivity()
      .then((value) => value != ConnectivityResult.none);
}
