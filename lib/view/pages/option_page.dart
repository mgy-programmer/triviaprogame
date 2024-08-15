import 'package:flutter/material.dart';
import 'package:triviapro/model/series_info_model.dart';
import 'package:triviapro/model_view/utility/constants.dart';
import 'package:triviapro/model_view/utility/screen_size_util.dart';
import 'package:triviapro/model_view/utility/text_font.dart';
import 'package:triviapro/model_view/utility/useful_methods.dart';
import 'package:triviapro/view/pages/question_page.dart';

class OptionPage extends StatefulWidget {
  const OptionPage({super.key});

  @override
  State<OptionPage> createState() => _OptionPageState();
}

class _OptionPageState extends State<OptionPage> {
  List<SeriesInfoModel> series = [
    SeriesInfoModel(Constants().familyGuyImage, Constants().familyGuyData, "Family Guy"),
    SeriesInfoModel(Constants().rickAndMortyImage, Constants().rickAndMortyData, "Rick And Morty"),
    SeriesInfoModel(Constants().theSimpsonsImage, Constants().theSimpsonsData, "The Simpsons"),
    SeriesInfoModel(Constants().theBigBangTheoryImage, Constants().theBigBangTheoryData, "The Big Bang Theory"),
    SeriesInfoModel(Constants().friendsImage, Constants().friendsData, "Friends"),
    SeriesInfoModel(Constants().theWalkingDeadImage, Constants().theWalkingDeadData, "The Walking Dead"),
    SeriesInfoModel(Constants().breakingBadImage, Constants().breakingBadData, "Breaking Bad"),
    SeriesInfoModel(Constants().prisonBreakImage, Constants().prisonBreakData, "Prison Break"),
    SeriesInfoModel(Constants().gameOfThronesImage, Constants().gameOfThronesData, "Game of Thrones"),
    SeriesInfoModel(Constants().fastAndFuriousImage, Constants().fastAndFuriousData, "Fast & Furious"),
    SeriesInfoModel(Constants().harryPotterImage, Constants().harryPotterData, "Harry Potter"),
    SeriesInfoModel(Constants().hobbitImage, Constants().hobbitData, "Hobbit"),
    SeriesInfoModel(Constants().lordOfTheRingsImage, Constants().lordOfTheRingsData, "The Lord of the Rings"),
    SeriesInfoModel(Constants().piratesOfTheCaribbeanImage, Constants().piratesOfTheCaribbeanData, "Pirates of the Caribbean"),
    SeriesInfoModel(Constants().theGodfatherImage, Constants().theGodfatherData, "The Godfather"),
    SeriesInfoModel(Constants().theHungerGameImage, Constants().theHungerGameData, "The Hunger Games"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TriviaColor().primaryColor,
      appBar: AppBar(
        backgroundColor: TriviaColor().primaryColor,
        foregroundColor: TriviaColor().whiteColor,
        title: Center(
          child: Text(
            "Pick Your TV Series",
            style: TextFont().montserratAlternates(
              20,
              TriviaColor().whiteColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(
          left: ScreenSizeUtil().getCalculateWith(context, 10),
          right: ScreenSizeUtil().getCalculateWith(context, 10),
        ),
        padding: EdgeInsets.only(
          top: ScreenSizeUtil().getCalculateHeight(context, 10),
          bottom: ScreenSizeUtil().getCalculateHeight(context, 10),
        ),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: series.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                UsefulMethods().navigatorPushMethod(
                  context,
                  QuestionPage(
                    seriesModel: series[index],
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  series[index].seriesImagePath,
                  fit: BoxFit.fill,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
