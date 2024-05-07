import 'package:flutter/material.dart';

import 'package:m_health_app/utils/colors.dart';
import 'package:m_health_app/widget/CustomAppBar.dart';

class SomethingWentWrong extends StatelessWidget {
  const SomethingWentWrong({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: Container(
        color: AppColor.whiteColor,
        child: const Center(
          child: Text('invalid_json'),
        ),
      ),
    );
  }
}
