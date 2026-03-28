import 'package:instagram_clone/features/story/services/add_story_service.dart';
import 'package:instagram_clone/features/story/services/fetch_stories_service.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/core/models/user.dart';
import 'package:instagram_clone/routes/app_pages.dart';

import '../views/stories_view.dart';
import '../views/widgets/story_tile.dart';

/// this is the controller of the stories list that appears in the home page
class StoriesController extends GetxController {
  final RxBool isLoading = true.obs;

  /// its the  users that have stories in the last 24 hours
  late List<User> stories;

  final carouselSliderController = CarouselSliderController();

  /// its the number of users that have stories in the last 24 hours
  int get numOfStories => stories.length;

  @override
  Future<void> onReady() async {
    stories = await fetchStoriesService();

    sortStoriedBasedOnWatchedStatus();

    isLoading(false);
    super.onReady();
  }

  void sortStoriedBasedOnWatchedStatus() {
    // Sort stories so unwatched stories appear first
    stories.sort((a, b) {
      if (a.isHasNewStory && !b.isHasNewStory) return -1;
      if (!a.isHasNewStory && b.isHasNewStory) return 1;
      return 0; // Maintain original order for users in the same group
    });
  }

  void onMyStoryAvatarPressed() async {
    addNewStory();
  }

  Future<void> addNewStory() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }

    addStoryService(image.path);
  }

  void onStoryTilePressed(int userIndex) {
    goToUserStories(stories[userIndex], userIndex: userIndex);
  }

  /// userIndex must be provided ((only if)) the story was from clicking
  /// the [StoryTile] from the [StoriesView]
  void goToUserStories(User user, {int? userIndex}) {
    Get.toNamed(
      Routes.STORY,
      arguments: user,
      parameters: {
        if (userIndex != null) 'pressed_user_index': '$userIndex',
      },
    );
  }

  void goToNextUserStories(int currentUserIndex) {
    bool isSingleUserView = Get.parameters['pressed_user_index'] == null;

    /// if this user is the last user in the stories list
    /// or if it was a single story view (pressedUserIndex == null)
    if (isSingleUserView || currentUserIndex == stories.length - 1) {
      Get.back();
      return;
    }
    carouselSliderController.nextPage();
  }

  void goToPreviuosUserStories() {
    carouselSliderController.previousPage();
  }

  void updateStoryTile(String userId) {
    update(['story tile $userId']);
  }
}
