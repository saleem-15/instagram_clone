import 'package:get/get.dart';
import 'package:instagram_clone/features/auth/views/forgot_password_screen.dart';
import 'package:instagram_clone/features/auth/views/reset_password_screen.dart';
import 'package:instagram_clone/features/profile/views/edit_profile_view.dart';
import 'package:instagram_clone/features/root/bindings/my_app_binding.dart';
import 'package:instagram_clone/app.dart';
import 'package:instagram_clone/features/search/views/search_view.dart';

import 'package:instagram_clone/features/auth/views/otp_screen.dart';
import 'package:instagram_clone/features/auth/views/signin_view.dart';
import 'package:instagram_clone/features/auth/views/signup_view.dart';
import 'package:instagram_clone/features/profile/views/saved_posts_screen.dart';
import 'package:instagram_clone/features/profile/controllers/saved_posts_controller.dart';
import 'package:instagram_clone/features/profile/controllers/edit_profile_controller.dart';
import 'package:instagram_clone/features/comments/bindings/comments_binding.dart';
import 'package:instagram_clone/features/comments/views/comments_view.dart';
import 'package:instagram_clone/features/explorer/bindings/explorer_binding.dart';
import 'package:instagram_clone/features/explorer/views/explorer_screen.dart';
import 'package:instagram_clone/features/follows/views/follows_view.dart';
import 'package:instagram_clone/features/home/bindings/home_binding.dart';
import 'package:instagram_clone/features/home/views/home_screen.dart';
import 'package:instagram_clone/features/posts/controllers/add_post_controller.dart';
import 'package:instagram_clone/features/posts/views/choose_media_view.dart';
import 'package:instagram_clone/features/profile/bindings/profile_binding.dart';
import 'package:instagram_clone/features/profile/views/profile_view.dart';
import 'package:instagram_clone/features/reels/bindings/reels_binding.dart';
import 'package:instagram_clone/features/reels/views/reels_view.dart';
import 'package:instagram_clone/features/search/bindings/search_binding.dart';
import 'package:instagram_clone/features/story/bindings/story_binding.dart';
import 'package:instagram_clone/features/story/views/story_view.dart';

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
      page: () => const SigninView(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
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
      page: () => ProfileView(),
      binding: ProfileBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.FOLLOWERS,
      page: () => FollowsView(tab: Routes.FOLLOWERS),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: _Paths.FOLLOWING,
      page: () => FollowsView(tab: Routes.FOLLOWING),
      transition: Transition.rightToLeftWithFade,
    ),
    // GetPage(
    //   name: _Paths.USER_POSTS,
    //   page: () => const UserPostsScreen(),

    //   ///   the controller of the [UserPostsScreen] is already initilized by the profile screen
    // ),
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
      page: () => StoryView(),
      binding: StoryBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => const SearchView(),
      binding: SearchBindings(),
    ),
    GetPage(
      name: _Paths.SAVED_POSTS,
      page: () => const SavedPostsScreen(),
      binding: BindingsBuilder.put(() => SavedPostsController()),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: BindingsBuilder.put(
          () => EditProfileController(profile: Get.arguments)),
      transition: Transition.rightToLeft,
    ),
  ];
}
