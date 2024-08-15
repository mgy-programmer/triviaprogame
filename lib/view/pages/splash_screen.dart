import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triviapro/model_view/utility/constants.dart';
import 'package:triviapro/model_view/utility/screen_size_util.dart';
import 'package:triviapro/model_view/utility/text_font.dart';
import 'package:triviapro/model_view/utility/useful_methods.dart';
import 'package:triviapro/view/pages/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _progressValue = 0;

  @override
  void initState() {
    startProgressBar();
    super.initState();
  }

  startProgressBar() async{
    for(int i = 1; i<=10; i++){
      await Future.delayed(const Duration(milliseconds: 125));
      setState(() {
        _progressValue++;
        debugPrint(_progressValue.toString());
      });
    }

    if (context.mounted) {
      UsefulMethods().navigatorPushAndNeverComeBackMethod(context, const HomePage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TriviaColor().primaryColor,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              Constants().splash,
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.fitWidth,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: ScreenSizeUtil().getCalculateWith(context, 200),
              margin: EdgeInsets.only(
                bottom: ScreenSizeUtil().getCalculateHeight(context, 20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  LinearProgressIndicator(
                    value: (_progressValue * 10),
                    minHeight: ScreenSizeUtil().getCalculateHeight(context, 20),
                    backgroundColor: TriviaColor().whiteColor,
                    valueColor: AlwaysStoppedAnimation<Color>(TriviaColor().lightBlueColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'Progress: ${(_progressValue * 10)}%',
                    style: TextFont().montserratAlternates(
                      20,
                      TriviaColor().whiteColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
