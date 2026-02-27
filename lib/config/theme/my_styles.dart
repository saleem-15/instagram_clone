import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'light_theme_colors.dart';
import 'my_fonts.dart';

class MyStyles {
  ///icons theme
  static IconThemeData getIconTheme() => const IconThemeData(
        color: LightThemeColors.iconColor,
      );

  /// Tab Bar theme
  static TabBarThemeData getTabBarTheme() => TabBarThemeData(
        unselectedLabelColor: LightThemeColors.unselectedIconColor,
        labelColor: LightThemeColors.iconColor,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        indicator: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black,
              width: 1,
            ),
          ),
        ),
      );

  ///app bar theme
  static AppBarTheme getAppBarTheme() => AppBarTheme(
        /// this is status bar theme (kinda)
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
        ),
        elevation: 0,
        titleTextStyle: getTextTheme().bodyLarge!.copyWith(
              fontSize: MyFonts.appBarTittleSize,
            ),
        iconTheme: const IconThemeData(
          color: LightThemeColors.appBarIconsColor,
        ),
        backgroundColor: LightThemeColors.appBarColor,
      );

  ///text theme
  static TextTheme getTextTheme() => TextTheme(
        labelLarge: MyFonts.buttonTextStyle
            .copyWith(fontSize: MyFonts.buttonTextSize),
        //
        bodyLarge: (MyFonts.bodyTextStyle).copyWith(
            fontWeight: FontWeight.bold,
            fontSize: MyFonts.body1TextSize,
            color: LightThemeColors.bodyTextColor),

        //
        bodyMedium: (MyFonts.bodyTextStyle).copyWith(
          fontSize: MyFonts.body2TextSize,
          color: LightThemeColors.bodyTextColor,
        ),
        displayLarge: (MyFonts.headlineTextStyle).copyWith(
            fontSize: MyFonts.headline1TextSize,
            fontWeight: FontWeight.bold,
            color: LightThemeColors.headlinesTextColor),
        //
        displayMedium: (MyFonts.headlineTextStyle).copyWith(
            fontSize: MyFonts.headline2TextSize,
            fontWeight: FontWeight.bold,
            color: LightThemeColors.headlinesTextColor),
        //
        displaySmall: (MyFonts.headlineTextStyle).copyWith(
            fontSize: MyFonts.headline3TextSize,
            fontWeight: FontWeight.bold,
            color: LightThemeColors.headlinesTextColor),
        //
        headlineMedium: (MyFonts.headlineTextStyle).copyWith(
            fontSize: MyFonts.headline4TextSize,
            fontWeight: FontWeight.bold,
            color: LightThemeColors.headlinesTextColor),
        //
        headlineSmall: (MyFonts.headlineTextStyle).copyWith(
            fontSize: MyFonts.headlineSmallTextSize,
            fontWeight: FontWeight.bold,
            color: LightThemeColors.headlinesTextColor),
        //
        titleLarge: (MyFonts.headlineTextStyle).copyWith(
            fontSize: MyFonts.titleLargeTextSize,
            fontWeight: FontWeight.w700,
            color: LightThemeColors.headlinesTextColor),
        bodySmall: TextStyle(
            color: LightThemeColors.captionTextColor,
            fontSize: MyFonts.captionTextSize),
      );

  // elevated button text style
  static WidgetStateProperty<TextStyle?>?
      getElevatedButtonTextStyle() {
    return WidgetStateProperty.all(
      MyFonts.buttonTextStyle.copyWith(
        fontWeight: MyFonts.buttonTextFontWeight,
        fontSize: MyFonts.buttonTextSize,
        color: LightThemeColors.buttonTextColor,
      ),
    );
  }

  //elevated button theme data
  static ElevatedButtonThemeData getElevatedButtonTheme() =>
      ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.5.r)),
          ),
          elevation: WidgetStateProperty.all(0),
          textStyle: getElevatedButtonTextStyle(),
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.pressed)) {
                return LightThemeColors.buttonColor
                    .withValues(alpha: 0.8);
              } else if (states.contains(WidgetState.disabled)) {
                return LightThemeColors.buttonDisabledColor;
              }
              return LightThemeColors
                  .buttonColor; // Use the component's default.
            },
          ),
        ),
      );

  static TextButtonThemeData getTextButtonTheme() =>
      TextButtonThemeData(
        style: ButtonStyle(
          overlayColor: WidgetStateProperty.all(Colors.transparent),
        ),
      );

