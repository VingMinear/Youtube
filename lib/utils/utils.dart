import 'dart:developer' as developer;
import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:m_health_app/utils/GlobalContext.dart';
import 'package:m_health_app/utils/LocalStorage.dart';
import 'package:m_health_app/utils/NotificationHandler.dart';
import 'package:m_health_app/utils/helper/BaseHelper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vibration/vibration.dart';

import 'DeviceInfo.dart';
import 'Extension.dart';

// Blue text
void logInfo(Object msg) {
  developer.log('\x1B[37m📝 $msg\x1B[37m');
}

// Green text
void logSuccess(Object msg) {
  developer.log('\x1B[32m🎉✅ $msg\x1B[0m 🎉✅ ');
}

// Yellow text
void logWarning(Object msg) {
  developer.log('\x1B[33m⚠️ $msg\x1B[0m');
}

// Red text
void logError(Object msg) {
  developer.log('\x1B[31m ---------------⛔️ error ⛔️--------------- \x1B[31m');
  developer.log('\x1B[31m\t $msg\x1B[31m');
  developer.log('\x1B[31m x-----------------end----------------x \x1B[31m');
}

bool isIPad() {
  final data = MediaQueryData.fromView(
    WidgetsBinding.instance.platformDispatcher.views.single,
  );
  return data.size.shortestSide > 550 ? true : false;
}

double responsiveFont(double designFont) {
  return ScreenUtil().setSp(isIPad() ? designFont * 0.8 : designFont * 1);
}

double responsiveImage(double size) {
  var resize = 0.95;
  if (Device.isSmallScreen) {
  } else if (Device.isNormalScreen) {
    resize = 0.9;
  } else if (Device.isMediumScreen) {
    resize = 0.6;
  } else {
    resize = 0.5;
  }

  return ScreenUtil().setSp(size * resize);
}

double resize(double size) {
  var resize = 1.0;
  if (Device.isXtraSmallScreen) {
    resize = 0.8;
  } else if (Device.isSmallScreen) {
    resize = 0.95;
  } else if (Device.isNormalScreen) {
    resize = 1;
  } else if (Device.isMediumScreen) {
    resize = 1.2;
  } else {
    resize = 1.3;
  }
  return size * resize;
}

Duration animateTabBar() => const Duration(milliseconds: 250);
TextScaler get txtScale {
  var scale = 1.2;
  if (Device.isXtraSmallScreen) {
    scale = 0.85;
  } else if (Device.isSmallScreen) {
    scale = 0.95;
  } else if (Device.isNormalScreen) {
    scale = 1;
  } else if (Device.isMediumScreen) {
    scale = 1.1;
  } else {
    scale = 1.2;
  }
  return TextScaler.linear(scale);
}

double heightGrid() {
  var locale = LocalStorage.getStringData(key: 'locale');
  if (Device.isXtraSmallScreen) {
    return locale == 'km' ? 300 : 280;
  } else if (Device.isSmallScreen) {
    return locale == 'km' ? 320 : 315;
  } else if (Device.isNormalScreen) {
    return locale == 'km' ? 330 : 325;
  } else if (Device.isMediumScreen) {
    return locale == 'km' ? 370 : 360;
  } else {
    return locale == 'km' ? 390 : 380;
  }
}

double responsiveSize(double size, {double adjust = 0}) {
  var resize = 0.95 - adjust;
  if (Device.isSmallScreen) {
    resize = 0.95 - adjust;
  } else if (Device.isNormalScreen) {
    resize = 0.9 - adjust;
  } else if (Device.isMediumScreen) {
    resize = 0.8 - adjust;
  } else {
    resize = 0.7 - adjust;
  }

  return ScreenUtil().setSp(size * resize);
}

Future onLogout() async {
  // loadingDialog();
  await NotificationHandler.logOut();
  await FlutterAppBadger.removeBadge();
}

vibration({int? repeat, int? duration}) async {
  if (await Vibration.hasVibrator() ?? false) {
    Vibration.vibrate(duration: duration ?? 200, repeat: repeat ?? -1);
  }
}

/// Use on future.onError to catch error via api status such as 500 or defualt...
Future checkCatchResponseError(ErrorModel error,
    {bool barrierColor = true, void Function()? onCancel}) async {
  if (error.statusCode == null ||
      error.statusCode == 500 ||
      error.statusCode == 502) {
    // await alertDialog(
    //   barrierColor: barrierColor,
    //   title: 'Ops',
    //   desc: 'invalid_server',
    //   barrierDismissible: false,
    //   txtBtnCancel: 'try_again',
    //   onCancel: onCancel ??
    //       () {
    //         pop();
    //       },
    // );
  }

  logError("$error");
}

Future<bool> checkConnectivityState() async {
  final connectivityResult = await (Connectivity().checkConnectivity());
  bool isConnect = false;
  if (connectivityResult == ConnectivityResult.wifi) {
    logWarning('Connected to a Wi-Fi network');
    isConnect = true;
  } else if (connectivityResult == ConnectivityResult.mobile) {
    logWarning('Connected to a mobile network');
    isConnect = true;
  } else {
    isConnect = false;
    logWarning('Not connected to any network');
  }
  return isConnect;
}

