import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:instagram_clone/app/modules/auth/controllers/auth_conroller.dart';
import 'package:instagram_clone/app/modules/profile/controllers/post_bottom_sheet_controller.dart';
import 'package:instagram_clone/app/storage/my_shared_pref.dart';

import 'app/modules/auth/screens/signin_screen.dart';
import 'app/my_app.dart';
import 'app/my_app_binding.dart';
import 'app/routes/app_pages.dart';
import 'config/theme/my_theme.dart';

final myUser = MySharedPref.getUserData;

Future<void> main() async {
  await MySharedPref.init();

  // MySharedPref.setUserToken(null);
  Get.lazyPut(() => AddPostBottomSheetController(), fenix: true);
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // log('my tohen ${MySharedPref.getToken}');
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
        home: Container(
          color: Colors.blue,
          child: GetBuilder<AuthController>(
            assignId: true,
            id: 'auth_listener',
            builder: (controller) {
              log('********* auth_listener is build *********');
              return controller.isAuthorized ? const MyApp() : const SigninScreen();
            },
          ),
        ),
      ),
    );
  }
}
