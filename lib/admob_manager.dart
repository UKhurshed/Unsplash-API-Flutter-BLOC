// import 'dart:io';
//
// class AdManager {
//
//   static String get appId {
//     if (Platform.isAndroid) {
//       return "<YOUR_ANDROID_ADMOB_APP_ID>";
//     } else if (Platform.isIOS) {
//       return "<YOUR_IOS_ADMOB_APP_ID>";
//     } else {
//       throw new UnsupportedError("Unsupported platform");
//     }
//   }
//
//   static String get bannerAdUnitId {
//     if (Platform.isAndroid) {
//       return "<YOUR_ANDROID_BANNER_AD_UNIT_ID";
//     } else if (Platform.isIOS) {
//       return "<YOUR_IOS_BANNER_AD_UNIT_ID>";
//     } else {
//       throw new UnsupportedError("Unsupported platform");
//     }
//   }
//
//   static String get interstitialAdUnitId {
//     if (Platform.isAndroid) {
//       return "<YOUR_ANDROID_INTERSTITIAL_AD_UNIT_ID>";
//     } else if (Platform.isIOS) {
//       return "<YOUR_IOS_INTERSTITIAL_AD_UNIT_ID>";
//     } else {
//       throw new UnsupportedError("Unsupported platform");
//     }
//   }
//
//   static String get rewardedAdUnitId {
//     if (Platform.isAndroid) {
//       return "<YOUR_ANDROID_REWARDED_AD_UNIT_ID>";
//     } else if (Platform.isIOS) {
//       return "<YOUR_IOS_REWARDED_AD_UNIT_ID>";
//     } else {
//       throw new UnsupportedError("Unsupported platform");
//     }
//   }
// }

import 'dart:io';

class AdManager {

  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-6246157961341960~8828179846";
    }
    // else if (Platform.isIOS) {
    //   return "ca-app-pub-3940256099942544~2594085930";
    // }
    else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/6300978111";
    }
    // else if (Platform.isIOS) {
    //   return "ca-app-pub-3940256099942544/4339318960";
    //  ca-app-pub-6246157961341960/4100088035
    // }
    else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}