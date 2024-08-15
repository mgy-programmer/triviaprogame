import 'package:flutter/cupertino.dart';

class UsefulMethods{
  navigatorPushMethod(BuildContext context, Widget page) {
    return Navigator.of(context).push(CupertinoPageRoute(builder: (context) => page));
  }

  navigatorPushAndNeverComeBackMethod(BuildContext context, Widget page) {
    return Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) => page), (Route<dynamic> route) => false);
  }

  navigatorPushAndThenMethod(BuildContext context, Widget page, Function() function) {
    return Navigator.of(context).push(CupertinoPageRoute(builder: (context) => page)).then(
          (value) {
        function();
      },
    );
  }

}