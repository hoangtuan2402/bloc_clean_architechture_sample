import 'package:connectivity_plus/connectivity_plus.dart';

abstract class ConnectivityAbs {
  Future<ConnectivityResult> get connection;
}

class ConnectivityImpl implements ConnectivityAbs {
  final Connectivity connectivity;

  ConnectivityImpl(this.connectivity);

  @override
  Future<ConnectivityResult> get connection => connectivity.checkConnectivity();
}
