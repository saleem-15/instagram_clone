import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import 'package:instagram_clone/app/models/post.dart';
import 'package:instagram_clone/app/modules/posts/services/set_post_is_loved_service.dart';
import 'package:instagram_clone/app/routes/app_pages.dart';

import '../services/set_post_is_saved_service.dart';

class PostsController extends GetxController {
  final Map<String, int> postsIndex = {};
  final Map<String, VideoPlayerController> cashedVideos = {};

  final carouselController = CarouselController();

  void viewPostComments(Post post) {
    Get.toNamed(
      Routes.COMMENTS,
      arguments: post,
    );
  }

  void comment(Post post) {
    Get.toNamed(
      Routes.COMMENTS,
      parameters: {'isTextFieldFocused': 'true'},
      arguments: post,
    );
  }

  Future<void> onHeartPressed(Post post) async {
    final isSuccess = await setPostIsLovedService(post.id, !post.isFavorite);
    if (isSuccess) {
      post.isFavorite = !post.isFavorite;
      update(['${post.id} love button']);
    }
  }

  Future<void> onSaveButtonPressed(Post post) async {
    final isSuccess = await setPostIsSavedService(post.id, !post.isSaved);
    if (isSuccess) {
      post.isSaved = !post.isSaved;
      update(['${post.id} save button']);
    }
  }

  void onImageSlided(Post post, int index, CarouselPageChangedReason reason) {
    postsIndex[post.id] = index;
    update(['selected content index']);
  }

  Future<VideoPlayerController> initilizeVideoController(String videoUrl) async {
    if (cashedVideos.containsKey(videoUrl)) {
      return cashedVideos[videoUrl]!..play();
    }
    final videoController = VideoPlayerController.network(videoUrl);
    await videoController.initialize();

    cashedVideos.addIf(true, videoUrl, videoController);

    /// video is silent by default
    videoController
      ..setVolume(0)
      ..play();

    return videoController;
  }

  onVideoTapped(VideoPlayerController videoPlayerController, Post post, int videoIndex) {
    videoPlayerController.setVolume(videoPlayerController.value.volume == 0 ? 1 : 0);

    update(['${post.id} $videoIndex']);
  }

  void registerPost(Post post) {
    postsIndex.addIf(!postsIndex.containsKey(post.id), post.id, 0);
  }
}
