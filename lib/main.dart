import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/app/modules/auth/bindings/auth_binding.dart';

import 'package:instagram_clone/app/storage/my_shared_pref.dart';
import 'package:logger/logger.dart';

import 'app/modules/auth/controllers/auth_conroller.dart';
import 'app/modules/auth/screens/signin_screen.dart';
import 'app/modules/root/controllers/app_controller.dart';
import 'app/modules/root/my_app.dart';
import 'app/routes/app_pages.dart';
import 'app/shared/error_widget.dart';
import 'config/theme/my_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  ErrorWidget.builder = (FlutterErrorDetails details) => MyErrorWidget(details);
  await MySharedPref.init();

  // MySharedPref.setUserToken(null);
  AuthBinding().dependencies();
  Get.lazyPut(() => AppController(), fenix: true);

  runApp(const Main());
}

late Logger logger;

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // log(MySharedPref.getToken!);
    logger = Logger();

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
        home: Get.find<AuthController>().isAuthorized ? const MyApp() : const SigninScreen(),
        // const SigninScreen()
      ),
    );
  }
}
