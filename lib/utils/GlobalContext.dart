import 'package:flutter/material.dart';

class GlobalContext {
  /// Note* this ctx use for route screen
  static BuildContext get context =>
      navigatorKey.currentState?.context ?? globalCtx;

  static late BuildContext globalCtx;
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
