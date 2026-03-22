import 'dart:developer';

import 'package:get/get.dart';
import 'package:instagram_clone/app/models/reel.dart';
import 'package:instagram_clone/app/modules/reels/services/reels_service.dart';

class ProfileReelsController extends GetxController {
  final String profileUserId;
  ProfileReelsController({required this.profileUserId});

  var reels = <Reel>[].obs;
  var isLoading = true.obs;
  var isError = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserReels();
  }

  Future<void> fetchUserReels() async {
    isLoading(true);
    isError(false);

    final result = await ReelsService.getReels();
    if (result != null) {
      // Filter the reels that belong to the profile user
      final userReels =
          result.where((reel) => reel.user.id == profileUserId).toList();
      reels.assignAll(userReels);
    } else {
      isError(true);
    }
    log("Reels Count: ${reels.length}");
    isLoading(false);
  }
}
