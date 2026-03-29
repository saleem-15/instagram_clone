import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dark_theme_colors.dart';
import 'my_fonts.dart';

class MyDarkStyles {
  ///icons theme
  static IconThemeData getIconTheme() => const IconThemeData(
        color: DarkThemeColors.iconColor,
      );

  /// Tab Bar theme
  static TabBarThemeData getTabBarTheme() => TabBarThemeData(
        unselectedLabelColor: DarkThemeColors.unselectedIconColor,
        labelColor: DarkThemeColors.iconColor,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        indicator: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.white,
              width: 1,
            ),
          ),
        ),
      );

  ///app bar theme
  static AppBarTheme getAppBarTheme() => AppBarTheme(
        /// this is status bar theme (kinda)
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: getTextTheme().bodyLarge!.copyWith(
              fontSize: MyFonts.appBarTittleSize,
            ),
        iconTheme: const IconThemeData(
          color: DarkThemeColors.appBarIconsColor,
        ),
        backgroundColor: DarkThemeColors.appBarColor,
      );

  ///text theme
  static TextTheme getTextTheme() => TextTheme(
        labelLarge:
            MyFonts.buttonTextStyle.copyWith(fontSize: MyFonts.buttonTextSize),
        //
        bodyLarge: (MyFonts.bodyTextStyle).copyWith(
            fontWeight: FontWeight.bold,
            fontSize: MyFonts.body1TextSize,
            color: DarkThemeColors.bodyTextColor),

        //
        bodyMedium: (MyFonts.bodyTextStyle).copyWith(
          fontSize: MyFonts.body2TextSize,
          color: DarkThemeColors.bodyTextColor,
        ),
        displayLarge: (MyFonts.headlineTextStyle).copyWith(
            fontSize: MyFonts.headline1TextSize,
            fontWeight: FontWeight.bold,
            color: DarkThemeColors.headlinesTextColor),
        //
        displayMedium: (MyFonts.headlineTextStyle).copyWith(
            fontSize: MyFonts.headline2TextSize,
            fontWeight: FontWeight.bold,
            color: DarkThemeColors.headlinesTextColor),
        //
        displaySmall: (MyFonts.headlineTextStyle).copyWith(
            fontSize: MyFonts.headline3TextSize,
            fontWeight: FontWeight.bold,
            color: DarkThemeColors.headlinesTextColor),
        //
        headlineMedium: (MyFonts.headlineTextStyle).copyWith(
            fontSize: MyFonts.headline4TextSize,
            fontWeight: FontWeight.bold,
            color: DarkThemeColors.headlinesTextColor),
        //
        headlineSmall: (MyFonts.headlineTextStyle).copyWith(
            fontSize: MyFonts.headlineSmallTextSize,
            fontWeight: FontWeight.bold,
            color: DarkThemeColors.headlinesTextColor),
        //
        titleLarge: (MyFonts.headlineTextStyle).copyWith(
            fontSize: MyFonts.titleLargeTextSize,
            fontWeight: FontWeight.w700,
            color: DarkThemeColors.headlinesTextColor),
        bodySmall: TextStyle(
            color: DarkThemeColors.captionTextColor,
            fontSize: MyFonts.captionTextSize),
      );

  // elevated button text style
  static WidgetStateProperty<TextStyle?>? getElevatedButtonTextStyle() {
    return WidgetStateProperty.all(
      MyFonts.buttonTextStyle.copyWith(
        fontWeight: MyFonts.buttonTextFontWeight,
        fontSize: MyFonts.buttonTextSize,
        color: DarkThemeColors.buttonTextColor,
      ),
    );
  }

  //elevated button theme data
  static ElevatedButtonThemeData getElevatedButtonTheme() =>
      ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.5.r)),
          ),
          elevation: WidgetStateProperty.all(0),
          textStyle: getElevatedButtonTextStyle(),
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.pressed)) {
                return DarkThemeColors.buttonColor.withValues(alpha: 0.8);
              } else if (states.contains(WidgetState.disabled)) {
                return DarkThemeColors.buttonDisabledColor;
              }
              return DarkThemeColors
                  .buttonColor; // Use the component's default.
            },
          ),
        ),
      );

  static TextButtonThemeData getTextButtonTheme() => TextButtonThemeData(
        style: ButtonStyle(
          overlayColor: WidgetStateProperty.all(Colors.transparent),
        ),
      );

// static
  static RadioThemeData getRadioButtonTheme() => RadioThemeData(
        fillColor: WidgetStateProperty.all<Color>(DarkThemeColors.radioColor),
      );

  /// divider theme
  static DividerThemeData getDividerTheme() => const DividerThemeData(
        color: DarkThemeColors.dividerColor,
        space: 0,
        thickness: .5,
      );

  /// dialog theme
  static DialogThemeData getDialogTheme() => DialogThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
      );

  /// card theme
  static CardThemeData getCardTheme() => const CardThemeData(
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

  static InputDecorationTheme getInputDecorationTheme() => InputDecorationTheme(
        filled: true,
        fillColor: DarkThemeColors.lightGrey,
        contentPadding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 0.sp),
        hintStyle: TextStyle(
          color: DarkThemeColors.hintTextColor,
          fontSize: MyFonts.body2TextSize,
          fontWeight: MyFonts.buttonTextFontWeight,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide:
              const BorderSide(color: DarkThemeColors.lightGrey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide:
              const BorderSide(color: DarkThemeColors.lightGrey, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide:
              const BorderSide(color: DarkThemeColors.lightGrey, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide:
              const BorderSide(color: DarkThemeColors.lightGrey, width: 1),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide:
              const BorderSide(color: DarkThemeColors.lightGrey, width: 1),
        ),
      );

  static InputDecoration getInputDecoration() => InputDecoration(
        filled: true,
        fillColor: DarkThemeColors.lightGrey,
        // contentPadding: EdgeInsets.only(left: 15.sp, right: 10.sp),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide:
              const BorderSide(color: DarkThemeColors.lightGrey, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide:
              const BorderSide(color: DarkThemeColors.lightGrey, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide:
              const BorderSide(color: DarkThemeColors.lightGrey, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide:
              const BorderSide(color: DarkThemeColors.lightGrey, width: 1.5),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13.r),
          borderSide:
              const BorderSide(color: DarkThemeColors.lightGrey, width: 1.5),
        ),
      );

  static BottomNavigationBarThemeData getBottomNavigationBarTheme() {
    return BottomNavigationBarThemeData(
      //  iconSize: 25.sp,
      elevation: 0,
      backgroundColor: Colors.transparent,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: DarkThemeColors.iconColor,
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
              return DarkThemeColors.authButtonColor.withValues(alpha: 0.8);
            } else if (states.contains(WidgetState.disabled)) {
              return DarkThemeColors.authButtonColor.withValues(alpha: .4);
            }
            return DarkThemeColors
                .authButtonColor; // Use the component's default.
          },
        ),
      );

  static ButtonStyle getPostCommentButtonStyle() => ButtonStyle(
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return DarkThemeColors.authButtonColor.withValues(alpha: .4);
          }

          return DarkThemeColors.authButtonColor;
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
            color: DarkThemeColors.lightBlue,
          ),
        ),
      ),
    );
  }
}
