import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:m_health_app/utils/utils.dart';

/// add Padding Property to widget
extension WidgetPaddingX on Widget {
  Widget paddingAll(double padding) =>
      Padding(padding: EdgeInsets.all(padding), child: this);

  Widget paddingSymmetric({double horizontal = 0.0, double vertical = 0.0}) =>
      Padding(
          padding:
              EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
          child: this);

  Widget paddingOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) =>
      Padding(
          padding: EdgeInsets.only(
              top: top, left: left, right: right, bottom: bottom),
          child: this);

  Widget get paddingZero => Padding(padding: EdgeInsets.zero, child: this);
}

/// Add margin property to widget
extension WidgetMarginX on Widget {
  Widget marginAll(double margin) =>
      Container(margin: EdgeInsets.all(margin), child: this);

  Widget marginSymmetric({double horizontal = 0.0, double vertical = 0.0}) =>
      Container(
          margin:
              EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
          child: this);

  Widget marginOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) =>
      Container(
          margin: EdgeInsets.only(
              top: top, left: left, right: right, bottom: bottom),
          child: this);

  Widget get marginZero => Container(margin: EdgeInsets.zero, child: this);
}

extension TextRequired on Text {
  Widget txtRequired({double space = 5}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          data ?? '',
          style: style,
        ),
        SizedBox(width: space),
        Text(
          " *",
          style: style ??
              const TextStyle(
                fontSize: 15,
                color: Colors.red,
              ),
        ),
      ],
    );
  }
}

Route _animationNav(Widget page) {
  if (!kIsWeb) {
    return Platform.isAndroid
        ? PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => page,
            transitionDuration: const Duration(milliseconds: 300),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          )
        : CupertinoPageRoute(builder: (context) => page);
  } else {
    return MaterialPageRoute(builder: (context) => page);
  }
}

extension Utility on BuildContext {
  void nextFocus() {
    var resul = FocusScope.of(this).nextFocus();
    if (resul) {
      logSuccess('can next');
    } else {
      logSuccess('cann"t next');
    }
  }

  Future push(Widget page) async {
    return await Navigator.push(this, _animationNav(page));
  }

  Future pushClear(Widget page) async {
    return Navigator.pushAndRemoveUntil(
      this,
      _animationNav(page),
      (route) => false,
    );
  }

  void pop() {
    if (Navigator.canPop(this)) {
      Navigator.pop(this);
    }
  }
}

extension Format on double {
  String get currency {
    final result = NumberFormat("#,##0.00", "en_US");
    return result.format(this);
  }
}

extension ConvertSize on int {
  double get mb {
    var kb = this / 1024.0;
    return (kb / 1024.0);
  }
}

class LowerCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toLowerCase(), // Convert to lowercase
      selection: newValue.selection,
    );
  }
}

class CustomInputPrice extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text;
    final oldText = oldValue.text;
    if (newText.isNotEmpty) {
      if (oldText.startsWith('0') &&
          newText.length == 2 &&
          newText.endsWith('0')) {
        if (oldText.length > 1 && RegExp('^0+\$').hasMatch(newText)) {
          return newValue;
        }
        return oldValue;
      } else if (oldText.startsWith('0') &&
          newText.length == 2 &&
          oldText.length == 1 &&
          !newText.endsWith('.')) {
        var text = newText.substring(newText.length - 1);
        final int selectionIndexFromTheRight =
            newValue.text.length - newValue.selection.end;
        return newValue.copyWith(
          text: text,
          selection: TextSelection.collapsed(
            offset: text.length - selectionIndexFromTheRight,
          ),
        );
      }
    }
    return newValue;
  }
}

class NoSplash extends InteractiveInkFeature {
  NoSplash({
    required super.controller,
    required super.referenceBox,
  }) : super(
          color: Colors.transparent,
        );

  @override
  void paintFeature(Canvas canvas, Matrix4 transform) {}
}
