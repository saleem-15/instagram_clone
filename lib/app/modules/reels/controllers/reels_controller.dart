import 'dart:io';

import 'package:get/get.dart';
import 'package:instagram_clone/app/models/reel.dart';
import 'package:instagram_clone/app/modules/reels/services/reels_service.dart';

/// Used in ReelsView for the reels page & reels profile tab
class ReelsController extends GetxController {
  ReelsController();

  var reels = <Reel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchReels();
  }

  Future<void> fetchReels() async {
    isLoading(true);
    final result = await ReelsService.getReelsFeed();
    reels.assignAll(result);

    isLoading(false);
  }

  Future<void> uploadReel(File videoFile) async {
    final newReel = await ReelsService.uploadReel(videoFile);
    if (newReel != null) {
      reels.insert(0, newReel);
      update(['reels_list']);
    }
  }

  Future<void> deleteReel(String id) async {
    final success = await ReelsService.deleteReel(id);
    if (success) {
      reels.removeWhere((reel) => reel.id == id);
      update(['reels_list']);
    }
  }
}
