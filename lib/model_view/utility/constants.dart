import 'dart:ui';

class Constants{
  //JsonData

  final String breakingBadData = "assets/questions/breakingbad.json";
  final String familyGuyData = "assets/questions/familyguy.json";
  final String friendsData = "assets/questions/friends.json";
  final String gameOfThronesData = "assets/questions/gameofthrones.json";
  final String prisonBreakData = "assets/questions/prisonbreak.json";
  final String rickAndMortyData = "assets/questions/rickandmorty.json";
  final String theBigBangTheoryData = "assets/questions/thebigbangtheory.json";
  final String theSimpsonsData = "assets/questions/thesimpsons.json";
  final String theWalkingDeadData = "assets/questions/thewalkingdead.json";

  //ImagePath
  final String breakingBadImage = "assets/images/breaking_bad.jpg";
  final String familyGuyImage = "assets/images/family_guy.jpg";
  final String friendsImage = "assets/images/friends.jpg";
  final String gameOfThronesImage = "assets/images/gameofthrones.jpg";
  final String prisonBreakImage = "assets/images/prison_break.jpeg";
  final String rickAndMortyImage = "assets/images/rick_and_morty.jpg";
  final String theBigBangTheoryImage = "assets/images/thebigbangtheory.jpg";
  final String theSimpsonsImage = "assets/images/the_simpsons.jpeg";
  final String theWalkingDeadImage = "assets/images/the_walking_dead.jpg";
  final String backgroundImage = "assets/images/background.svg";
  final String backgroundMainImage = "assets/images/background_main.svg";
  final String splash = "assets/images/splash.svg";

  //Movies
  final String fastAndFuriousData = "assets/questions/movies/fastandfurious.json";
  final String harryPotterData = "assets/questions/movies/harrypotter.json";
  final String hobbitData = "assets/questions/movies/hobbit.json";
  final String lordOfTheRingsData = "assets/questions/movies/lordoftherings.json";
  final String piratesOfTheCaribbeanData = "assets/questions/movies/piratesofthecaribbean.json";
  final String theGodfatherData = "assets/questions/movies/thegodfather.json";
  final String theHungerGameData = "assets/questions/movies/thehungergame.json";

  //Movies
  final String fastAndFuriousImage = "assets/images/movies/fastandfurious.png";
  final String harryPotterImage = "assets/images/movies/harrypotter.png";
  final String hobbitImage = "assets/images/movies/hobbit.png";
  final String lordOfTheRingsImage = "assets/images/movies/lordoftherings.png";
  final String piratesOfTheCaribbeanImage = "assets/images/movies/piratesofthecaribbean.png";
  final String theGodfatherImage = "assets/images/movies/thegodfather.png";
  final String theHungerGameImage = "assets/images/movies/thehungergames.png";
}

class TriviaColor{
  final Color primaryColor = const Color(0XFFA76AE4);
  Color textColor = const Color(0XFF0C6277);
  Color blackColor = const Color(0XFF000000);
  Color metallicBlackColor = const Color(0XFF2C2C2B);
  Color hinTextColor = const Color(0XFF9E9E9E);
  Color whiteColor = const Color(0XFFFFFFFF);
  Color greyColor = const Color(0XFFEEEEEE);
  Color floatingBgColor = const Color(0XFFFAFAFA);
  Color redColor = const Color(0XFFEF5350);
  Color photoAddColor = const Color(0XFF535353);
  Color lightFontColor = const Color(0XFF757575);
  Color otherColor = const Color(0XFFBDBDBD);


  Color greenColor = const Color(0XFF67EB00);
  Color shadowGreenColor = const Color(0XFF4dc308);
  Color orangeColor = const Color(0XFFFFDB0A);
  Color shadowOrangeColor = const Color(0XFFffb213);
  Color purpleColor = const Color(0XFF9858fe);
  Color appBarColor = const Color(0XFFa97efe);
  Color strokePurpleColor = const Color(0XFF3A00D0);
  Color switchActiveColor = const Color(0XFFE530B6);
  Color lightRedColor = const Color(0XFFFF265A);
  Color darkRedColor = const Color(0XFFff275a);
  Color lightPurpleColor = const Color(0XFFFF79EA);
  Color darkPurpleColor = const Color(0XFFE530B6);
  Color lightBlueColor = const Color(0XFF4ddafe);
  Color darkBackgroundColor = const Color(0XFF4E19A5);
  Color winnerBorder = const Color(0XFFFFE605);

  List<String> images = [
    Constants().breakingBadImage,
    Constants().familyGuyImage,
    Constants().friendsImage,
    Constants().gameOfThronesImage,
    Constants().prisonBreakImage,
    Constants().rickAndMortyImage,
    Constants().theBigBangTheoryImage,
    Constants().theSimpsonsImage,
    Constants().theWalkingDeadImage,
  ];

}

class AudioConstants{
  String clapPath = "assets/audio/clap.mp3";
  String failPath = "assets/audio/fail.mp3";
}