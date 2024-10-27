import 'package:flutter/material.dart';

class MyTheme {
  static Color primaryColor = const Color(0xff3598DB);
  static Color whiteColor = const Color(0xffffffff);
  static Color greyColor = const Color(0xff797979);

  static ThemeData lightMode = ThemeData(
    primaryColor: primaryColor,
      scaffoldBackgroundColor: Colors.transparent,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        toolbarHeight: 120
      ),

      textTheme: TextTheme(
        titleMedium: TextStyle(
            color: MyTheme.whiteColor,
            fontSize: 25,
            fontWeight: FontWeight.bold),
      ));
}
