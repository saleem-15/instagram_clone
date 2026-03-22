import 'dart:io';

import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:instagram_clone/app/models/reel.dart';
import 'package:instagram_clone/app/modules/reels/services/reels_service.dart';
import 'package:instagram_clone/utils/constants/api.dart';

class ReelsController extends GetxController {
  var reels = <Reel>[].obs;
  var isLoading = true.obs;
  var isError = false.obs;

  final Map<String, VideoPlayerController> cashedVideos = {};

  @override
  void onInit() {
    super.onInit();
    fetchReels();
  }

  @override
  void onClose() {
    for (var controller in cashedVideos.values) {
      controller.dispose();
    }
    super.onClose();
  }

  Future<void> fetchReels() async {
    isLoading(true);
    isError(false);

    final result = await ReelsService.getReels();
    if (result != null) {
      reels.assignAll(result);
    } else {
      isError(true);
    }

    isLoading(false);
  }

  Future<void> uploadReel(File videoFile) async {
    final newReel = await ReelsService.addReel(videoFile);
    if (newReel != null) {
      reels.insert(0, newReel);
      update(['reels_list']);
    }
  }

  Future<void> deleteReel(String id) async {
    final success = await ReelsService.deleteReel(id);
    if (success) {
      reels.removeWhere((reel) => reel.id == id);
      cashedVideos.remove(id)?.dispose();
      update(['reels_list']);
    }
  }

  Future<VideoPlayerController> initilizeVideoController(
      String videoUrl) async {
    if (cashedVideos.containsKey(videoUrl)) {
      return cashedVideos[videoUrl]!..play();
    }
    final videoController = VideoPlayerController.networkUrl(
      Uri.parse(videoUrl),
      httpHeaders: Api.headers,
    );
    await videoController.initialize();

    cashedVideos[videoUrl] = videoController;
    videoController.setLooping(true);
    videoController.play();

    return videoController;
  }
}
