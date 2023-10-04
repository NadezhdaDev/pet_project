import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class RewardedAds {
  RewardedAd? _rewardedAd;

  // TODO: replace this test ad unit with your own ad unit.
  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/5224354917'
      : 'ca-app-pub-3940256099942544/1712485313';

  void showAd() {
    _rewardedAd?.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
      // Reward the user for watching an ad.
    });
  }

  /// Loads a rewarded ad.
  Future<void> loadAd(
      {required Function() errorFunction,
      required Function() rewardedFunction,
      required Function() dismissFunction}) {
    return RewardedAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
              // Called when the ad showed the full screen content.
              onAdShowedFullScreenContent: (ad) {},
              // Called when an impression occurs on the ad.
              onAdImpression: (ad) {},
              // Called when the ad failed to show full screen content.
              onAdFailedToShowFullScreenContent: (ad, err) {
            // Dispose the ad here to free resources.
            errorFunction();
            ad.dispose();
          },
              // Called when the ad dismissed full screen content.
              onAdDismissedFullScreenContent: (ad) {
            dismissFunction();
            // Dispose the ad here to free resources.
            ad.dispose();
          },
              // Called when a click is recorded for an ad.
              onAdClicked: (ad) {
            rewardedFunction();
          });

          // Keep a reference to the ad so you can show it later.

          _rewardedAd = ad;
          showAd();
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (LoadAdError error) {
          errorFunction();
          if (kDebugMode) {
            print('RewardedAd failed to load: $error');
          }
        },
      ),
    );
  }
}
