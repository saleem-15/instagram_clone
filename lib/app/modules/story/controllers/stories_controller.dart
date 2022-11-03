import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/app/models/user.dart';
import 'package:instagram_clone/app/routes/app_pages.dart';

import '../services/add_story_service.dart';
import '../services/fetch_stories_service.dart';

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
    Get.toNamed(
      Routes.STORY,
      parameters: {
        'pressed_user_index': '$userIndex',
      },
    );
  }

  void goToNextUserStories() {
    carouselSliderController.nextPage();
  }

  void goToPreviuosUserStories() {
    carouselSliderController.previousPage();
  }
}
