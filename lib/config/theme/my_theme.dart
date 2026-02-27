import 'package:flutter/material.dart';

import 'light_theme_colors.dart';
import 'my_styles.dart';

// ignore_for_file: deprecated_member_use

class MyTheme {
  static getThemeData() {
    return ThemeData(
      // main color (app bar,tabs..etc)
      colorScheme: const ColorScheme.light().copyWith(
        /// this color affects the (over scroll Glowing color)
        secondary: LightThemeColors.accentColor,
        primary: LightThemeColors.primaryColor,
        background: LightThemeColors.backgroundColor,
      ),

      scrollbarTheme: const ScrollbarThemeData(),

      primaryColor: LightThemeColors.primaryColor, // secondary color (for checkbox,float button, radio..etc)
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
      progressIndicatorTheme: const ProgressIndicatorThemeData(color: LightThemeColors.primaryColor),

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
}
