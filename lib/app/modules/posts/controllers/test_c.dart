import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/app/models/post.dart';
import 'package:instagram_clone/app/routes/app_pages.dart';
import 'package:video_player/video_player.dart';

class PostController extends GetxController {
  // final Post post;
  final Map<String, int> postsIndex = {};
  final Map<String, VideoPlayerController> cashedVideos = {};
  void viewPostComments(Post post) => Get.toNamed(Routes.COMMENTS);

  final carouselController = CarouselController();

  void comment(Post post) {
    Get.toNamed(
      Routes.COMMENTS,
      parameters: {'isTextFieldFocused': 'true'},
    );
  }

  void onHeartPressed(Post post) {
    ///******* Future code  ***********/
    // final isSuccess = await setPostIsLovedService(post.id, !post.isFavorite);
    // if (isSuccess) {
    //   post.isFavorite = !post.isFavorite;
    // update(['${post.id} love button']);
    // }
    ///******* Future code  ***********/

    post.isFavorite = !post.isFavorite;
    update(['${post.id} love button']);
  }

  Future<void> onSaveButtonPressed(Post post) async {
    ///******* Future code  ***********/
    // final isSuccess = await setPostIsSavedService(post.id, !post.isSaved);
    // if (isSuccess) {
    //   post.isSaved = !post.isSaved;
    //   update(['${post.id} save button']);
    // }
    ///******* Future code  ***********/

    post.isSaved = !post.isSaved;
    update(['${post.id} save button']);
  }

  void onImageSlided(
      Post post, int index, CarouselPageChangedReason reason) {
    postsIndex[post.id] = index;
    update(['selected content index']);
  }

  Future<VideoPlayerController> initilizeVideoController(
      String videoUrl) async {
    if (cashedVideos.containsKey(videoUrl)) {
      return cashedVideos[videoUrl]!..play();
    }
    final videoController =
        VideoPlayerController.networkUrl(Uri.parse(videoUrl));
    await videoController.initialize();
    cashedVideos.addIf(true, videoUrl, videoController);

    /// video is silent by default
    videoController
      ..setVolume(0)
      ..play();

    return videoController;
  }

  onVideoTapped(VideoPlayerController videoPlayerController,
      Post post, int videoIndex) {
    videoPlayerController
        .setVolume(videoPlayerController.value.volume == 0 ? 1 : 0);

    update(['${post.id} $videoIndex']);
  }

  void registerPost(Post post) {
    postsIndex.addIf(!postsIndex.containsKey(post.id), post.id, 0);
  }
}
