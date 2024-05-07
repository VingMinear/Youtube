import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:m_health_app/utils/Language.dart';

import 'colors.dart';
import 'style.dart';

enum Pick {
  time,
  date,
}

class Date {
  static DateTime get now => DateTime.now();
  static String format(DateTime date) => fmDMY.format(date);
  static DateFormat get fmDMY => DateFormat('dd-MM-yyyy', localeDate());
  static DateTime parse(String date) => fmDMY.parse(date);
  static String localeDate() {
    return Language.currentLanguage.languageCode;
  }

  static picker({
    required BuildContext context,
    required Pick pickType,
    required Function(String) onConfirm,
    bool barrierDismissible = false,
    required DateTime initialDate,
  }) async {
    String selectedDueDate = Date.fmDMY.format(initialDate);

    await showCupertinoDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return PopScope(
          canPop: barrierDismissible,
          child: AlertDialog(
            contentPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 220,
                  width: double.infinity,
                  child: CupertinoTheme(
                    data: const CupertinoThemeData(
                      brightness: Brightness.light,
                      textTheme: CupertinoTextThemeData(
                        textStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 17,
                        ),
                        pickerTextStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 17,
                        ),
                        dateTimePickerTextStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.black,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    child: CupertinoDatePicker(
                      initialDateTime: initialDate,
                      mode: pickType == Pick.date
                          ? CupertinoDatePickerMode.date
                          : CupertinoDatePickerMode.time,
                      onDateTimeChanged: (date) {
                        selectedDueDate = Date.fmDMY.format(date);
                      },
                    ),
                  ),
                ),
                Ink(
                  width: double.infinity,
                  color: AppColor.primaryColor,
                  child: InkWell(
                    onTap: () {
                      onConfirm(selectedDueDate);
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'ok'.tr(),
                        style: AppText.txt13.copyWith(
                          color: AppColor.whiteColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
