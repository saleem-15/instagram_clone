import 'package:get/get.dart';
import 'package:instagram_clone/app/modules/profile/controllers/followers_controller.dart';
import 'package:instagram_clone/app/modules/profile/views/followers_num_view.dart';

import '../modules/comments/bindings/comments_binding.dart';
import '../modules/comments/views/comments_view.dart';
import '../modules/explorer/bindings/explorer_binding.dart';
import '../modules/explorer/views/explorer_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/reels/bindings/reels_binding.dart';
import '../modules/reels/views/reels_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
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
      page: () => const ProfileView(),
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
      page: () => const FollowersNumView(),
      binding: BindingsBuilder(() => Get.put(FollowersController())),
      transition: Transition.rightToLeftWithFade,
    ),
  ];
}
