import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:m_health_app/Pages/Intro/screens/SplashScreen.dart';
import 'package:m_health_app/Pages/Intro/screens/SplashScreenYT.dart';
import 'package:m_health_app/Pages/dashboard/screens/DashboardScreen.dart';
import 'package:m_health_app/Pages/patient/screens/PatientScreen.dart';
import 'package:m_health_app/provider/ConfigProvider.dart';
import 'package:m_health_app/theme/theme.dart';
import 'package:m_health_app/utils/GlobalContext.dart';
import 'package:m_health_app/utils/Language.dart';
import 'package:m_health_app/utils/LocalStorage.dart';
import 'package:provider/provider.dart';

import 'utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();
  await EasyLocalization.ensureInitialized();
  await rotation(enabled: false);
  runApp(
    MultiProvider(
      providers: ConfigProvider.providers,
      child: EasyLocalization(
        supportedLocales: Language.sppLanguage,
        path: 'assets/translations',
        saveLocale: true,
        startLocale: Language.sppLanguage.first,
        fallbackLocale: Language.sppLanguage.first,
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        GlobalContext.globalCtx = context;
        return GestureDetector(
          onTap: () {
            dismissKeyboard();
          },
          child: MaterialApp(
            theme: lightTheme(),
            themeMode: ThemeMode.light,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            navigatorKey: GlobalContext.navigatorKey,
            home: const SplashScreenYT(),
            builder: (BuildContext context, child) {
              child = botToastBuilder(context, child);
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: txtScale,
                ),
                child: child,
              );
            },
            navigatorObservers: [BotToastNavigatorObserver()],
          ),
        );
      },
    );
  }
}
