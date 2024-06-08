import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  ///is use for takeing full width of device and devicePixelRatio take ratio for calculations
  /// PlatformDispatcher.instance.views.first.physicalSize.width
  /// PlatformDispatcher.instance.views.first.devicePixelRatio

  BannerAd? bannerAd;

  ///Create/load/show Banner Ad
  void createBannerAd() {
    if (bannerAd != null) {
      bannerAd!.dispose();
    }
    bannerAd = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: Platform.isAndroid
          ? "ca-app-pub-3940256099942544/6300978111"
          : 'ca-app-pub-3940256099942544/2934735716',
      listener: _showBannerAd(),
      request: const AdRequest(),
    )..load();
    print(bannerAd);
  }

  int attemptOfBnanners = 0;

  /// Banner ad show Controll
  BannerAdListener _showBannerAd() {
    return BannerAdListener(
      onAdLoaded: (ad) {
        print("Ad Loaded:${ad.adUnitId}.");
      },
      onAdFailedToLoad: (ad, error) {
        print("Ad failed to load:${ad.adUnitId}.$error");
        if (attemptOfBnanners <= 3) {
          createBannerAd();
          attemptOfBnanners++;
        } else {
          ad.dispose();
        }
      },
    );
  }

  NativeAd? nativeAd;
  bool _nativeAdIsLoaded = false;

  // TODO: replace this test ad unit with your own ad unit.
  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/2247696110'
      : 'ca-app-pub-3940256099942544/3986624511';

  /// Loads a native ad.
  void createNativeAd() {
    try {
      nativeAd = NativeAd(
        adUnitId: _adUnitId,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            debugPrint('$NativeAd loaded.');

            _nativeAdIsLoaded = true;
          },
          onAdFailedToLoad: (ad, error) {
            // Dispose the ad here to free resources.
            debugPrint('$NativeAd failed to load: $error');
            ad.dispose();
          },
        ),
        request: const AdRequest(),
        nativeTemplateStyle:
            NativeTemplateStyle(templateType: TemplateType.small),
        // Styling
      )..load();
    } catch (e) {
      log('', name: 'native ad error', error: e.toString());
    }
  }
}
