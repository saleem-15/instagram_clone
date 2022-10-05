import 'package:get/get.dart';
import 'package:instagram_clone/app/models/post.dart';
import 'package:instagram_clone/app/models/user.dart';

class HomeController extends GetxController {
  late List<Post> posts;

  @override
  void onInit() {
    posts = [
      Post(
        id: 'id',
        user: User(id: '1', name: 'John', image: ''),
        isFavorite: false,
        isSaved: false,
        photos: ['assets/images/post_image.jpg'],
        numOfLikes: 2,
        numOfComments: 10,
      ),
      Post(
        id: 'id',
        user: User(id: '2', name: 'Saleem', image: ''),
        isFavorite: false,
        isSaved: false,
        photos: ['assets/images/post_image.jpg'],
        numOfLikes: 2,
        numOfComments: 10,
      ),
      Post(
        id: 'id',
        user: User(id: '3', name: 'Alexander', image: ''),
        isFavorite: false,
        isSaved: false,
        photos: ['assets/images/post_image.jpg'],
        numOfLikes: 2,
        numOfComments: 10,
      ),
    ];
    super.onInit();
  }
}
