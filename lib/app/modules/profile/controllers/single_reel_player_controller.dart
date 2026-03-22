import 'dart:developer';

import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:instagram_clone/app/models/reel.dart';
import 'package:instagram_clone/utils/constants/api.dart';

class SingleReelPlayerController extends GetxController {
  final Reel reel;

  SingleReelPlayerController({required this.reel});

  VideoPlayerController? videoController;
  var isInitialized = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initVideo();
  }

  Future<void> _initVideo() async {
    log("_initVideo() reelUrl ${reel.reelMediaUrl}}");
    videoController = VideoPlayerController.networkUrl(
      Uri.parse(reel.reelMediaUrl),
      httpHeaders: Api.headers,
    );
    await videoController!.initialize();
    videoController!.setLooping(true);
    videoController!.play();
    isInitialized(true);
  }

  void togglePlay() {
    if (videoController == null) return;
    if (videoController!.value.isPlaying) {
      videoController!.pause();
    } else {
      videoController!.play();
    }
  }

  @override
  void onClose() {
    videoController?.dispose();
    super.onClose();
  }
}
