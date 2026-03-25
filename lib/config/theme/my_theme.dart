import 'package:flutter/material.dart';

import 'dark_theme_colors.dart';
import 'light_theme_colors.dart';
import 'my_dark_styles.dart';
import 'my_styles.dart';

// ignore_for_file: deprecated_member_use

class MyTheme {
  static ThemeData getThemeData() {
    return ThemeData(
      // main color (app bar,tabs..etc)
      colorScheme: const ColorScheme.light().copyWith(
        /// this color affects the (over scroll Glowing color)
        secondary: LightThemeColors.accentColor,
        primary: LightThemeColors.primaryColor,
        background: LightThemeColors.backgroundColor,
      ),

      scrollbarTheme: const ScrollbarThemeData(),

      primaryColor: LightThemeColors
          .primaryColor, // secondary color (for checkbox,float button, radio..etc)
      // color contrast (if the theme is dark text should be white for example)
      brightness: Brightness.light,
      // card widget background color
      cardColor: LightThemeColors.cardColor,
      // hint text color
      hintColor: LightThemeColors.hintTextColor,
      // divider color
      dividerColor: LightThemeColors.dividerColor,
      // app background color
      scaffoldBackgroundColor: LightThemeColors.scaffoldBackgroundColor,

      // progress bar theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: LightThemeColors.primaryColor),

      // appBar theme
      appBarTheme: MyStyles.getAppBarTheme(),

      // elevated button theme
      elevatedButtonTheme: MyStyles.getElevatedButtonTheme(),

      // Outlined button theme
      outlinedButtonTheme: MyStyles.getOutlinedButtonTheme(),

      //text button theme
      textButtonTheme: MyStyles.getTextButtonTheme(),

      bottomNavigationBarTheme: MyStyles.getBottomNavigationBarTheme(),

      // text theme
      textTheme: MyStyles.getTextTheme(),

      // icon theme
      iconTheme: MyStyles.getIconTheme(),

      //TabBar
      tabBarTheme: MyStyles.getTabBarTheme(),

      //divider
      dividerTheme: MyStyles.getDividerTheme(),

      radioTheme: MyStyles.getRadioButtonTheme(),

      cardTheme: MyStyles.getCardTheme(),

      bottomSheetTheme: MyStyles.getBottomSheetTheme(),

      // textField theme
      inputDecorationTheme: MyStyles.getInputDecorationTheme(),

      //dialog
      dialogTheme: MyStyles.getDialogTheme(),
    );
  }

  static ThemeData getDarkThemeData() {
    return ThemeData(
      // main color (app bar,tabs..etc)
      colorScheme: const ColorScheme.dark().copyWith(
        /// this color affects the (over scroll Glowing color)
        secondary: DarkThemeColors.accentColor,
        primary: DarkThemeColors.primaryColor,
        background: DarkThemeColors.backgroundColor,
      ),

      scrollbarTheme: const ScrollbarThemeData(),

      primaryColor: DarkThemeColors
          .primaryColor, // secondary color (for checkbox,float button, radio..etc)
      // color contrast (if the theme is dark text should be white for example)
      brightness: Brightness.dark,
      // card widget background color
      cardColor: DarkThemeColors.cardColor,
      // hint text color
      hintColor: DarkThemeColors.hintTextColor,
      // divider color
      dividerColor: DarkThemeColors.dividerColor,
      // app background color
      scaffoldBackgroundColor: DarkThemeColors.scaffoldBackgroundColor,

      // progress bar theme
      progressIndicatorTheme:
          const ProgressIndicatorThemeData(color: DarkThemeColors.primaryColor),

      // appBar theme
      appBarTheme: MyDarkStyles.getAppBarTheme(),

      // elevated button theme
      elevatedButtonTheme: MyDarkStyles.getElevatedButtonTheme(),

      // Outlined button theme
      outlinedButtonTheme: MyDarkStyles.getOutlinedButtonTheme(),

      //text button theme
      textButtonTheme: MyDarkStyles.getTextButtonTheme(),

      bottomNavigationBarTheme: MyDarkStyles.getBottomNavigationBarTheme(),

      // text theme
      textTheme: MyDarkStyles.getTextTheme(),

      // icon theme
      iconTheme: MyDarkStyles.getIconTheme(),

      //TabBar
      tabBarTheme: MyDarkStyles.getTabBarTheme(),

      //divider
      dividerTheme: MyDarkStyles.getDividerTheme(),

      radioTheme: MyDarkStyles.getRadioButtonTheme(),

      cardTheme: MyDarkStyles.getCardTheme(),

      bottomSheetTheme: MyDarkStyles.getBottomSheetTheme(),

      // textField theme
      inputDecorationTheme: MyDarkStyles.getInputDecorationTheme(),

      //dialog
      dialogTheme: MyDarkStyles.getDialogTheme(),
    );
  }
}
