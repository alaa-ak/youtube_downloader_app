import 'package:flutter/material.dart';

class Dimensions {
  static double screenHeight =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window)
          .size
          .height
          .toDouble(); // 683
  static double screenWidth =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window)
          .size
          .width
          .toDouble(); // 411

  //Dynamic Height
  static double height8 = screenHeight / 85.37;
  static double height10 = screenHeight / 68.3;
  static double height80 = screenHeight / 8.35;
  static double height20 = screenHeight / 34.15;

  //Dynamic width
  static double width10 = screenWidth / 41.1;
  static double width15 = screenWidth / 27.4;
  static double width20 = screenWidth / 20.55;

  //Download Link Screen Height
  static double height250 = screenHeight / 2.73;

  //Dynamic Button Widget Width Size
  static double width210 = screenWidth / 1.95;

  //Dynamic Fonts
  static double font10 = screenHeight / 68.3;
  static double font12 = screenHeight / 56.91;
  static double font14 = screenHeight / 48.78;
  static double font15 = screenHeight / 45.53;
  static double font17 = screenHeight / 40.17;
  static double font18 = screenHeight / 37.94;
  static double font20 = screenHeight / 34.15;
  static double font23 = screenHeight / 29.69;
  static double font25 = screenHeight / 27.23;
  static double font30 = screenHeight / 22.7;
  static double font34 = screenHeight / 20.08;

  //Dynamic Radius
  static double radius7 = screenHeight / 97.57;
  static double radius21 = screenHeight / 32.52;

  // Dynamic Icon Size
  static double iconSize15 = screenHeight / 45.53;
  static double iconSize20 = screenHeight / 34.15;
  static double iconSize25 = screenHeight / 27.23;
  static double iconSize30 = screenHeight / 22.76;
  //Dynamic Video Screen Height
  static double height300 = screenHeight / 0.85;
}
