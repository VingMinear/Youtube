import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:m_health_app/utils/Extension.dart';
import 'package:m_health_app/utils/GlobalContext.dart';

import 'Alert.dart';
import 'utils.dart';

class NetworkController {
  void onInit() {
    logWarning("checking network controller");
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  static final _singleton = NetworkController._internal();

  NetworkController._internal();

  static NetworkController getInstance() => _singleton;

  void onClose() {
    _connectivitySubscription.cancel();
  }

  final _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
      return _updateConnectionStatus(result);
    } on PlatformException catch (e) {
      logError(e.toString());
    }
  }

  StreamController connectionChangeController = StreamController.broadcast();

  Stream get connectionChange => connectionChangeController.stream;
  bool hasConnection = false;

  Future<bool> checkConnection() async {
    bool previousConnection = hasConnection;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasConnection = true;
      } else {
        hasConnection = false;
      }
    } on SocketException catch (_) {
      hasConnection = false;
    }

    //The connection status changed send out an update to all listeners
    if (previousConnection != hasConnection) {
      connectionChangeController.add(hasConnection);
    }

    return hasConnection;
  }

  bool showDialog = false;
  _updateConnectionStatus(ConnectivityResult result) async {
    var result = await checkConnection();
    if (!result) {
      if (showDialog) GlobalContext.context.pop();
      showDialog = true;
      await alertDialog(
        title: 'connection_lost'.tr(),
        desc: 'pls_check_connection'.tr(),
        txtBtnCancel: 'try_again'.tr(),
        barrierDismissible: false,
        onCancel: () {
          showDialog = false;
          GlobalContext.context.pop();
        },
      );
    } else {
      logWarning("Connecting success");
    }
  }
}
