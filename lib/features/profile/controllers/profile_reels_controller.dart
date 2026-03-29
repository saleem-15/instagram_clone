import 'package:instagram_clone/features/reels/services/reels_service.dart';

import 'package:get/get.dart';
import 'package:instagram_clone/core/models/reel.dart';

class ProfileReelsTabController extends GetxController {
  final String profileUserId;
  ProfileReelsTabController({required this.profileUserId});

  var reels = <Reel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserReels();
  }

  Future<void> fetchUserReels() async {
    isLoading(true);

    final result = await ReelsService.getUserReels(userId: profileUserId);
    reels.assignAll(result);

    isLoading(false);
  }
}
