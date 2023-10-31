import 'package:flutter/material.dart';
import 'package:todo/config/constant/constant_colors.dart';
import 'package:todo/shared/helpers/helper_color.dart';

ThemeData get themeDark {
  final constantColors = ContanstColors();
  return ThemeData(
      primaryColor: Colors.black,
      scaffoldBackgroundColor: Colors.white10,
      appBarTheme: const AppBarTheme(color: Colors.black, centerTitle: true, elevation: 0),
      primarySwatch: Colors.red,
      visualDensity: VisualDensity.adaptivePlatformDensity,

      //TEXT
      textTheme: TextTheme(
        titleMedium: TextStyle(color: Colors.white70),
      ),

      //BTN
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black87,
            backgroundColor: getColorHex(constantColors.neon_orange),
            textStyle: const TextStyle(color: Colors.black),
            disabledBackgroundColor: Colors.black38,
            disabledForegroundColor: Colors.black87),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: Colors.red),

      // INPUTS
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Colors.white60,
        alignLabelWithHint: true,
        hintStyle: TextStyle(fontWeight: FontWeight.w400, color: Colors.red),
        helperStyle: TextStyle(fontWeight: FontWeight.w400, color: Colors.red),
        contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
      ),

      // LIST
      listTileTheme: ListTileThemeData(
        textColor: Colors.white,
        tileColor: getColorHex(constantColors.onyx),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ));
}
