import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:triviapro/model/series_info_model.dart';
import 'package:triviapro/model_view/provider/question_provider.dart';
import 'package:triviapro/model_view/utility/admob_manager.dart';
import 'package:triviapro/model_view/utility/constants.dart';
import 'package:triviapro/model_view/utility/screen_size_util.dart';
import 'package:triviapro/model_view/utility/text_font.dart';
import 'package:triviapro/view/molecule/option_widget.dart';
import 'package:triviapro/view/template/failed_page.dart';

class QuestionPage extends StatefulWidget {
  final SeriesInfoModel seriesModel;

  const QuestionPage({super.key, required this.seriesModel});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  bool? correctionStatus;
  int? selectedIndex;
  final AudioPlayer _player = AudioPlayer();
  Duration? duration;
  String selectedMusic = "";

  BannerAd? _bannerAd;
  bool _isAdLoaded = false;

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          print('BannerAd failed to load: $error');
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  void initState() {
    _loadBannerAd();
    Provider.of<QuestionProvider>(context, listen: false).fillQuestion(widget.seriesModel.seriesDataPath);
    super.initState();
  }

  play(bool correct) async {
    selectedMusic = correct ? AudioConstants().clapPath : AudioConstants().failPath;
    duration = await _player.setAsset(selectedMusic);
    _player.play();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionProvider>(
      builder: (context, questionProvider, widgets) {
        return Scaffold(
          backgroundColor: TriviaColor().primaryColor,
          appBar: AppBar(
            backgroundColor: TriviaColor().primaryColor,
            foregroundColor: TriviaColor().whiteColor,
            title: Center(
              child: Text(
                widget.seriesModel.seriesName,
                style: TextFont().montserratAlternates(
                  20,
                  TriviaColor().whiteColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            actions: [
              Container(
                margin: EdgeInsets.only(
                  right: ScreenSizeUtil().getCalculateWith(context, 20),
                ),
                child: Text(
                  "${questionProvider.selectedQuestion + 1}/${questionProvider.question.length}",
                  style: TextFont().montserratAlternates(
                    21,
                    TriviaColor().whiteColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            ],
          ),
          body: questionProvider.question.isNotEmpty
              ? Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: ScreenSizeUtil().getCalculateWith(context, 300),
                            height: ScreenSizeUtil().getCalculateHeight(context, 200),
                            padding: EdgeInsets.only(
                              top: ScreenSizeUtil().getCalculateHeight(context, 10),
                              bottom: ScreenSizeUtil().getCalculateHeight(context, 10),
                              left: ScreenSizeUtil().getCalculateWith(context, 10),
                              right: ScreenSizeUtil().getCalculateWith(context, 10),
                            ),
                            margin: EdgeInsets.only(
                              bottom: ScreenSizeUtil().getCalculateHeight(context, 50),
                            ),
                            decoration: BoxDecoration(
                              color: TriviaColor().whiteColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Image.asset(widget.seriesModel.seriesImagePath),
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: ScreenSizeUtil().getCalculateWith(context, 300),
                              maxWidth: ScreenSizeUtil().getCalculateWith(context, 300),
                              minHeight: ScreenSizeUtil().getCalculateHeight(context, 50),
                              maxHeight: ScreenSizeUtil().getCalculateHeight(context, 500),
                            ),
                            child: Container(
                              padding: EdgeInsets.only(
                                top: ScreenSizeUtil().getCalculateHeight(context, 10),
                                bottom: ScreenSizeUtil().getCalculateHeight(context, 10),
                                left: ScreenSizeUtil().getCalculateWith(context, 10),
                                right: ScreenSizeUtil().getCalculateWith(context, 10),
                              ),
                              margin: EdgeInsets.only(
                                bottom: ScreenSizeUtil().getCalculateHeight(context, 50),
                              ),
                              decoration: BoxDecoration(
                                color: TriviaColor().whiteColor,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                questionProvider.question[questionProvider.selectedQuestion].question,
                                style: TextFont().montserratAlternates(
                                  18,
                                  TriviaColor().blackColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            width: ScreenSizeUtil().getCalculateWith(context, 380),
                            height: ScreenSizeUtil().getCalculateHeight(context, 300),
                            margin: EdgeInsets.only(
                              left: ScreenSizeUtil().getCalculateWith(context, 10),
                              right: ScreenSizeUtil().getCalculateWith(context, 10),
                            ),
                            child: ListView.builder(
                              itemCount: questionProvider.question[questionProvider.selectedQuestion].option.length,
                              itemBuilder: (BuildContext context, int index) {
                                return OptionWidget(
                                  text: questionProvider.question[questionProvider.selectedQuestion].option[index],
                                  onTap: correctionStatus == null
                                      ? () async {
                                          selectedIndex = index;
                                          setState(
                                            () {
                                              correctionStatus = questionProvider.question[questionProvider.selectedQuestion].option[index] ==
                                                  questionProvider.question[questionProvider.selectedQuestion].correctOption;
                                            },
                                          );
                                          if (correctionStatus!) {
                                            play(true);
                                            await Future.delayed(const Duration(seconds: 2));
                                            correctionStatus = null;
                                            if (context.mounted) {
                                              Provider.of<QuestionProvider>(context, listen: false).nextQuestion();
                                            }
                                            setState(() {});
                                          } else {
                                            play(false);
                                            showDialog(
                                              context: context,
                                              builder: (context) => FailedPage(
                                                callBack: (value) {
                                                  if (value) {
                                                    correctionStatus = null;
                                                    selectedIndex = null;
                                                    if (context.mounted) {
                                                      Provider.of<QuestionProvider>(context, listen: false).nextQuestion();
                                                    }
                                                    Navigator.pop(context);
                                                  } else {
                                                    correctionStatus = false;

                                                    Navigator.pop(context);
                                                  }
                                                  setState(() {});
                                                },
                                                correctAnswer: questionProvider.question[questionProvider.selectedQuestion].correctOption,
                                              ),
                                            );
                                          }
                                        }
                                      : () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => FailedPage(
                                              callBack: (value) {
                                                if (value) {
                                                  correctionStatus = null;
                                                  selectedIndex = null;
                                                  if (context.mounted) {
                                                    Provider.of<QuestionProvider>(context, listen: false).nextQuestion();
                                                  }
                                                  Navigator.pop(context);
                                                } else {
                                                  correctionStatus = false;
                                                  Navigator.pop(context);
                                                }
                                                setState(() {});
                                              },
                                              correctAnswer: questionProvider.question[questionProvider.selectedQuestion].correctOption,
                                            ),
                                          );
                                        },
                                  isCorrect: selectedIndex == null || index != selectedIndex ? null : correctionStatus,
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    _isAdLoaded
                        ? Align(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              width: _bannerAd!.size.width.toDouble(),
                              height: _bannerAd!.size.height.toDouble(),
                              child: AdWidget(ad: _bannerAd!),
                            ),
                          )
                        : Container(),
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }
}
