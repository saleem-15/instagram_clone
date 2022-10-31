import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:instagram_clone/app/models/story.dart';
import 'package:instagram_clone/app/models/user.dart';
import 'package:instagram_clone/app/routes/app_pages.dart';
import 'package:instagram_clone/utils/count_down.dart';
import 'package:video_player/video_player.dart';

import '../views/story_indicator.dart';
import 'sotry_indicator_controller.dart';

const STORY_DURATION = Duration(seconds: 10);

/// for every user there is a [UserStoryController] controller
class UserStoryController extends GetxController {
  UserStoryController(User usr) : user = usr;

  /// how much time the story has (before moving  to the next story)
  late final CountDown timeCounter = CountDown(
    countDownTime: Duration(seconds: STORY_DURATION.inSeconds * storiesNum),
    periodTimeCallBack: STORY_DURATION,
    onPeriod: goToNextStory,
    onFinish: () {},
  );

  /// the keys are the urls of the videos
  static final Map<String, VideoPlayerController> cashedVideos = {};

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

  final RxBool isLoading = true.obs;
  late VideoPlayerController videoController;

  @override
  void onInit() {
    /// by default the first unwatched story is displayed
    /// if all stories are wathced then the first story is shown
    currentStoryIndex = _getFirstUnwatchedStory ?? 0;

    final double singleStoryIndicatorWidth =
        ((screenWidth - STORY_INDICATOR_HORIZONTAL_MARGIN * 2) / storiesNum) -
            (horizontalMarginBetweenStroyIndicator * 2);

    storyIndicatorController = Get.put(
      StoryIndicatorController(maxSingleIndicatorWidth: singleStoryIndicatorWidth),
      tag: user.id,
    );

    timeCounter.startTimer();
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    isLoading(false);
    super.onReady();
  }

  Future<VideoPlayerController> initilizeVideoController(String videoUrl) async {
    if (cashedVideos.containsKey(videoUrl)) {
      return cashedVideos[videoUrl]!..play();
    }
    final videoController = VideoPlayerController.network(videoUrl);
    await videoController.initialize();

    cashedVideos.addAll({videoUrl: videoController});

    return videoController;
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
    log('goTo Next Story');

    /// if all stories of this user has finished
    if (storiesNum - 1 == currentStoryIndex) {
      //
      return;
    }
    log('current index: $currentStoryIndex');

    currentStoryIndex += 1;
    update(['story media']);
    storyIndicatorController.startAnimation();
  }

  void goToPreviousStory() {
    if (currentStory.media.isVideoFileName) {
      final VideoPlayerController video = cashedVideos[currentStory.media]!;
      video.pause();
    }
    log('goTo Previous Story');

    /// if this is the first story for
    if (currentStoryIndex == 0) {
      //
      return;
    }
    log('current index: $currentStoryIndex');

    currentStoryIndex -= 1;
    update(['story media']);
    storyIndicatorController.startAnimation();
  }

  void pauseStory() {
    timeCounter.pause();
    storyIndicatorController.pauseAnimation();
    if (currentStory.media.isVideoFileName) {
      cashedVideos[currentStory.media]?.pause();
    }
  }

  void resumeStory() {
    timeCounter.resume();
    storyIndicatorController.resumeAnimation();
  }

  void onUserNamePressed() {
    Get.toNamed(
      Routes.PROFILE,
      arguments: user,
    );
  }

  void onTapDown() {
    pauseStory();
  }

  void onHoldEnds() {
    resumeStory();
  }
}
