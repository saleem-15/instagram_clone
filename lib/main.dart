import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/app/modules/auth/bindings/auth_binding.dart';

import 'package:instagram_clone/app/modules/auth/controllers/auth_conroller.dart';
import 'package:instagram_clone/app/modules/posts/controllers/post_controller.dart';
import 'package:instagram_clone/app/modules/root/bindings/my_app_binding.dart';
import 'package:instagram_clone/app/storage/my_shared_pref.dart';

import 'app/modules/auth/screens/signin_screen.dart';
import 'app/modules/root/my_app.dart';
import 'app/routes/app_pages.dart';
import 'config/theme/my_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await MySharedPref.init();

  // MySharedPref.setUserToken(null);

  appDependencies();
  runApp(const Main());
}

void appDependencies() {
  Get.put(PostsController(), permanent: true);
  AuthBinding().dependencies();
  if (Get.find<AuthController>().isAuthorized) {
    log('is authorized');
    MyAppBinding().dependencies();
  }
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => GetMaterialApp(
        // initialBinding: AuthBinding(),
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
        home: Get.find<AuthController>().isAuthorized ? MyApp() : const SigninScreen(),
      ),
    );
  }
}
