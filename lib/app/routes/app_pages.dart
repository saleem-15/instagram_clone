import 'package:get/get.dart';
import 'package:instagram_clone/app/modules/auth/screens/signin_screen.dart';
import 'package:instagram_clone/app/modules/profile/controllers/followers_tab_controller.dart';
import 'package:instagram_clone/app/modules/profile/screens/followers_num_screen.dart';

import '../modules/auth/screens/signup_screen.dart';
import '../modules/comments/bindings/comments_binding.dart';
import '../modules/comments/views/comments_view.dart';
import '../modules/explorer/bindings/explorer_binding.dart';
import '../modules/explorer/views/explorer_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/screens/profile_screen.dart';
import '../modules/reels/bindings/reels_binding.dart';
import '../modules/reels/views/reels_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    // GetPage(
    //   name: _Paths.INFO_VIEW,
    //   page: () => const InfoView(),
    //   binding: HomeBinding(),
    // ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => const SigninScreen(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupScreen(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.EXPLORER,
      page: () => const ExplorerView(),
      binding: ExplorerBinding(),
    ),
    GetPage(
      name: _Paths.REELS,
      page: () => const ReelsView(),
      binding: ReelsBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.COMMENTS,
      page: () => const CommentsView(),
      binding: CommentsBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: _Paths.FOLLOWERS,
      page: () => const Follower_Following_Screen(pageIndex: 0),
      binding: BindingsBuilder(
        () => Get.put<FollowsTabController>(FollowsTabController()),
      ),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: _Paths.FOLLOWING,
      page: () => const Follower_Following_Screen(pageIndex: 1),
      binding: BindingsBuilder(
        () => Get.put<FollowsTabController>(FollowsTabController()),
      ),
      transition: Transition.rightToLeftWithFade,
    ),
  ];
}
