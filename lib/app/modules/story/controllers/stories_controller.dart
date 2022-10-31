import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/app/models/user.dart';
import 'package:instagram_clone/app/routes/app_pages.dart';

import '../services/add_story_service.dart';
import '../services/fetch_stories_service.dart';


class StoriesController extends GetxController {
  final RxBool isLoading = true.obs;
  late List<User> stories;
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

  void onStoryTilePressed(User user) {
    user.printInfo();
    Get.toNamed(
      Routes.STORY,
      arguments: user,
    );
  }
}



/*
[
    User(
      id: '0',
      userName: 'Ahmed',
      nickName: 'nick name',
      image: 'assets/images/james.jpg',
    ),
    User(
      id: '1',
      userName: 'james',
      nickName: 'nick name',
      image: 'assets/images/james.jpg',
    ),
    User(
      id: '2',
      userName: 'john',
      nickName: 'nick name',
      image: 'assets/images/john.jpg',
    ),
    User(
      id: '3',
      userName: 'greg',
      nickName: 'nick name',
      image: 'assets/images/greg.jpg',
    ),
    User(
      id: '4',
      userName: 'Olivia',
      nickName: 'nick name',
      image: 'assets/images/olivia.jpg',
    ),
    User(
      id: '5',
      userName: 'Sam',
      nickName: 'nick name',
      image: 'assets/images/sam.jpg',
    ),
    User(
      id: '6',
      userName: 'Sophia',
      nickName: 'nick name',
      image: 'assets/images/sophia.jpg',
    ),
    User(
      id: '7',
      userName: 'Steven',
      nickName: 'nick name',
      image: 'assets/images/steven.jpg',
    ),
  ];

*/