import 'package:flutter/material.dart';

import '../globals/colors_globals.dart';

// color pallete for general theme
class ColorPallete {
  // Colors
  static const blackColor = Color.fromRGBO(1, 1, 1, 1); // primary color
  static const greyColor = Color.fromRGBO(26, 39, 45, 1); // secondary color
  static const drawerColor = Color.fromRGBO(18, 18, 18, 1);
  static const whiteColor = Colors.white;
  static var redColor = Colors.red.shade500;
  static var blueColor = Colors.blue.shade300;

  static const Map<int, Color> primaryColor = {
    50: Color.fromRGBO(35, 40, 107, .1),
    100: Color.fromRGBO(35, 40, 107, .2),
    200: Color.fromRGBO(35, 40, 107, .3),
    300: Color.fromRGBO(35, 40, 107, .4),
    400: Color.fromRGBO(35, 40, 107, .5),
    500: Color.fromRGBO(35, 40, 107, .6),
    600: Color.fromRGBO(35, 40, 107, .7),
    700: Color.fromRGBO(35, 40, 107, .8),
    800: Color.fromRGBO(35, 40, 107, .9),
    900: Color.fromRGBO(35, 40, 107, 1),
  };

  static ThemeData getAppTheme(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: const Color.fromRGBO(39, 41, 45, 1),
      canvasColor: const Color.fromRGBO(24, 24, 26, 1),
      dividerColor: const Color.fromARGB(255, 42, 42, 43),
      textTheme: Theme.of(context)
          .textTheme
          .copyWith(
            titleSmall:
                Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 11),
          )
          .apply(
            bodyColor: Colors.white,
            displayColor: Colors.grey,
          ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.all(Colors.pinkAccent),
      ),
      listTileTheme: const ListTileThemeData(iconColor: Colors.pinkAccent),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromRGBO(17, 17, 17, 1),
        foregroundColor: textColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      dialogBackgroundColor: const Color.fromARGB(255, 30, 30, 30),
    );
  }
}
