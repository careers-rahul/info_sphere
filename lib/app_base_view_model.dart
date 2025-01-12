import 'dart:async';

import 'package:info_sphere/utils/imports.dart';

enum NotifierState { loading, loaded, error }

class AppBaseModel with ChangeNotifier {
  NotifierState _state = NotifierState.loaded;
  NotifierState get state => _state;
  set state(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  late final InternetConnectionChecker _connectionChecker;
  late final StreamSubscription<InternetConnectionStatus> _connectionSubscription;

  bool _hasConnection = true;
  bool get hasConnection => _hasConnection;

  AppBaseModel() {
    _connectionChecker = InternetConnectionChecker.instance;
    _initializeConnection();
    _connectionSubscription = _connectionChecker.onStatusChange.listen((status) {
      _updateConnectionStatus(status == InternetConnectionStatus.connected);
    });
  }

  Future<void> _initializeConnection() async {
    _hasConnection = await _connectionChecker.hasConnection;
    notifyListeners();
  }

  void _updateConnectionStatus(bool isConnected) {
    if (_hasConnection != isConnected) {
      _hasConnection = isConnected;
      print("Has Connection ? : $hasConnection");
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _connectionSubscription.cancel();
    super.dispose();
  }
}
