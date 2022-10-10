// ignore_for_file: unused_import

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:instagram_clone/app/modules/auth/controllers/auth_conroller.dart';
import 'package:instagram_clone/app/modules/auth/controllers/signin_controller.dart';
import 'package:instagram_clone/app/modules/auth/controllers/signup_controller.dart';
import 'package:instagram_clone/app/modules/auth/services/sign_in_service.dart';
import 'package:instagram_clone/app/modules/comments/controllers/comments_controller.dart';
import 'package:instagram_clone/app/modules/explorer/controllers/explorer_controller.dart';
import 'package:instagram_clone/app/modules/home/controllers/home_controller.dart';
import 'package:instagram_clone/app/modules/home/controllers/post_controller.dart';
import 'package:instagram_clone/app/modules/profile/controllers/followers_tab_controller.dart';
import 'package:instagram_clone/app/modules/profile/controllers/profile_controller.dart';
import 'package:instagram_clone/app/storage/my_shared_pref.dart';

import 'app/modules/auth/screens/signin_screen.dart';
import 'app/my_app.dart';
import 'app/my_app_binding.dart';
import 'app/routes/app_pages.dart';
import 'app/x.dart';
import 'config/theme/my_theme.dart';

Future<void> main() async {
  await MySharedPref.init();

  // MySharedPref.setUserToken(null);

  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => GetMaterialApp(
        initialBinding: MyAppBinding(),
        debugShowCheckedModeBanner: false,
        title: "Instagram clone",
        getPages: AppPages.routes,
        builder: (context, widget) {
          return Theme(
            data: MyTheme.getThemeData(),
            child: MediaQuery(
              // but we want our app font to still the same and dont get affected
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: widget!,
            ),
          );
        },
        home:
            //  const MyApp()
            Container(
          color: Colors.blue,
          child: GetBuilder<AuthController>(
            assignId: true,
            id: 'auth_listener',
            builder: (controller) {
              // return const VideoPlayerScreen();
              log('********* auth_listener is build *********');
              return controller.isAuthorized ? const MyApp() : const SigninScreen();
            },
          ),
        ),
      ),
    );
  }
}
