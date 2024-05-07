import 'package:flutter/cupertino.dart';

import 'package:m_health_app/utils/GlobalContext.dart';

class Device {
  static final _screen =
      MediaQueryData.fromView(View.of(GlobalContext.globalCtx));
  static bool get isXtraSmallScreen {
    return _screen.size.width < 330;
  }

  static bool get isSmallScreen {
    return _screen.size.width < 380;
  }

  static bool get isNormalScreen {
    return _screen.size.height < 800 ||
        _screen.size.width >= 380 && _screen.size.width < 550;
  }

  static bool get isMediumScreen {
    return _screen.size.width >= 550 && _screen.size.width < 800;
  }

  static bool get isLargeScreen {
    return _screen.size.width >= 1000;
  }
}
