
import 'package:get/get.dart';
import 'package:instagram_clone/app/models/reel.dart';
import 'package:instagram_clone/app/modules/reels/services/reels_service.dart';

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
