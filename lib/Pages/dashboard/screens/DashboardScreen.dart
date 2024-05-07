import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:m_health_app/Pages/Test/TestingScreen.dart';
import 'package:m_health_app/Pages/dashboard/components/FilterTemplate.dart';

import 'package:m_health_app/Pages/patient/screens/PatientScreen.dart';
import 'package:m_health_app/Pages/videos/screens/VideoScreen.dart';
import 'package:m_health_app/constant/Enum.dart';
import 'package:m_health_app/provider/HomeProvider/HomeProvider.dart';
import 'package:m_health_app/utils/Alert.dart';
import 'package:m_health_app/utils/Extension.dart';
import 'package:m_health_app/utils/Language.dart';
import 'package:m_health_app/utils/SingleTon.dart';
import 'package:m_health_app/utils/utils.dart';
import 'package:m_health_app/widget/CustomButton.dart';
import 'package:m_health_app/widget/CustomDropdownFormField.dart';
import 'package:m_health_app/widget/CustomTextField.dart';
import 'package:m_health_app/widget/WebViewScreen.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  TextEditingController searchCon = TextEditingController();
  var isSearch = false;
  var switching = Language.currentLanguage.languageCode == 'en' ? true : false;

  @override
  Widget build(BuildContext context) {
    logInfo("Rebuilding");
    // rotation(enabled: false);
    return Scaffold(
      body: FilterTemplate(
        onChangeFilter: (param) {
          logSuccess("Filter ${param}");
        },
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Consumer<HomeProvider>(builder: (context, pro, widget) {
                        return Column(
                          children: [
                            Text(
                              'You have pushed the button this many times: ${pro.counter}',
                            ),
                            const SizedBox(height: 20),
                            CustomButton(
                              onPress: () {
                                alertSnackbar(
                                  message:
                                      'Please input Correct PMRS ID | Username',
                                  snackbar: SnackBarStatus.success,
                                );
                                pro.incrementCounter();
                              },
                            )
                          ],
                        );
                      }),
                      const SizedBox(height: 10),
                      CustomTextField(
                        label: const Text("M-Health ID").txtRequired(),
                      ),
                      const SizedBox(height: 10),
                      CustomDropdownFormField(
                        onChanged: (page) {
                          var p = (page ?? '');
                          switch (p) {
                            case '1':
                              context.push(const PatientScreen());
                              break;
                            case '2':
                              context.push(const ToastContext());
                              break;

                            default:
                              context.push(const WebViewScreen());
                              break;
                          }
                        },
                        backgroundColor: Colors.transparent,
                        radius: 5,
                        label: const Text("Gender").txtRequired(),
                        list: const [
                          '1',
                          '2',
                          '3',
                        ],
                      ),
                      Text('log_in'.tr()),
                      StatefulBuilder(
                        builder: (context, rebuild) {
                          return Row(
                            children: [
                              CupertinoSwitch(
                                value: switching,
                                onChanged: (value) {
                                  switching = value;
                                  Language.switchLanguage(
                                    switching ? Lang.en : Lang.km,
                                  );
                                  if (GlobalClass().userType == UserType.pe) {
                                    GlobalClass().userType = UserType.patient;
                                  } else {
                                    GlobalClass().userType = UserType.pe;
                                  }

                                  setState(() {});
                                },
                              ),
                              const SizedBox(width: 20),
                              Text(Language.currentLanguage.languageCode),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () async {
          await rotation(enabled: true);
          context.push(const VideoScreen(
            linkVideo:
                "https://cdn.pixabay.com/video/2024/03/18/204605-925184337_large.mp4",
          ));
        },
        child: const Icon(
          Icons.apple,
          color: Colors.white,
        ),
      ),
    );
  }
}
