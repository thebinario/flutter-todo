import 'package:flutter/material.dart';

getColorHex(String hexColor){
  final hex = int.parse('0xFF$hexColor');
  return Color(hex);
}

