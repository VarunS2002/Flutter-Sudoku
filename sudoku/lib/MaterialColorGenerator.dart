import 'package:flutter/material.dart';

class MaterialColorGenerator {
  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    print(color.value);
    print(swatch);
    return MaterialColor(color.value, swatch);
  }
}

void main() {
  // ignore: unused_local_variable
  MaterialColor blue = MaterialColorGenerator.createMaterialColor(Color(0xFF3880FF)); // 3880ff
  // ignore: unused_local_variable
  MaterialColor red = MaterialColorGenerator.createMaterialColor(Color(0xFFEB445A)); // eb445a
}
