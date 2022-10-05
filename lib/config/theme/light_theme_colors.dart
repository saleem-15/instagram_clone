import 'package:flutter/material.dart';

//CUSTOM COLORS
const Color myBlack = Color(0xFF32323D);
const Color lightRed = Color(0xFFf75555);

const Color lightGrey = Color.fromARGB(255, 230, 227, 227);

class LightThemeColors {
  //light swatch
  static const Color primaryColor = Color(0xFF101010);
  static const Color secondaryColor = myBlack;
  static const Color accentColor = Color(0xFFD9EDE1);

  //APPBAR
  static const Color appBarColor = Colors.transparent;

  //SCAFFOLD
  static const Color scaffoldBackgroundColor = Color(0xfffafafa);
  //  Color(0xfffefefe);
  static const Color backgroundColor = Colors.white;
  static const Color dividerColor = Color(0xff686868);
  static const Color cardColor = Colors.white;
  // static const Color cardColor = Color(0xfffafafa);

  //ICONS
  static const Color appBarIconsColor = Colors.black;
  static const Color iconColor = Colors.black;
  static const Color unselectedIconColor = Colors.grey;

  //BUTTON
  static Color buttonColor = const Color(0xffdedede);
  static Color authButtonColor = const Color(0xff0095F6);

  // static Color buttonColor = const Color(0xffe7e7e7); //lighter version

  static const Color buttonTextColor = Colors.black;
  static const Color buttonDisabledColor = Colors.grey;
  static const Color buttonDisabledTextColor = Colors.black;

  //TEXT
  static const Color bodyTextColor = Color(0xff424242);
  static const Color headlinesTextColor = Colors.black;
  static const Color captionTextColor = Colors.grey;
  static const Color hintTextColor = Color(0xff9e9e9e);

  //chip
  static const Color chipBackground = myBlack;
  static const Color chipTextColor = Colors.white;

  // progress bar indicator
  static const Color progressIndicatorColor = Color(0xFF40A76A);

  // Radio Button
  static const Color radioColor = primaryColor;

  // Menu
  static const Color menuColor = Color(0xff13171A);
}
