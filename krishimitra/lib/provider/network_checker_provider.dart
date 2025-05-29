import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkCheckerProvider extends ChangeNotifier {
  InternetStatus _status = InternetStatus.disconnected;

  InternetStatus get status => _status;

  NetworkCheckerProvider() {
    _initNetworkChecker();
  }

  void _initNetworkChecker() {
    InternetConnection().onStatusChange.listen((InternetStatus status) {
      print("Network status updated: $status"); // Log network changes
      _status = status;
      notifyListeners();
    });

    // Perform an initial check to set the status
    _checkInternetStatus();
  }

  void _checkInternetStatus() async {
    final hasConnection = await InternetConnection().hasInternetAccess;
    _status = hasConnection ? InternetStatus.connected : InternetStatus.disconnected;
    print("Initial network status: $_status"); // Log initial network status
    notifyListeners();
  }
}
