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

  /// how much time the story has (before moving  to the next story)
  // late final CountDown timeCounter;
  PausableTimer? _timer;

  static final Map<String, MyVideoController> cashedVideos = {};

  User user;

  /// the index of the user in the list of [stories] that exist
  /// in [StoriesController]
  int userIndex;
  List<Story> get storiesList => user.userStories;
  int get storiesNum => storiesList.length;
  late int currentStoryIndex;

  Story get currentStory {
    final story = storiesList[currentStoryIndex];
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
      StoryIndicatorController(
          maxSingleIndicatorWidth: singleStoryIndicatorWidth),
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

  /// Initializes and returns a [VideoPlayerController] for the given [videoUrl].
  ///
  /// If a controller for this URL was already initialized, it is returned from
  /// the in-memory cache and immediately starts playing.
  /// Otherwise a new [MyVideoController] is created, awaited, then cached.
  Future<VideoPlayerController> initilizeVideoController(
      String videoUrl) async {
    if (cashedVideos.containsKey(videoUrl)) {
      // Cache hit: reuse the existing controller and resume playback.
      cashedVideos[videoUrl]!.playVideo();
      return cashedVideos[videoUrl]!.controller!;
    }

    isLoading(true);
    // Use the new single-constructor API introduced in Task 2.
    final videoController = MyVideoController(videoUrl: videoUrl);
    cashedVideos.addAll({videoUrl: videoController});
    await videoController.initialize();

    isLoading(false);

    // .controller is the nullable getter that replaces the old .videoPlayerController.
    return videoController.controller!;
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
      // .pauseVideo() replaces the old .pause() after the Task 2 rename.
      cashedVideos[currentStory.media]!.pauseVideo();
    }

    /// if all stories of this user has finished
    if (storiesNum - 1 == currentStoryIndex) {
      /// all the stories of this user has been watched
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
    /// pause the video (if the story was a video)
    if (currentStory.media.isVideoFileName) {
      cashedVideos[currentStory.media]!.pauseVideo();
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

    if (!currentStory.isWathced) {
      /// tell the backend that this story is wathed
      setStoryAsWatchedService(currentStory.id);
      currentStory.isWathced = true;
    }

    final storyDuration = currentStory.media.isImageFileName
        ? IMAGE_STORY_DURATION
        // .controller replaces the old .videoPlayerController getter.
        : cashedVideos[currentStory.media]!
            .controller!
            .value
            .duration;

    createTimer(storyDuration);
    _timer!.start();
    storyIndicatorController.startAnimation(storyDuration);
  }

  void pauseStory() {
    _timer!.pause();
    storyIndicatorController.pauseAnimation();

    /// pause the video (if the story was a video)
    if (currentStory.media.isVideoFileName) {
      cashedVideos[currentStory.media]!.pauseVideo();
    }
  }

  void resumeStory() {
    _timer!.start();
    storyIndicatorController.resumeAnimation();

    /// resume the video (if the story was a video)
    if (currentStory.media.isVideoFileName) {
      // .playVideo() replaces the old .resume() after the Task 2 rename.
      cashedVideos[currentStory.media]!.playVideo();
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
    /// Pause the video and dispose resources when the controller is destroyed.
    if (currentStory.media.isVideoFileName) {
      cashedVideos[currentStory.media]!.pauseVideo();
    }
    _timer?.cancel();
    super.onClose();
  }
}
