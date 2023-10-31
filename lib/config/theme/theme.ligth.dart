import 'package:flutter/material.dart';
import 'package:todo/config/constant/constant_colors.dart';
import 'package:todo/shared/helpers/helper_color.dart';

ThemeData get themeLigth {
  final constantColors = ContanstColors();
  return ThemeData(
    primaryColor: Colors.black,
    scaffoldBackgroundColor: getColorHex(constantColors.french_gray_20),
    appBarTheme: AppBarTheme(color: getColorHex('F94144'), centerTitle: true, elevation: 0),
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,

    //BUTTONS
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: getColorHex(constantColors.black),
    ),

    // INPUTS
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Colors.white24,
      alignLabelWithHint: true,
      hintStyle: TextStyle(fontWeight: FontWeight.w400, color: Colors.red),
      contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
    ),

    // LIST
    listTileTheme: ListTileThemeData(
      textColor: getColorHex(constantColors.black),
      tileColor: getColorHex(constantColors.white),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  );
}
