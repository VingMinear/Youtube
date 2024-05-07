import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:m_health_app/utils/colors.dart';
import 'package:m_health_app/widget/ResponsiveText.dart';

import '../utils/Alert.dart';

class SnackbarWidget extends StatelessWidget {
  const SnackbarWidget({
    super.key,
    required this.message,
    required this.snackbar,
    required this.cancel,
  });
  final String message;
  final Function() cancel;
  final SnackBarStatus snackbar;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: snackbar == SnackBarStatus.success
            ? AppColor.successColor
            : AppColor.errorColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.2),
            offset: const Offset(1, 1),
            blurRadius: 5,
          )
        ],
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              cancel();
            },
            child: SvgPicture.asset(
              snackbar == SnackBarStatus.success
                  ? 'assets/icons/ic_success.svg'
                  : 'assets/icons/ic_error.svg',
            ),
          ),
          const SizedBox(width: 10),
          ResponsiveText(
            text: message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
