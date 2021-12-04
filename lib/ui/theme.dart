import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bluishC = Color(0xFF4553F3);
const Color orangeC = Color(0xFFFF941B);
const Color pinkC = Color(0xFFFF2090);
const Color whiteC = Colors.white;
const Color darkGreyC = Color(0xFF272727);
const Color darkHeaderC = Color(0xFF666666);

class Themes {
  static final light = ThemeData(
      primaryColor: bluishC,
      backgroundColor: whiteC,
      brightness: Brightness.light);
  static final dark = ThemeData(
      primaryColor: orangeC,
      backgroundColor: darkGreyC,
      brightness: Brightness.dark);
}

TextStyle get titleStyle {
  return GoogleFonts.pacifico(
      textStyle: TextStyle(
          fontSize: 17, color: Get.isDarkMode ? Colors.white : Colors.black));
}

TextStyle get centerTitle {
  return GoogleFonts.actor(
      textStyle: TextStyle(
          letterSpacing: 2,
          fontWeight: FontWeight.bold,
          fontSize: 19,
          color: Get.isDarkMode ? Colors.white : Colors.black));
}

TextStyle get titleStyle1 {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontWeight: FontWeight.w700,
          letterSpacing: 1.5,
          fontSize: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black));
}

TextStyle get subTitleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w300,
          color: Get.isDarkMode ? Colors.white : Colors.black));
}

TextStyle get subHeading {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
  ));
}

TextStyle get heading {
  return GoogleFonts.lato(
      textStyle: TextStyle(fontSize: 19, color: Colors.white));
}
