import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/app/models/user.dart';
import 'package:instagram_clone/app/routes/app_pages.dart';

import '../services/add_story_service.dart';
import '../services/fetch_stories_service.dart';
import '../views/stories_view.dart';
import '../views/story_tile.dart';

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
    isLoading(false);
    super.onReady();
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
    /// if this user is the last user in the stories list
    if (currentUserIndex == stories.length - 1) {
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
