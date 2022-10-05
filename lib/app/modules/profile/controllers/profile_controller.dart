import 'package:get/get.dart';
import 'package:instagram_clone/app/routes/app_pages.dart';

class ProfileController extends GetxController {
  final name = 'Saleem Mahdi';
  final username = 'saleemmahdi10';

  int postNum = 0;
  int followersNum = 12;
  int followingNum = 33;

  void goToFollowers() {
    Get.toNamed(Routes.FOLLOWERS);
  }

  void goToFollowing() {
    Get.toNamed(Routes.FOLLOWERS);
  }
}