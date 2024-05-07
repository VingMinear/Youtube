import 'dart:async';
import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:m_health_app/utils/Extension.dart';
import 'package:m_health_app/utils/utils.dart';
import 'package:m_health_app/widget/WebViewScreen.dart';

class SplashScreenYT extends StatefulWidget {
  const SplashScreenYT({super.key});

  @override
  State<SplashScreenYT> createState() => _SplashScreenYTState();
}

class _SplashScreenYTState extends State<SplashScreenYT> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 200,
          child: ElasticIn(
            child: FadeOut(
              delay: Duration(seconds: 3),
              animate: true,
              onFinish: (direction) {
                context.pushClear(WebViewScreen());
              },
              child: LottieBuilder.asset(
                "assets/splash.json",
                onLoaded: (p0) {},
              ),
            ),
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0).copyWith(bottom: 30),
        child: FadeInUp(
          from: 20,
          child: Text(
            "Powered by Ving Minear",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
