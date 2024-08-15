import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobServices {
  late BannerAd bannerAd;

  Widget startLargeBannerAd() {
    initBannerAd(
      AdSize.largeBanner,
      BannerAdListener(
        onAdLoaded: (ad) {
          debugPrint("Success");
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          debugPrint("Error: $error");
        },
      ),
    );
    return bannerAdWidget();
  }

  Widget startBottomBannerAd() {
    initBannerAd(
      AdSize.fullBanner,
      BannerAdListener(
        onAdLoaded: (ad) {
          debugPrint("Success");
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          debugPrint("Error: $error");
        },
      ),
    );
    return bannerAdWidget();
  }

  initBannerAd(AdSize adSize, BannerAdListener listener) {
    bannerAd = BannerAd(
      size: adSize,
      adUnitId: AdHelper.bannerAdUnitId,
      listener: listener,
      request: AdRequest(),
    );

    bannerAd.load();
  }

  Widget bannerAdWidget() {
    return SizedBox(
      width: bannerAd.size.width.toDouble(),
      height: bannerAd.size.height.toDouble(),
      child: AdWidget(ad: bannerAd),
    );
  }
}

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/9214589741";
    } else if (Platform.isIOS) {
      return "";
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/1033173712";
    } else if (Platform.isIOS) {
      return "";
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/5224354917';
    } else if (Platform.isIOS) {
      return '<YOUR_IOS_REWARDED_AD_UNIT_ID>';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
