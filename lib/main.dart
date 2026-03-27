import 'package:instagram_clone/core/services/storage_service.dart';
import 'package:instagram_clone/core/services/api_service.dart';
import 'package:instagram_clone/core/services/video_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/features/auth/bindings/auth_binding.dart';
import 'package:logger/logger.dart';

import 'package:instagram_clone/features/auth/controllers/auth_controller.dart';
import 'package:instagram_clone/features/auth/views/signin_view.dart';
import 'package:instagram_clone/features/root/controllers/app_controller.dart';
import 'package:instagram_clone/app.dart';
import 'package:instagram_clone/routes/app_pages.dart';
import 'package:instagram_clone/shared/error_widget.dart';
import 'package:instagram_clone/core/theme/my_theme.dart';

/// Global helper for logging. In a senior project, we use Get.find(Logger) 
/// but keeping this for easy global access during refactoring.
Logger get logger => Get.find<Logger>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  ErrorWidget.builder = (FlutterErrorDetails details) => MyErrorWidget(details);

  // Initialize Core Services
  await Get.putAsync(() => StorageService().init());
  Get.put(Logger());
  await Get.putAsync(() => ApiService().init());

  AuthBinding().dependencies();

  // Inject global services
  Get.put(VideoService());
  Get.lazyPut(() => AppController(), fenix: true);

  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Instagram clone",
          getPages: AppPages.routes,
          theme: MyTheme.getThemeData(),
          darkTheme: MyTheme.getDarkThemeData(),
          themeMode: ThemeMode.system,
          builder: (context, widget) {
            return MediaQuery(
              // but we want our app font to still the same and dont get affected
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1.0)),
              child: widget!,
            );
          },
          home: Builder(
            builder: (context) {
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
              final isDarkMode =
                  Theme.of(context).brightness == Brightness.dark;
              SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                statusBarIconBrightness:
                    isDarkMode ? Brightness.light : Brightness.dark,
                systemNavigationBarColor:
                    Theme.of(context).scaffoldBackgroundColor,
                systemNavigationBarIconBrightness:
                    isDarkMode ? Brightness.light : Brightness.dark,
              ));

              return Container(
                padding:
                    EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Get.find<AuthController>().isAuthorized
                      ? MyApp()
                      : SigninView(),
                ),
              );
            },
          )),
    );
  }
}
