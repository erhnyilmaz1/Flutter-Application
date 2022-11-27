// ignore_for_file: avoid_print, prefer_const_declarations, unused_field

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobProcess {
  //static final String appIDLive = "ca-app-pub-9254632509429915~6875199539";
  static final String appIDTest = "ca-app-pub-9254632509429915~6875199539";

  //static final String advertisementLive = "ca-app-pub-9254632509429915/8679235793";
  static final String advertisementTest = "ca-app-pub-9254632509429915/8679235793";

  static bool _isBannerReady = false;

  static admobInitialize() {
    MobileAds.instance.initialize();
  }

  static BannerAd buildeBannerAd() {
    return BannerAd(
        size: AdSize.mediumRectangle,
        adUnitId: appIDTest,
        listener: BannerAdListener(
          onAdLoaded: (_) {
            _isBannerReady = true;
          },
          onAdFailedToLoad: (ad, error) {
            print('Failed To Load A Banner Ad ${error.message}');
            _isBannerReady = false;
            ad.dispose();
          },
        ),
        request: const AdRequest());
      //..load();
  }
}
