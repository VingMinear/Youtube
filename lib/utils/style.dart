import 'package:flutter/material.dart';
import 'package:m_health_app/utils/GlobalContext.dart';
import 'package:m_health_app/utils/utils.dart';

class AppText {
  static TextTheme get _txtTheme => Theme.of(GlobalContext.globalCtx).textTheme;
  static ThemeData get theme => Theme.of(GlobalContext.globalCtx);
  static TextStyle get txt36 => _txtTheme.headlineLarge!; // font size (36),
  static TextStyle get txt25 => _txtTheme.headlineMedium!; // font size (25),
  static TextStyle get txt22 => _txtTheme.headlineSmall!; // font size (22),
  static TextStyle get txt17 => _txtTheme.displayMedium!; // font size (17),
  static TextStyle get txt20 => _txtTheme.titleLarge!; // font size (20),
  static TextStyle get txt18 => _txtTheme.titleMedium!; // font size (18),
  static TextStyle get txt11 => _txtTheme.titleSmall!; // font size (11),
  static TextStyle get txt15 => _txtTheme.bodyMedium!; // font size (15),
  static TextStyle get txt14 => _txtTheme.bodySmall!; // font size (14),
  static TextStyle get txt13 => _txtTheme.labelSmall!; // font size (13),
  static TextStyle get txt16 => _txtTheme.bodyLarge!; // font size (16),
  static TextStyle get txt12 => _txtTheme.displaySmall!; // font size (12),
  static TextStyle get txt21 => _txtTheme.displayLarge!; // font size (21),
  static TextStyle errorStyle(
      {Color? color,
      FontWeight weight = FontWeight.w400,
      double fontSized = 13}) {
    return TextStyle(
      fontSize: responsiveFont(fontSized),
      fontWeight: weight,
      color: color ?? Colors.red,
    );
  }

  static TextStyle hintStyle(
      {Color? color,
      FontWeight weight = FontWeight.w400,
      double fontSized = 15}) {
    return TextStyle(
      fontSize: fontSized,
      fontWeight: weight,
      color: color ?? Colors.grey,
    );
  }

  static TextStyle appBarTextStyle(
      {Color? color,
      FontWeight weight = FontWeight.w400,
      double fontSized = 17}) {
    return TextStyle(
      fontSize: responsiveFont(fontSized),
      fontWeight: weight,
      color: color ?? Colors.black,
    );
  }

  static TextStyle normalText(
      {Color? color,
      FontWeight weight = FontWeight.w400,
      double fontSized = 15}) {
    return TextStyle(
      fontSize: responsiveFont(fontSized),
      fontWeight: weight,
      color: color ?? Colors.black,
    );
  }
}
