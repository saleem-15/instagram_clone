import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:instagram_clone/app/models/reel.dart';
import 'package:instagram_clone/app/models/post.dart';
import 'package:instagram_clone/utils/constants/api.dart';
import 'package:instagram_clone/app/routes/app_pages.dart';
import 'package:instagram_clone/app/modules/posts/services/set_post_is_loved_service.dart';
import 'package:instagram_clone/app/modules/posts/services/set_post_is_saved_service.dart';

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
    String formattedUrl = reel.reelMediaUrl.replaceAll('/public/', '/');
    videoController = VideoPlayerController.networkUrl(
      Uri.parse(formattedUrl),
      httpHeaders: Api.headers,
    );
    await videoController!.initialize();
    videoController!.setLooping(true);
    videoController!.play();
    videoController!.addListener(() {
      update(['playback']);
    });
    isInitialized(true);
  }

  void togglePlay() {
    if (videoController == null) return;
    if (videoController!.value.isPlaying) {
      videoController!.pause();
    } else {
      videoController!.play();
    }
    update(['playback']);
  }

  Future<void> onHeartPressed() async {
    reel.isFavorite = !reel.isFavorite;
    reel.numOfLikes += reel.isFavorite ? 1 : -1;
    update(['actions']);

    final isSuccess = await setPostIsLovedService(reel.id, reel.isFavorite);
    if (!isSuccess) {
      reel.isFavorite = !reel.isFavorite;
      reel.numOfLikes += reel.isFavorite ? 1 : -1;
      update(['actions']);
    }
  }

  Future<void> onSavePressed() async {
    reel.isSaved = !reel.isSaved;
    update(['actions']);

    final isSuccess = await setPostIsSavedService(reel.id, reel.isSaved);
    if (!isSuccess) {
      reel.isSaved = !reel.isSaved;
      update(['actions']);
    }
  }

  void comment() {
    // Convert to Post model layout to re-use comment views easily
    final post = Post(
      id: reel.id,
      user: reel.user,
      isFavorite: reel.isFavorite,
      isSaved: reel.isSaved,
      numOfLikes: reel.numOfLikes,
      numOfComments: reel.numOfComments,
      caption: reel.caption,
      postContents: [reel.reelMediaUrl],
    );
    Get.toNamed(Routes.COMMENTS, arguments: post);
  }

  void followUser() {
    reel.user.doIFollowHim = true;
    update(['user_info']);
  }

  @override
  void onClose() {
    videoController?.dispose();
    super.onClose();
  }
}
