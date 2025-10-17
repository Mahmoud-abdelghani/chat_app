import 'package:chats/core/utils/color_guide.dart';
import 'package:flutter/material.dart';

class Apptheme {
  static ThemeData lightThem = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorGuide.mainColor,
      selectedIconTheme: IconThemeData(color: Colors.white),
      unselectedIconTheme: IconThemeData(color: ColorGuide.loadingColor),
      unselectedLabelStyle: TextStyle(color: ColorGuide.loadingColor),
      unselectedItemColor: ColorGuide.loadingColor,
      selectedLabelStyle: TextStyle(color: Colors.white),
      selectedItemColor: Colors.white,
      showSelectedLabels: true,
      showUnselectedLabels: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(ColorGuide.mainColor),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: ColorGuide.mainColor,
      titleTextStyle: TextStyle(color: Colors.white),
    ),
    iconTheme: IconThemeData(color: ColorGuide.mainColor),
    textTheme: TextTheme(
      displaySmall: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
      displayMedium: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    ),
    primaryColor: ColorGuide.mainColor,
    primaryColorDark: ColorGuide.loadingColor,
    primaryColorLight: ColorGuide.secondColor,
    shadowColor: const Color.fromARGB(255, 25, 75, 75),
    disabledColor: Colors.white,
    snackBarTheme: SnackBarThemeData(backgroundColor: ColorGuide.mainColor),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: ColorGuide.mainColor,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorGuide.mainColor,
      foregroundColor: Colors.white,
    ),
    hintColor: Colors.black,
  );
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xff0A1414),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorGuide.mainColorDark,
      selectedIconTheme: IconThemeData(color: Colors.white),
      unselectedIconTheme: IconThemeData(color: ColorGuide.loadingColor),
      unselectedLabelStyle: TextStyle(color: ColorGuide.loadingColor),
      unselectedItemColor: ColorGuide.loadingColor,
      selectedLabelStyle: TextStyle(color: Colors.white),
      selectedItemColor: Colors.white,
      showSelectedLabels: true,
      showUnselectedLabels: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(ColorGuide.mainColorDark),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: ColorGuide.mainColorDark,
      titleTextStyle: TextStyle(color: Colors.white),
    ),
    iconTheme: IconThemeData(color: ColorGuide.mainColorDark),
    textTheme: TextTheme(
      displaySmall: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
      displayMedium: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    primaryColor: ColorGuide.mainColorDark,
    primaryColorDark: ColorGuide.loadingColorDark,
    primaryColorLight: ColorGuide.secondColorDark,
    shadowColor: Color(0xff194B4B),
    disabledColor: Colors.white,
    snackBarTheme: SnackBarThemeData(backgroundColor: ColorGuide.mainColorDark),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: ColorGuide.mainColorDark,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorGuide.mainColorDark,
      foregroundColor: Colors.black,
    ),
    listTileTheme: ListTileThemeData(textColor: Colors.white),
    hintColor: Colors.white,
  );
}
