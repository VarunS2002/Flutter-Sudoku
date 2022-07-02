import 'package:flutter/material.dart';

import 'main.dart';
import 'styles.dart';

MaterialColor emptyColor(bool gameOver) =>
    gameOver ? Styles.primaryColor : Styles.secondaryColor;

Color buttonColor(int k, int i) {
  Color color;
  if (([0, 1, 2].contains(k) && [3, 4, 5].contains(i)) ||
      ([3, 4, 5].contains(k) && [0, 1, 2, 6, 7, 8].contains(i)) ||
      ([6, 7, 8].contains(k) && [3, 4, 5].contains(i))) {
    if (Styles.primaryBackgroundColor == Styles.darkGrey) {
      color = Styles.grey;
    } else {
      color = Colors.grey[300]!;
    }
  } else {
    color = Styles.primaryBackgroundColor;
  }

  return color;
}

double buttonSize() {
  double size = 50;
  if (HomePageState.platform.contains('android') ||
      HomePageState.platform.contains('ios')) {
    size = 38;
  }
  return size;
}

double buttonFontSize() {
  double size = 20;
  if (HomePageState.platform.contains('android') ||
      HomePageState.platform.contains('ios')) {
    size = 16;
  }
  return size;
}

BorderRadiusGeometry buttonEdgeRadius(int k, int i) {
  if (k == 0 && i == 0) {
    return const BorderRadius.only(topLeft: Radius.circular(5));
  } else if (k == 0 && i == 8) {
    return const BorderRadius.only(topRight: Radius.circular(5));
  } else if (k == 8 && i == 0) {
    return const BorderRadius.only(bottomLeft: Radius.circular(5));
  } else if (k == 8 && i == 8) {
    return const BorderRadius.only(bottomRight: Radius.circular(5));
  }
  return BorderRadius.circular(0);
}