rotation({required enabled}) async {
  if (enabled) {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  } else {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }
}

bool checkPagination({
  required bool isRefreshing,
  required bool isLoading,
  required double maxScrollExtent,
  required double scrollPosition,
}) {
  if (scrollPosition == maxScrollExtent && !isRefreshing && !isLoading) {
    return true;
  } else {
    return false;
  }
}

bool checkFetchValueEmpty(List value, List list) {
  if (value.isEmpty && list.isEmpty) {
    return true;
  } else {
    return false;
  }
}

bool checkIsRefreshing(ScrollUpdateNotification notification) {
  if (notification.metrics.pixels < 0) {
    return true;
  } else {
    return false;
  }
}

bool isStrongPassword(String password) {
  return password.length >= 8 &&
      RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)').hasMatch(password);
}

List<TextInputFormatter> inputFormatPrice() {
  return [
    TextInputFormatter.withFunction(
      (oldValue, newValue) => newValue.copyWith(
        text: newValue.text.replaceAll(',', '.'),
      ),
    ),
    FilteringTextInputFormatter.allow(
      RegExp(r'^\d+\.?\d{0,2}'),
    ),
    CustomInputPrice(),
  ];
}

TextInputFormatter inputFormatLimitRange(int maxLength) {
  return LengthLimitingTextInputFormatter(maxLength);
}

TextInputFormatter inputFormatDitgit() {
  return FilteringTextInputFormatter.digitsOnly;
}

TextInputFormatter inputFormatDenyZeroFirst() {
  return FilteringTextInputFormatter.deny(
    RegExp(r'^0+'), //users can't type 0 at 1st position
  );
}

TextInputFormatter inputFormatLowerCase() {
  return LowerCaseTextFormatter();
}

TextInputFormatter inputFormatTextOnly() {
  return FilteringTextInputFormatter.allow(
    RegExp(r'[a-zA-Z0-9\s]'),
  );
}

TextInputFormatter inputAllDenyEmoji() {
  return FilteringTextInputFormatter.deny(RegExp(
      '(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'));
}

double appHeight({double percent = 1}) {
  return MediaQuery.of(GlobalContext.globalCtx).size.height * percent;
}

double appWidth({double percent = 1}) {
  return MediaQuery.of(GlobalContext.globalCtx).size.width * percent;
}

String formatPhoneNumber({required String phone}) {
  try {
    String newPhone = phone.substring(0, 3);
    String unexpectedPhone = phone.substring(0, 5);
    if (unexpectedPhone == "+8550") {
      return "855${phone.substring(5)}";
    }
    if (newPhone == "855") {
      return phone;
    } else if (newPhone[0] == "0") {
      return phone[0].replaceAll('0', '855') + phone.substring(1);
    } else if (!newPhone.startsWith('0')) {
      return '885$phone';
    } else if (newPhone == "+85") {
      return phone.substring(1);
    }
  } catch (e) {
    logError(e);
  }
  return phone;
}

// https:0991234;
// https:t.me/
// 0991234

String cutPrefixNumber({required String phone}) {
  String newPhone = phone.substring(0, 3);
  if (newPhone == "855") {
    return "0${phone.substring(3)}";
  } else if (newPhone == "+855") {
    return "0${phone.substring(4)}";
  }
  return "0$phone";
}

dismissKeyboard() {
  final FocusScopeNode currentFocus = FocusScope.of(GlobalContext.globalCtx);

  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus!.unfocus();
  }
}

onInitState(FrameCallback callback) {
  WidgetsBinding.instance.addPostFrameCallback(callback);
}

//----------prefix---------------
// url > https:
// email to > mailto:
// call > tel:
// message > sms:
enum PrefixLauncher { url, email, call, message, none }

Future<bool> launchLink({
  required String url,
  LaunchMode mode = LaunchMode.externalApplication,
  required PrefixLauncher prefix,
  WebViewConfiguration? webViewConfiguration,
}) async {
  try {
    var baseUrl = '';
    switch (prefix) {
      case PrefixLauncher.url:
        baseUrl = 'https://$url';
        break;
      case PrefixLauncher.email:
        baseUrl = 'mailto:$url';
        break;
      case PrefixLauncher.call:
        baseUrl = 'tel:$url';
        break;
      case PrefixLauncher.message:
        baseUrl = 'sms:$url';
        break;
      default:
        baseUrl = url;
        break;
    }
    if (!await launchUrl(
      Uri.parse(baseUrl),
      mode: mode,
    )) {
      // showToast('something_wrong');
      logWarning('Could not launch : $url');
      return false;
    } else {
      return true;
    }
  } on Exception catch (e) {
    logWarning('Erorr: $e');
    return false;
  }
}

DateTime? currentBackPressTime;
Future<bool> onWillPopExit() {
  DateTime now = DateTime.now();
  if (currentBackPressTime == null ||
      now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
    currentBackPressTime = now;
    // showToast('click_again_exit');
    return Future.value(false);
  }
  return Future.value(true);
}
