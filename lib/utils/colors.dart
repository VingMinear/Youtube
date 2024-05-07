import 'package:flutter/material.dart';
import 'package:m_health_app/constant/Enum.dart';
import 'package:m_health_app/utils/GlobalContext.dart';
import 'package:m_health_app/utils/SingleTon.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class AppColor {
  static ThemeData get _appContxt {
    return Theme.of(GlobalContext.globalCtx);
  }

  static Color get primaryColor {
    var userType = GlobalClass().userType;
    return userType == UserType.patient ? primaryColorPatient : primaryColorPE;
  }

  static Color primaryColorPE = HexColor('C11919');
  static Color primaryColorPatient = HexColor('222566');
  static Color get whiteColor {
    return _appContxt.colorScheme.onSecondary;
  }

  static ColorScheme get colorScheme {
    return _appContxt.colorScheme;
  }

  static Color get scaffoldBackgroundColor {
    return _appContxt.scaffoldBackgroundColor;
  }

  static Color get greyColor {
    return _appContxt.colorScheme.onBackground;
  }

  static Color get black {
    return _appContxt.colorScheme.onPrimaryContainer;
  }

  static Color get darkGrey {
    return _appContxt.colorScheme.onSecondaryContainer;
  }

  static Color get blue {
    return _appContxt.colorScheme.secondary;
  }

  static Color get grey {
    return _appContxt.colorScheme.background;
  }

  static Color bgScaffold = const Color(0xffF5F5F5);
  static Color bgLoading = Colors.black.withOpacity(0.2);
  static Color darkBtn = const Color(0xff666666);
  static Color txtColor = Colors.black;
  static Color greyBtn = const Color(0xffB0B0B0);
  static Color disableColor = const Color(0xffE4E3E6);
  static Color warningColor = const Color(0xffff9f07);
  static Color cardDarkColor = const Color(0xff666666);
  static Color txtDarkColor = const Color(0xff666666);
  static Color lightBlueColor = const Color(0xffC4DBEC);
  static Color mainColor = const Color(0xff0E75BB);
  static Color successColor = const Color(0xff38C976);
  static Color errorColor = const Color(0xffFE5050);
  static Color cardColor = const Color(0xffF5F5F5);
  static Color shadowColor = const Color(0xff000000).withOpacity(0.08);
  static Color logoColor = const Color(0xff6B8E45);
  static Color txtFieldColor = Colors.grey[200]!;
  static LinearGradient bgGradient = const LinearGradient(
    colors: [
      Color(0xff75B845),
      Color(0xff64893C),
    ],
  );
  static var boxShadow = [
    BoxShadow(
      blurRadius: 10,
      color: AppColor.shadowColor,
      spreadRadius: -1,
    ),
  ];
  static var cardShadow = [
    BoxShadow(
      color: AppColor.shadowColor,
      offset: const Offset(2, 2),
      blurRadius: 0.5,
    )
  ];
}
