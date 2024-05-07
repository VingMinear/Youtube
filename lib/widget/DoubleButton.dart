import 'package:flutter/material.dart';
import 'package:m_health_app/utils/Extension.dart';
import 'package:m_health_app/utils/colors.dart';
import 'package:m_health_app/utils/style.dart';
import 'package:m_health_app/widget/CustomButton.dart';

class DoubleButton extends StatelessWidget {
  const DoubleButton({
    super.key,
    this.onConfirm,
    this.space,
    this.txtBtnCfn,
    this.txtBtnCancel,
    this.onCancel,
    this.btnCfnColor,
    this.btnCancelColor,
    this.btnCfnBorder,
    this.btnCancelBorder,
  });
  final void Function()? onConfirm;
  final double? space;
  final String? txtBtnCfn;
  final String? txtBtnCancel;
  final Color? btnCfnColor, btnCancelColor;
  final Color? btnCfnBorder, btnCancelBorder;
  final void Function()? onCancel;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            backgroundColor: btnCancelColor ?? Colors.transparent,
            textStyle: AppText.txt14.copyWith(
              color: AppColor.errorColor,
            ),
            borderColor: btnCancelBorder ?? AppColor.errorColor,
            title: txtBtnCancel ?? 'cancel',
            onPress: onCancel ??
                () {
                  context.pop();
                },
          ),
        ),
        SizedBox(width: space ?? 20),
        Expanded(
          child: CustomButton(
            title: txtBtnCfn ?? 'cf',
            textStyle: AppText.txt14.copyWith(
              color: AppColor.whiteColor,
            ),
            borderColor: btnCfnColor ?? btnCfnBorder,
            backgroundColor: btnCfnColor,
            onPress: onConfirm ?? () {},
          ),
        ),
      ],
    );
  }
}
