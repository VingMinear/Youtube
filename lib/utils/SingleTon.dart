// for store data temporary

import 'package:m_health_app/constant/Enum.dart';

class GlobalClass {
  static final GlobalClass _singleton = GlobalClass._internal();

  factory GlobalClass() {
    return _singleton;
  }

  GlobalClass._internal();
  String deviceToken = '';
  String imeiCode = '';
  UserType userType = UserType.patient;
}
