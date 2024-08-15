import 'package:flutter/material.dart';
import 'package:triviapro/model_view/utility/constants.dart';
import 'package:triviapro/model_view/utility/screen_size_util.dart';
import 'package:triviapro/model_view/utility/text_font.dart';

class TriviaButton extends StatelessWidget {
  final String title;
  final Color bgColor;
  final Color shadowColor;
  final double fontSize;
  final double height;
  final double width;
  final FontWeight fontWeight;

  final Function() onTap;

  const TriviaButton({
    super.key,
    required this.title,
    required this.bgColor,
    required this.shadowColor,
    required this.fontSize,
    required this.onTap,
    this.height = 42,
    this.width = 150,
    this.fontWeight = FontWeight.w400,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: ScreenSizeUtil().getCalculateHeight(context, height),
        width: ScreenSizeUtil().getCalculateWith(context, width),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: bgColor,
          border: Border.all(color: TriviaColor().whiteColor, width: 3.5),
        ),
        child: Container(
          width: ScreenSizeUtil().getCalculateWith(context, 325),
          height: ScreenSizeUtil().getCalculateHeight(context, 45),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: shadowColor,
                spreadRadius: 4,
                blurRadius: 0,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              title.toUpperCase(),
              style: TextFont().montserratAlternates(fontSize, TriviaColor().whiteColor, fontWeight: fontWeight),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
