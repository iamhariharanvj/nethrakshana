import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF1C3D8A); // Bootstrap Blue

  static const String primaryFontFamily = 'Montserrat'; // Change this to your desired Google Font

  static const TextStyle headline1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );



  static const TextStyle headline2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle headline3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle headline4 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle subhead1 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );

  static const TextStyle subhead2 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );

  static const TextStyle bodyText1 = TextStyle(
    fontSize: 16,
    color: Colors.black,
  );


  static const TextStyle bodyText2 = TextStyle(
    fontSize: 14,
    color: Colors.black,
  );

  // ThemeData
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    useMaterial3: true,
    hintColor: primaryColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: TextTheme(
      headline1: headline1,
      headline2: headline2,
      headline3: headline3,
      headline4: headline4,
      subtitle1: subhead1,
      subtitle2: subhead2,
      bodyText1: bodyText1,
      bodyText2: bodyText2,
    ),
    fontFamily: primaryFontFamily,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    primaryColor: primaryColor,
    hintColor: primaryColor,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: TextTheme(
      headline1: headline1.copyWith(color: Colors.white),
      headline2: headline2.copyWith(color: Colors.white),
      headline3: headline3.copyWith(color: Colors.white),
      headline4: headline4.copyWith(color: Colors.white),
      subtitle1: subhead1.copyWith(color: Colors.white),
      subtitle2: subhead2.copyWith(color: Colors.white),
      bodyText1: bodyText1.copyWith(color: Colors.white),
      bodyText2: bodyText2.copyWith(color: Colors.white),
    ),
    fontFamily: primaryFontFamily,
  );
}