// static
  static getRadioButtonTheme() => RadioThemeData(
        fillColor: WidgetStateProperty.all<Color>(
            LightThemeColors.radioColor),
      );

  /// divider theme
  static getDividerTheme() => const DividerThemeData(
        color: LightThemeColors.dividerColor,
        space: 0,
        thickness: .5,
      );

  /// dialog theme
  static getDialogTheme() => DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
      );

  /// card theme
  static getCardTheme() => const CardTheme(
        margin: EdgeInsets.zero,
      );

  // bottom sheet theme
  static BottomSheetThemeData getBottomSheetTheme() {
    return BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.r),
          topRight: Radius.circular(15.r),
        ),
      ),
      clipBehavior: Clip.antiAlias,
    );
  }

  static InputDecorationTheme getInputDecorationTheme() =>
      InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding:
            EdgeInsets.symmetric(horizontal: 10.sp, vertical: 0.sp),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: const BorderSide(
              color: LightThemeColors.lightGrey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: const BorderSide(
              color: LightThemeColors.lightGrey, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: const BorderSide(
              color: LightThemeColors.lightGrey, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: const BorderSide(
              color: LightThemeColors.lightGrey, width: 1),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: const BorderSide(
              color: LightThemeColors.lightGrey, width: 1),
        ),
      );
  static InputDecoration getInputDecoration() => InputDecoration(
        filled: true,
        fillColor: LightThemeColors.lightGrey,
        // contentPadding: EdgeInsets.only(left: 15.sp, right: 10.sp),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(
              color: LightThemeColors.lightGrey, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(
              color: LightThemeColors.lightGrey, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(
              color: LightThemeColors.lightGrey, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(
              color: LightThemeColors.lightGrey, width: 1.5),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13.r),
          borderSide: const BorderSide(
              color: LightThemeColors.lightGrey, width: 1.5),
        ),
      );

  static BottomNavigationBarThemeData getBottomNavigationBarTheme() {
    return BottomNavigationBarThemeData(
      //  iconSize: 25.sp,
      elevation: 0,
      backgroundColor: Colors.transparent,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: LightThemeColors.myBlack,
      unselectedItemColor: Colors.grey[400],
      showSelectedLabels: false,
      showUnselectedLabels: false,
    );
  }

  //*************************** My Custom Styles For a Specific Use Cases  ***********************************

  static ButtonStyle getAuthButtonStyle() => ButtonStyle(
        textStyle: getElevatedButtonTextStyle(),
        fixedSize: WidgetStateProperty.all(Size(330.w, 40.sp)),
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        backgroundColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) {
              return LightThemeColors.authButtonColor
                  .withValues(alpha: 0.8);
            } else if (states.contains(WidgetState.disabled)) {
              return LightThemeColors.authButtonColor
                  .withValues(alpha: .4);
            }
            return LightThemeColors
                .authButtonColor; // Use the component's default.
          },
        ),
      );

  static ButtonStyle getPostCommentButtonStyle() => ButtonStyle(
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return LightThemeColors.authButtonColor
                .withValues(alpha: .4);
          }

          return LightThemeColors.authButtonColor;
        }),
      );

  static OutlinedButtonThemeData getOutlinedButtonTheme() {
    return OutlinedButtonThemeData(
      style: ButtonStyle(
        fixedSize: WidgetStateProperty.all(Size(330.w, 40.sp)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.sp),
          ),
        ),
        side: WidgetStateProperty.all(
          const BorderSide(
            width: 1,
            color: LightThemeColors.lightBlue,
          ),
        ),
      ),
    );
  }
}
