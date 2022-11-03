import 'dart:async';

import 'package:get/get.dart';
import 'package:instagram_clone/app/models/story.dart';
import 'package:instagram_clone/app/models/user.dart';
import 'package:instagram_clone/app/modules/story/services/set_story_as_watched_service.dart';
import 'package:instagram_clone/app/routes/app_pages.dart';
import 'package:instagram_clone/utils/my_video_controller.dart';
import 'package:pausable_timer/pausable_timer.dart';
import 'package:video_player/video_player.dart';

import '../views/story_indicator.dart';
import 'sotry_indicator_controller.dart';
import 'stories_controller.dart';

const IMAGE_STORY_DURATION = Duration(seconds: 10);

/// for every user there is a [UserStoryController] controller
class UserStoryController extends GetxController {
  UserStoryController(User usr) : user = usr;

  /// how much time the story has (before moving  to the next story)
  // late final CountDown timeCounter;
  PausableTimer? _timer;

  static final Map<String, MyVideoController> cashedVideos = {};

  User user;
  List<Story> get storiesList => user.userStories;
  int get storiesNum => storiesList.length;
  late int currentStoryIndex;

  Story get currentStory {
    final story = storiesList[currentStoryIndex];
    story.isWathced = true;
    return story;
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
      StoryIndicatorController(maxSingleIndicatorWidth: singleStoryIndicatorWidth),
      tag: user.id,
    );

    /// by default the first unwatched story is displayed
    /// if all stories are wathced then the first story is shown
    currentStoryIndex = _getFirstUnwatchedStory ?? 0;

    isLoading.listen(loadingListener);
    super.onInit();
  }

  @override
  void onReady() async {
    startStory();
    super.onReady();
  }

  Future<VideoPlayerController> initilizeVideoController(String videoUrl) async {
    if (cashedVideos.containsKey(videoUrl)) {
      return cashedVideos[videoUrl]!.videoPlayerController..play();
    }

    isLoading(true);
    final videoController = MyVideoController.network(videoPath: videoUrl);
    cashedVideos.addAll({videoUrl: videoController});
    await videoController.initialize();

    isLoading(false);

    return videoController.videoPlayerController;
  }

  /// returnes the index of the first unwathced story
  /// if all stories are wathced then it returnes null
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

    /// pause the video (if the story was a video)
    if (currentStory.media.isVideoFileName) {
      cashedVideos[currentStory.media]!.pause();
    }

    /// if all stories of this user has finished
    if (storiesNum - 1 == currentStoryIndex) {
      /// all the stories of this user has been watched
      user.isHasNewStory = false;
      storiesController.goToNextUserStories();
      return;
    }

    currentStoryIndex += 1;
    update(['story media']);
    if (isLoading.isTrue) {}
    startStory();
  }

  void goToPreviousStory() {
    /// pause the video (if the story was a video)
    if (currentStory.media.isVideoFileName) {
      cashedVideos[currentStory.media]!.pause();
    }

    /// if this is the first story for
    if (currentStoryIndex == 0) {
      storiesController.goToPreviuosUserStories();
      return;
    }

    currentStoryIndex -= 1;
    update(['story media']);
    startStory();
  }

  /// it starts the story and syncs the story progress indicator animation
  /// with the story itself
  ///
  /// YOU MUST make sure that [currentStoryIndex] has the value of the story that you want to start
  void startStory() {
    /// tell the backend that this story is wathed
    setStoryAsWathcedService(currentStory.id);

    final storyDuration = currentStory.media.isImageFileName
        ? IMAGE_STORY_DURATION
        : cashedVideos[currentStory.media]!.videoPlayerController.value.duration;

    createTimer(storyDuration);
    _timer!.start();
    storyIndicatorController.startAnimation(storyDuration);
  }

  void pauseStory() {
    _timer!.pause();
    storyIndicatorController.pauseAnimation();

    /// pause the video (if the story was a video)
    if (currentStory.media.isVideoFileName) {
      cashedVideos[currentStory.media]!.pause();
    }
  }

  void resumeStory() {
    _timer!.start();
    storyIndicatorController.resumeAnimation();

    /// resume the video (if the story was a video)
    if (currentStory.media.isVideoFileName) {
      cashedVideos[currentStory.media]!.resume();
    }
  }

  void onUserNamePressed() {
    Get.toNamed(
      Routes.PROFILE,
      arguments: user,
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
    /// pause the video (if the story was video)
    if (currentStory.media.isVideoFileName) {
      cashedVideos[currentStory.media]!.pause();
    }
    _timer?.cancel();
    super.onClose();
  }
}
