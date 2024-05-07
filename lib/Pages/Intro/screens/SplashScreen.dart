import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:m_health_app/Pages/dashboard/screens/DashboardScreen.dart';
import 'package:m_health_app/utils/Extension.dart';
import 'package:m_health_app/utils/NetworkHandler.dart';
import 'package:m_health_app/utils/colors.dart';
import 'package:m_health_app/utils/utils.dart';
import 'package:m_health_app/widget/LogoCompany.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    onInitState((duration) {
      NetworkController.getInstance().onInit();
      Future.delayed(
        const Duration(milliseconds: 1200),
        () {
          context.pushClear(const DashboardScreen());
        },
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Center(
            child: FadeIn(
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/logo.png',
                      scale: resize(3.5),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "NCD Prevention & Management",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColor.mainColor,
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(
                      height: responsiveSize(110),
                      width: double.infinity,
                      // color: Colors.amber,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomSheet: logoCompany(),
    );
  }
}
