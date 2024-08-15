import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:triviapro/model_view/utility/admob_manager.dart';
import 'package:triviapro/model_view/utility/constants.dart';
import 'package:triviapro/model_view/utility/screen_size_util.dart';
import 'package:triviapro/model_view/utility/text_font.dart';

class FailedPage extends StatefulWidget {
  final Function(bool) callBack;
  final String correctAnswer;

  const FailedPage({super.key, required this.callBack, required this.correctAnswer});

  @override
  State<FailedPage> createState() => _FailedPageState();
}

class _FailedPageState extends State<FailedPage> {
  RewardedAd? _rewardedAd;
  bool error = false;
  bool ready = false;
  int getReadyCount = 5;

  Future<void> loadRewardedAd() async {
    await Future.delayed(const Duration(milliseconds: 50));
    await RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdShowedFullScreenContent: (ad) {
                if (!error) {
                  setState(() {
                    error = false;
                  });
                }
              },
              onAdImpression: (ad) {},
              onAdFailedToShowFullScreenContent: (ad, err) {
                ad.dispose();
                setState(() {
                  error = true;
                });
              },
              onAdDismissedFullScreenContent: (ad) {
                ad.dispose();
              },
              onAdClicked: (ad) {});
          _rewardedAd = ad;
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('RewardedAd failed to load: $error');
        },
      ),
    );
  }

  @override
  void initState() {
    loadRewardedAd();
    adsReady();
    super.initState();
  }

  adsReady() async {
    for (int i = 1; i <= 5; i++) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        getReadyCount--;
      });
    }
    setState(() {
      ready = true;
    });
  }

  @override
  void dispose() {
    if (_rewardedAd != null) {
      _rewardedAd!.dispose();
      _rewardedAd == null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: TriviaColor().blackColor.withOpacity(.7),
      ),
      child: Center(
        child: Container(
          width: ScreenSizeUtil().getCalculateWith(context, 350),
          decoration: BoxDecoration(
            color: TriviaColor().primaryColor,
            borderRadius: BorderRadius.circular(27),
          ),
          padding: EdgeInsets.only(
            left: ScreenSizeUtil().getCalculateWith(context, 10),
            right: ScreenSizeUtil().getCalculateWith(context, 10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: TriviaColor().whiteColor,
                  borderRadius: BorderRadius.circular(360),
                  gradient: LinearGradient(
                    colors: [
                      TriviaColor().whiteColor,
                      TriviaColor().whiteColor,
                    ],
                    begin: const Alignment(-1, 1),
                    end: const Alignment(1, -1),
                  ),
                ),
                margin: EdgeInsets.only(
                  top: ScreenSizeUtil().getCalculateHeight(context, 20),
                ),
                width: ScreenSizeUtil().getCalculateWith(context, 100),
                height: ScreenSizeUtil().getCalculateHeight(context, 100),
                child: Lottie.asset('assets/lottie/wrong.json'),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: ScreenSizeUtil().getCalculateHeight(context, 20),
                ),
                child: Text(
                  "Oops, Incorrect",
                  style: TextFont().montserratAlternates(
                    24,
                    TriviaColor().whiteColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: ScreenSizeUtil().getCalculateHeight(context, 10),
                  bottom: ScreenSizeUtil().getCalculateHeight(context, 10),
                ),
                padding: EdgeInsets.only(
                  top: ScreenSizeUtil().getCalculateHeight(context, 5),
                  bottom: ScreenSizeUtil().getCalculateHeight(context, 5),
                  left: ScreenSizeUtil().getCalculateWith(context, 5),
                  right: ScreenSizeUtil().getCalculateWith(context, 5),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(27),
                  color: TriviaColor().redColor,
                ),
                child: Center(
                  child: Text(
                    "The correct answer is: ${widget.correctAnswer}",
                    style: TextFont().montserratAlternates(
                      16,
                      TriviaColor().whiteColor,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                  ),
                ),
              ),
              error
                  ? Text(
                      "Oops! Ads couldn't load. Please check your internet connection and try again.",
                      style: TextFont().montserratAlternates(14, TriviaColor().whiteColor, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    )
                  : Container(),
              Container(
                margin: EdgeInsets.only(
                  top: ScreenSizeUtil().getCalculateHeight(context, 10),
                  bottom: ScreenSizeUtil().getCalculateHeight(context, 20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: ready
                          ? () {
                              if (_rewardedAd != null) {
                                debugPrint("showed");
                                _rewardedAd!.show(
                                  onUserEarnedReward: (view, item) {
                                    widget.callBack(true);
                                  },
                                );
                              }
                              else{

                                debugPrint("Loading");
                              }
                              setState(() {});
                            }
                          : () {
                        debugPrint("Not ready");
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: ready ? TriviaColor().greenColor : TriviaColor().greenColor.withOpacity(.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: EdgeInsets.only(
                          bottom: ScreenSizeUtil().getCalculateHeight(context, 10),
                        ),
                        padding: EdgeInsets.only(
                          left: ScreenSizeUtil().getCalculateWith(context, 20),
                          right: ScreenSizeUtil().getCalculateWith(context, 20),
                          top: ScreenSizeUtil().getCalculateHeight(context, 10),
                          bottom: ScreenSizeUtil().getCalculateHeight(context, 10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.play_arrow,
                              color: TriviaColor().whiteColor,
                            ),
                            Text(
                              ready ? "Earn Extra Chance" : "Ads Loading, $getReadyCount seconds",
                              style: TextFont().montserratAlternates(16, TriviaColor().whiteColor, fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.callBack(false);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: TriviaColor().redColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.only(
                          left: ScreenSizeUtil().getCalculateWith(context, 20),
                          right: ScreenSizeUtil().getCalculateWith(context, 20),
                          top: ScreenSizeUtil().getCalculateHeight(context, 10),
                          bottom: ScreenSizeUtil().getCalculateHeight(context, 10),
                        ),
                        child: Text(
                          "No Thanks",
                          style: TextFont().montserratAlternates(16, TriviaColor().whiteColor, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
