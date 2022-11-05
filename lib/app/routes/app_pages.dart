import 'package:get/get.dart';
import 'package:instagram_clone/app/modules/auth/screens/forgot_password_screen.dart';
import 'package:instagram_clone/app/modules/auth/screens/reset_password_screen.dart';
import 'package:instagram_clone/app/modules/root/bindings/my_app_binding.dart';
import 'package:instagram_clone/app/modules/root/my_app.dart';
import 'package:instagram_clone/app/modules/search/search_screen.dart';

import '../modules/auth/screens/otp_screen.dart';
import '../modules/auth/screens/signin_screen.dart';
import '../modules/auth/screens/signup_screen.dart';
import '../modules/comments/bindings/comments_binding.dart';
import '../modules/comments/views/comments_view.dart';
import '../modules/explorer/bindings/explorer_binding.dart';
import '../modules/explorer/views/explorer_view.dart';
import '../modules/follows/screens/follows_screen.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_screen.dart';
import '../modules/posts/controllers/add_post_controller.dart';
import '../modules/posts/views/choose_media_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/screens/profile_screen.dart';
import '../modules/profile/screens/user_posts_screen.dart';
import '../modules/reels/bindings/reels_binding.dart';
import '../modules/reels/views/reels_view.dart';
import '../modules/search/bindings/search_binding.dart';
import '../modules/story/bindings/story_binding.dart';
import '../modules/story/screens/story_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.MY_APP,
      page: () => const MyApp(),
      binding: MyAppBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => const SigninScreen(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupScreen(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordScreen(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => const ResetPasswordScreen(),
    ),
    GetPage(
      name: _Paths.OTP_FORM,
      page: () => const OtpForm(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeScreen(),
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
      page: () => ProfileScreen(),
      binding: ProfileBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.FOLLOWERS,
      page: () => FollowsScreen(tab: Routes.FOLLOWERS),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: _Paths.FOLLOWING,
      page: () => FollowsScreen(tab: Routes.FOLLOWING),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: _Paths.USER_POSTS,
      page: () => const UserPostsScreen(),

      ///   the controller of the [UserPostsScreen] is already initilized by the profile screen
    ),
    // GetPage(
    //   name: _Paths.FLOATING_POST_VIEW,
    //   page: () => const FloatingPostView(),
    //   // binding: ProfileBinding(),
    // ),
    GetPage(
      name: _Paths.ADD_POST_VIEW,
      page: () => const AddPostView(),
      binding: BindingsBuilder.put(() => AddPostController()),
    ),
    GetPage(
      name: _Paths.COMMENTS,
      page: () => const CommentsView(),
      binding: CommentsBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: _Paths.STORY,
      page: () => StoryScreen(),
      binding: StoryBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => const SearchScreen(),
      binding: SearchBindings(),
    ),
  ];
}
