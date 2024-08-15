import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triviapro/model_view/utility/constants.dart';
import 'package:triviapro/model_view/utility/screen_size_util.dart';
import 'package:triviapro/model_view/utility/text_font.dart';
import 'package:triviapro/model_view/utility/useful_methods.dart';
import 'package:triviapro/view/atom/trivia_button.dart';
import 'package:triviapro/view/pages/option_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceOut,
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: TriviaColor().primaryColor,
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  Constants().backgroundMainImage,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: SlideTransition(
                  position: _animation,
                  child: Container(
                    padding: EdgeInsets.only(
                      top: ScreenSizeUtil().getCalculateHeight(context, 10),
                      bottom: ScreenSizeUtil().getCalculateHeight(context, 10),
                      left: ScreenSizeUtil().getCalculateWith(context, 20),
                      right: ScreenSizeUtil().getCalculateWith(context, 20),
                    ),
                    decoration: BoxDecoration(
                      color: TriviaColor().whiteColor.withOpacity(.3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Trivia Pro",
                      style: TextFont().montserratAlternates(50, TriviaColor().whiteColor, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0, 1),
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: ScreenSizeUtil().getCalculateHeight(context, 100),
                  ),
                  child: TriviaButton(
                    title: "Play Now",
                    bgColor: TriviaColor().greenColor,
                    shadowColor: TriviaColor().shadowGreenColor,
                    fontSize: 20,
                    onTap: () {
                      UsefulMethods().navigatorPushMethod(context, const OptionPage());
                    },
                    width: 200,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
