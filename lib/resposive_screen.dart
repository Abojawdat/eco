import 'package:flutter/material.dart';

class ResponsiveHelper {
  final BuildContext context;
  late double screenWidth;
  late double screenHeight;

  ResponsiveHelper(this.context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }

  /// Width percentage
  double wp(double percent) {
    return screenWidth * (percent / 100);
  }

  /// Height percentage
  double hp(double percent) {
    return screenHeight * (percent / 100);
  }

  /// Text size scaling
  double sp(double size) {
    // this makes text responsive based on screen width
    return screenWidth * (size / 100);
  }
}
