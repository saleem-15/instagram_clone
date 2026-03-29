import 'package:instagram_clone/features/story/services/set_story_as_watched_service.dart';
import 'dart:async';

import 'package:get/get.dart';
import 'package:instagram_clone/core/models/story.dart';
import 'package:instagram_clone/core/models/user.dart';
import 'package:instagram_clone/routes/app_pages.dart';
import 'package:instagram_clone/core/utils/my_video_controller.dart';
import 'package:pausable_timer/pausable_timer.dart';
import 'package:video_player/video_player.dart';

import '../views/widgets/story_progress_indicator_widget.dart';
import 'sotry_indicator_controller.dart';
import 'stories_controller.dart';

const IMAGE_STORY_DURATION = Duration(seconds: 10);

/// for every user there is a [UserStoryController] controller
class UserStoryController extends GetxController {
  UserStoryController(this.user, this.userIndex);

  PausableTimer? _timer;

  static final Map<String, MyVideoController> cashedVideos = {};

  User user;

  int userIndex;
  List<Story> get storiesList => user.userStories;
  int get storiesNum => storiesList.length;
  late int currentStoryIndex;

  Story get currentStory {
    return storiesList[currentStoryIndex];
  }

  late StoryIndicatorController storyIndicatorController;
  final storiesController = Get.find<StoriesController>();

  final RxBool isLoading = true.obs;
  late VideoPlayerController videoController;

  @override
  void onInit() {
    final double singleStoryIndicatorWidth =
        ((screenWidth - STORY_INDICATOR_HORIZONTAL_MARGIN * 2) / storiesNum) -
            (horizontalMarginBetweenStroyIndicator * 2);

    storyIndicatorController = Get.put(
      StoryIndicatorController(
          maxSingleIndicatorWidth: singleStoryIndicatorWidth),
      tag: user.id,
    );

    currentStoryIndex = _getFirstUnwatchedStory ?? 0;
    isLoading.listen(loadingListener);
    super.onInit();
  }

  @override
  void onReady() async {
    startStory();
    super.onReady();
  }

  Future<VideoPlayerController> initilizeVideoController(
      String videoUrl) async {
    if (cashedVideos.containsKey(videoUrl)) {
      final ctrl = cashedVideos[videoUrl]!;
      ctrl.playIfVisible();
      return ctrl.videoPlayerController!;
    }

    isLoading(true);
    final videoControllerLocal = MyVideoController(videoUrl: videoUrl);
    cashedVideos.addAll({videoUrl: videoControllerLocal});
    await videoControllerLocal.initialize();

    isLoading(false);

    return videoControllerLocal.videoPlayerController!;
  }

  int? get _getFirstUnwatchedStory {
    for (int i = 0; i < storiesList.length; i++) {
      if (!storiesList[i].isWathced) {
        return i;
      }
    }
    return null;
  }

  void goToNextStory() {
    currentStory.isWathced = true;

    if (currentStory.media.isVideoFileName) {
      cashedVideos[currentStory.media]!.pauseIfInvisible();
    }

    if (storiesNum - 1 == currentStoryIndex) {
      Get.find<StoriesController>().updateStoryTile(user.id);
      storiesController.goToNextUserStories(userIndex);
      return;
    }

    currentStoryIndex += 1;
    update(['story media']);
    if (isLoading.isTrue) {}
    startStory();
  }

  void goToPreviousStory() {
    if (currentStory.media.isVideoFileName) {
      cashedVideos[currentStory.media]!.pauseIfInvisible();
    }

    if (currentStoryIndex == 0) {
      storiesController.goToPreviuosUserStories();
      return;
    }

    currentStoryIndex -= 1;
    update(['story media']);
    startStory();
  }

  void startStory() {
    if (!currentStory.isWathced) {
      setStoryAsWatchedService(currentStory.id);
      currentStory.isWathced = true;
    }

    final storyDuration = currentStory.media.isImageFileName
        ? IMAGE_STORY_DURATION
        : cashedVideos[currentStory.media]!
            .videoPlayerController!
            .value
            .duration;

    createTimer(storyDuration);
    _timer!.start();
    storyIndicatorController.startAnimation(storyDuration);
  }

  void pauseStory() {
    _timer!.pause();
    storyIndicatorController.pauseAnimation();

    if (currentStory.media.isVideoFileName) {
      cashedVideos[currentStory.media]!.pauseIfInvisible();
    }
  }

  void resumeStory() {
    _timer!.start();
    storyIndicatorController.resumeAnimation();

    if (currentStory.media.isVideoFileName) {
      cashedVideos[currentStory.media]!.playIfVisible();
    }
  }

  void onUserNamePressed() {
    Get.toNamed(
      Routes.PROFILE,
      arguments: user,
      parameters: {'user_id': user.id},
    );
  }

  void onHold() => pauseStory();
  void onHoldEnds() => resumeStory();

  void loadingListener(bool isLoading) {}

  void createTimer(Duration duration) {
    _timer?.cancel();
    _timer = PausableTimer(duration, goToNextStory);
  }

  @override
  void onClose() {
    if (currentStory.media.isVideoFileName) {
      cashedVideos[currentStory.media]!.pauseIfInvisible();
    }
    _timer?.cancel();
    super.onClose();
  }
}
