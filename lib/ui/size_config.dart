import 'package:flutter/cupertino.dart';

class SizeConfig {
  static late MediaQueryData mediaQueryData;
  static late double screeWidth;
  static late double screenHeight;
  static late Orientation screenOrientation;
  void init(BuildContext c) {
    mediaQueryData = MediaQuery.of(c);
    screeWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;
    screenOrientation = mediaQueryData.orientation;
  }

  double getScreenHeight(double inputHeight) {
    double screenHeight = SizeConfig.screenHeight;
    return (inputHeight / 812) * screenHeight;
  }
  double getScreenWidth(double inputWidth) {
    double screenWidth = SizeConfig.screenHeight;
    return (inputWidth / 375) * screenHeight;
  }
}
