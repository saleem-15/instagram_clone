import 'package:instagram_clone/features/follows/services/unfollow_service.dart';
import 'package:instagram_clone/features/follows/services/follow_user_service.dart';
import 'package:instagram_clone/features/profile/services/get_profile_info_service.dart';
import 'package:instagram_clone/core/services/storage_service.dart';
import 'package:get/get.dart';

import 'package:instagram_clone/core/models/post.dart';
import 'package:instagram_clone/core/models/profile.dart';
import 'package:instagram_clone/core/models/user.dart';
import 'package:instagram_clone/features/profile/views/widgets/add_post_bottom_sheet.dart';
import 'package:instagram_clone/features/profile/views/widgets/settings_bottom_sheet.dart';
import 'package:instagram_clone/routes/app_pages.dart';

class ProfileController extends GetxController {
  late Profile profile;
  late final bool isMyProfile;
  late final User user;

  final RxBool isLoading = true.obs;

  final RxBool isPostFloating = false.obs;
  late Post floatingPost;

  final RxBool isAvatarFloating = false.obs;

  void setAvatarFloating(bool value) {
    isAvatarFloating.value = value;
  }

  @override
  void onInit() {
    final args = Get.arguments;
    user = (args is User) ? args : Get.find<StorageService>().getUserData!;
    isMyProfile = user.id == Get.find<StorageService>().getUserId;
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    profile = await fetchProfileInfoService(user.id);
    isLoading(false);

    super.onReady();
  }

  void goToFollowers() {
    Get.toNamed(
      Routes.FOLLOWERS,
      arguments: profile,
    );
  }

  void goToFollowing() {
    Get.toNamed(
      Routes.FOLLOWING,
      arguments: profile,
    );
  }

  void showAddPostBottomSheet() {
    Get.bottomSheet(const AddPostBottomSheet());
  }

  void showSettingsBottomSheet() {
    Get.bottomSheet(const SettingsBottomSheet());
  }

  Future<void> followUser() async {
    final isSuccessfull = await followService(user.id);
    if (isSuccessfull) {
      profile.doIFollowHim = true;
      update(['do I follow him']);
    }
  }

  Future<void> unFollowUser() async {
    final isSuccessfull = await unFollowService(user.id);
    if (isSuccessfull) {
      profile.doIFollowHim = false;
      update(['do I follow him']);
    }
  }
}
