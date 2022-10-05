import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:instagram_clone/app/modules/auth/controllers/auth_conroller.dart';
import 'package:instagram_clone/app/modules/auth/controllers/signin_controller.dart';
import 'package:instagram_clone/app/modules/auth/controllers/signup_controller.dart';
import 'package:instagram_clone/app/modules/auth/screens/signin_screen.dart';
import 'package:instagram_clone/app/modules/comments/controllers/comments_controller.dart';
import 'package:instagram_clone/app/modules/home/controllers/home_controller.dart';
import 'package:instagram_clone/app/modules/home/controllers/post_controller.dart';
import 'package:instagram_clone/app/modules/profile/controllers/followers_controller.dart';
import 'package:instagram_clone/app/modules/profile/controllers/profile_controller.dart';
import 'package:instagram_clone/app/storage/my_shared_pref.dart';

import 'app/my_app.dart';
import 'app/routes/app_pages.dart';
import 'config/theme/my_theme.dart';

Future<void> main() async {
  await MySharedPref.init();
  Get.put(HomeController());
  Get.put(AuthController(), permanent: true);
  Get.lazyPut(() => SignupController(), fenix: true);
  Get.lazyPut(() => SigninController());
  Get.put(PostController(), permanent: true);
  Get.lazyPut(() => CommentsController(), fenix: true);
  Get.lazyPut(() => FollowersController(), fenix: true);
  Get.put(ProfileController());
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => GetMaterialApp(
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
            // const MyApp()
            Container(
          color: Colors.blue,
          child: GetBuilder<AuthController>(
            assignId: true,
            id: 'auth_listener',
            builder: (controller) {
              return controller.isUserSignedIn ? const MyApp() : const SigninScreen();
            },
          ),
        ),
      ),
    );
  }
}
