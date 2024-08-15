import 'package:flutter/material.dart';
import 'package:triviapro/model_view/utility/constants.dart';
import 'package:triviapro/model_view/utility/screen_size_util.dart';
import 'package:triviapro/model_view/utility/text_font.dart';

class OptionWidget extends StatelessWidget {
  final Function() onTap;
  final String text;
  final bool? isCorrect;

  const OptionWidget({super.key, required this.text, required this.onTap, this.isCorrect});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(
          top: ScreenSizeUtil().getCalculateHeight(context, 10),
          bottom: ScreenSizeUtil().getCalculateHeight(context, 10),
          left: ScreenSizeUtil().getCalculateWith(context, 10),
          right: ScreenSizeUtil().getCalculateWith(context, 10),
        ),
        decoration: BoxDecoration(
          color: isCorrect == null
              ? TriviaColor().whiteColor
              : isCorrect!
                  ? TriviaColor().greenColor
                  : TriviaColor().redColor,
          borderRadius: BorderRadius.circular(30),
        ),
        margin: EdgeInsets.only(
          bottom: ScreenSizeUtil().getCalculateHeight(context, 10),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            text,
            style: TextFont().montserratAlternates(
              16,
              isCorrect == null ? TriviaColor().blackColor : TriviaColor().whiteColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
