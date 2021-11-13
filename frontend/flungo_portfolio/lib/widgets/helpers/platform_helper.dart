import 'package:flutter/foundation.dart';

class PlatformHelper {
  static bool get isWeb {
    return kIsWeb;
  }

  static bool get isMobile {
    return defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;
  }

  static bool get isWindows {
    return defaultTargetPlatform == TargetPlatform.windows && !kIsWeb;
  }

  static bool get isMacOS {
    return defaultTargetPlatform == TargetPlatform.macOS && !kIsWeb;
  }

  static bool get isLinux {
    return defaultTargetPlatform == TargetPlatform.linux && !kIsWeb;
  }

  static bool get isAndroid {
    return defaultTargetPlatform == TargetPlatform.android && !kIsWeb;
  }

  static bool get isIOS {
    return defaultTargetPlatform == TargetPlatform.iOS && !kIsWeb;
  }
}
