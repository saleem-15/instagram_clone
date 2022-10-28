import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:instagram_clone/app/models/post.dart';
import 'package:instagram_clone/app/models/user.dart';
import 'package:instagram_clone/app/storage/my_shared_pref.dart';

import '../services/fetch_profile_posts_service.dart';
import '../views/floating_post_view.dart';

class UserPostsController extends GetxController {
  // by default its my profile
  late final User user;

  int numOfPages = 5;
  final pagingController = PagingController<int, Post>(
    firstPageKey: 1,
  );

  /// this variable describes if the [onPostPressEnded] was called or not
  bool isFunctionCalled = false;

  late Timer timer;
  final RxBool isUserHoldingPress = false.obs;
  late Post floatingPost;

  @override
  void onInit() {
    user = Get.arguments ?? MySharedPref.getUserData;

    pagingController.addPageRequestListener((pageKey) async {
      fetchProfilePosts(user.id, pageKey);
    });

    makePostFloatingWhenHoldingPressAutomatically();

    super.onInit();
  }

  Future<void> fetchProfilePosts(String userId, int pageKey) async {
    try {
      final followersNewPage = await fetchProfilePostsService(userId, pageKey);

      final isLastPage = numOfPages == pageKey;

      if (isLastPage) {
        pagingController.appendLastPage(followersNewPage);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(followersNewPage, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
      log(error.toString());
      rethrow;
    }
  }

  void makePostFloatingWhenHoldingPressAutomatically() {
    isUserHoldingPress.listen((isUserHoldingPress) {
      if (isUserHoldingPress) {
        /// make the post floating
        Get.dialog(
          FloatingPostView(post: floatingPost),
        );
      } else {
        Get.back();
      }
    });
  }

  onPostPressStarted(Post post) async {
    log('press is started');

    startTimer();
    floatingPost = post;
  }

  onPostPressEnded(Post post) {
    log('press is gone');
    isFunctionCalled = true;
    isUserHoldingPress(false);
  }

  void startTimer() {
    isFunctionCalled = false;
    timer = Timer(const Duration(milliseconds: 300), () {
      log('timer is up');
      if (!isFunctionCalled) {
        ///if timer is finished and the user did not remove his hand from the screen
        isUserHoldingPress(true);
      } else {
        isUserHoldingPress(false);
      }
      isFunctionCalled = false;
    });
  }

  Future<void> onRefresh() async {
    pagingController.refresh();
  }

  // onTap(Post post) {
  //   // Get.toNamed(Routes.USER_POSTS);
  // }
}
