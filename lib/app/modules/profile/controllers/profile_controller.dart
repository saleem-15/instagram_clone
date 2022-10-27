import 'package:get/get.dart';

import 'package:instagram_clone/app/models/post.dart';
import 'package:instagram_clone/app/models/profile.dart';
import 'package:instagram_clone/app/models/user.dart';
import 'package:instagram_clone/app/modules/follows/services/follow_user_service.dart';
import 'package:instagram_clone/app/modules/follows/services/unfollow_service.dart';
import 'package:instagram_clone/app/modules/profile/views/add_post_bottom_sheet.dart';
import 'package:instagram_clone/app/routes/app_pages.dart';
import 'package:instagram_clone/app/storage/my_shared_pref.dart';

import '../services/get_profile_info_service.dart';

class ProfileController extends GetxController {
  /// by default its my profile (not other people profiles)

  late final Profile profile;
  late final bool isMyProfile;
  late final User user;

  final RxBool isLoading = true.obs;

  final RxBool isPostFloating = false.obs;
  late Post floatingPost;

  @override
  void onInit() {
    user = Get.arguments ?? MySharedPref.getUserData;
    user.printInfo();
    isMyProfile = user.id == MySharedPref.getUserId;
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
      arguments: user,
      parameters: {
        'numOfFollowing': profile.numOfFollowings.toString(),
        'numOfFollowers': profile.numOfFollowers.toString(),
      },
    );
  }

  void goToFollowing() {
    Get.toNamed(
      Routes.FOLLOWING,
      arguments: user,
      parameters: {
        'numOfFollowing': profile.numOfFollowings.toString(),
        'numOfFollowers': profile.numOfFollowers.toString(),
      },
    );
  }

  void showAddPostBottomSheet() {
    Get.bottomSheet(const AddPostBottomSheet());
  }

  void showSettingsBottomSheet() {}

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

  // Get.parameters['userId'] = null;
}
