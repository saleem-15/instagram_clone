import 'package:instagram_clone/app/models/post.dart';

import '../../../models/user.dart';

Future<List<Post>> fetchPostsService(int pageNum) async {
  return [
    Post(
      id: 'id',
      user: User(id: 'd', name: 'sal', image: ''),
      isFavorite: false,
      isSaved: false,
      numOfLikes: 10,
      numOfComments: 10,
      postContents: [
        'https://www.fluttercampus.com/video.mp4',
        'https://static-cse.canva.com/blob/825910/ComposeStunningImages6.jpg',
      ],
    ),
    Post(
      id: 'id',
      user: User(id: 'd', name: 'moh', image: ''),
      isFavorite: false,
      isSaved: false,
      numOfLikes: 10,
      numOfComments: 10,
      postContents: [
        'https://mymodernmet.com/wp/wp-content/uploads/2021/12/kristina-makeeva-eoy-photo-1.jpeg',
        'https://www.fluttercampus.com/video.mp4'
        
      ],
    ),
    Post(
      id: 'id',
      user: User(id: 'd', name: 'ali', image: ''),
      isFavorite: false,
      isSaved: false,
      numOfLikes: 10,
      numOfComments: 10,
      postContents: [
        'https://www.shootproof.com/blog/wp-content/uploads/2025/07/1-1-ratio_Morgan-Caddell-2191-scaled.jpg',
      ]
    ),
  ];
  // try {
  //   final response = await dio.get(
  //     FOLLOWERS_PATH,
  //     queryParameters: {'page': pageNum},
  //   );
  //   final data = response.data['data'];
  //   log(response.data.toString());

  //   return _convertDataToPosts(data as List);
  // } on DioError catch (e) {
  //   log(e.response!.data.toString());
  //   CustomSnackBar.showCustomErrorSnackBar(
  //     message: e.response!.data['Messages'].toString(),
  //   );
  //   return [];
  // }
}

List<Post> _convertDataToPosts(List data) {
  final List<Post> posts = [];
  for (var post in data) {
    posts.add(Post.fromMap(post));
  }

  return posts;
}
