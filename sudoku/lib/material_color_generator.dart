// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

MaterialColor createMaterialColor(String hexColorCode) {
  Color color = Color(int.parse("0xFF$hexColorCode"));
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  // print(color.value);
  // print(swatch);
  print("MaterialColor(${color.value},$swatch);");
  return MaterialColor(color.value, swatch);
}

void main() {
  // ignore: unused_local_variable
  MaterialColor grey = createMaterialColor("303030");
}
