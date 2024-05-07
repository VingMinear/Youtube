import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_health_app/utils/DeviceInfo.dart';
import 'package:m_health_app/utils/Extension.dart';
import 'package:m_health_app/utils/GlobalContext.dart';
import 'package:m_health_app/widget/CustomButton.dart';
import 'package:m_health_app/widget/LoadingWidget.dart';
import 'package:m_health_app/widget/ModifyRow.dart';

import '../widget/SnackbarWidget.dart';
import 'colors.dart';
import 'style.dart';

alertDialogConfirmation({
  String? title,
  String? desc,
  String? txtBtnCfn,
  String? txtBtnCancel,
  void Function()? onConfirm,
  bool barrierDismissible = true,
}) async {
  await showDialog(
    context: GlobalContext.context,
    builder: (context) {
      return PopScope(
        canPop: barrierDismissible,
        child: Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title ?? "",
                  style: AppText.txt16,
                ),
                const SizedBox(height: 20),
                Text(
                  desc ?? '',
                  textAlign: TextAlign.center,
                  style: AppText.txt15,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        backgroundColor: Colors.white,
                        textStyle: AppText.txt13.copyWith(color: Colors.red),
                        title: txtBtnCancel ?? 'cancel'.tr(),
                        borderColor: Colors.red,
                        onPress: () {
                          context.pop();
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: CustomButton(
                        title: txtBtnCfn ?? 'cf'.tr(),
                        onPress: onConfirm,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

enum AlertType {
  confirmation,
  normal,
}

alertDialogIOSConfirmation({
  String? title,
  String? desc,
  String? txtBtnCfn,
  String? txtBtnCancel,
  void Function()? onConfirm,
  void Function()? onCancel,
  AlertType alertType = AlertType.confirmation,
  bool barrierDismissible = true,
}) async {
  await showCupertinoDialog(
    context: GlobalContext.context,
    barrierDismissible: barrierDismissible,
    builder: (context) {
      return DefaultTextStyle(
        style: AppText.txt14.copyWith(),
        child: CupertinoAlertDialog(
          content: Container(
            margin: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Text(
                  desc ?? '',
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          title: Text(
            title ?? 'ifm'.tr(),
            style: AppText.txt15.copyWith(),
          ),
          actions: alertType == AlertType.confirmation
              ? [
                  CupertinoButton(
                    onPressed: onCancel ??
                        () {
                          context.pop();
                        },
                    padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                    child: Text(
                      txtBtnCancel ?? 'no'.tr(),
                      style: AppText.txt14.copyWith(),
                    ),
                  ),
                  CupertinoButton(
                    padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                    onPressed: onConfirm ?? () {},
                    child: Text(
                      txtBtnCfn ?? 'yes'.tr(),
                      style: AppText.txt14.copyWith(),
                    ),
                  ),
                ]
              : [
                  CupertinoButton(
                    padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                    onPressed: onConfirm ?? () {},
                    child: Text(
                      txtBtnCfn ?? 'close'.tr(),
                      style: AppText.txt14.copyWith(),
                    ),
                  ),
                ],
        ),
      );
    },
  );
}

alertDialog({
  String? title,
  String? desc,
  String? txtBtnCancel,
  void Function()? onCancel,
  bool barrierDismissible = true,
  bool barrierColor = true,
}) async {
  await showDialog(
    context: GlobalContext.context,
    barrierColor: barrierColor ? AppColor.bgLoading : Colors.transparent,
    barrierDismissible: barrierDismissible,
    builder: (context) {
      return PopScope(
        canPop: barrierDismissible,
        child: Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title ?? "",
                  style: AppText.txt16,
                ),
                const SizedBox(height: 20),
                Text(
                  desc ?? '',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        title: txtBtnCancel ?? 'cancel'.tr(),
                        onPress: onCancel ??
                            () {
                              context.pop();
                            },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}

customalertDialogConfirmation({
  String? title,
  String? desc,
  String? txtBtnCfn,
  String? txtBtnCancel,
  Widget? child,
  void Function()? onConfirm,
  EdgeInsetsGeometry? paddingBody,
  EdgeInsetsGeometry? paddingButton,
  bool barrierDismissible = true,
}) async {
  await showDialog(
    context: GlobalContext.context,
    builder: (context) {
      return Material(
        color: Colors.transparent,
        child: PopScope(
          canPop: barrierDismissible,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            insetPadding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0, top: 10, right: 5),
                    child: ModifyRow(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      left: Text(
                        title ?? '',
                        style: AppText.txt16.copyWith(),
                      ),
                      right: IconButton(
                        onPressed: () {
                          context.pop();
                        },
                        icon: const Icon(
                          Icons.clear_rounded,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: paddingBody ??
                        const EdgeInsets.all(20.0).copyWith(top: 10),
                    child: Column(
                      children: [
                        child ?? const SizedBox.shrink(),
                        Padding(
                          padding: paddingButton ??
                              const EdgeInsets.all(20.0).copyWith(top: 0),
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                  backgroundColor: Colors.transparent,
                                  textStyle: AppText.txt13.copyWith(
                                    color: Colors.red,
                                  ),
                                  borderColor: Colors.red,
                                  title: txtBtnCancel ?? 'cancel'.tr(),
                                  onPress: () {
                                    context.pop();
                                  },
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: CustomButton(
                                  title: txtBtnCfn ?? 'cf'.tr(),
                                  onPress: onConfirm ?? () {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

enum SnackBarStatus {
  success,
  error,
}

alertSnackbar({
  required String message,
  SnackBarStatus snackbar = SnackBarStatus.error,
}) {
  // var content = ;
  BotToast.showCustomNotification(
    toastBuilder: (cancelFunc) {
      return SnackbarWidget(
        message: message,
        snackbar: snackbar,
        cancel: cancelFunc,
      );
    },
    duration: const Duration(milliseconds: 3000),
  );
}

showToast(
  String message, {
  ToastGravity? gravity,
  Color? txtColor,
  Color? bgColor,
  int? sec,
}) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: gravity ?? ToastGravity.BOTTOM,
    backgroundColor: bgColor ?? Colors.black.withOpacity(0.7),
    textColor: txtColor ?? Colors.white,
    fontSize: 13.0,
    timeInSecForIosWeb: sec ?? 1,
  );
  // Future.delayed(
  //   Duration(milliseconds: milliseconds ?? 1000),
  //   () {
  //     Fluttertoast.cancel();
  //   },
  // );
}

Future loadingDialog({bool dismiss = true}) async {
  await showDialog(
    context: GlobalContext.context,
    barrierColor: AppColor.bgLoading,
    barrierDismissible: false,
    builder: (context) {
      return PopScope(
        canPop: !dismiss,
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Container(
              width: Device.isSmallScreen ? 45 : 50,
              height: Device.isSmallScreen ? 45 : 50,
              padding: const EdgeInsets.all(10),
              child: const LoadingWidget(),
            ),
          ),
        ),
      );
    },
  );
}
