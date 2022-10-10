import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:instagram_clone/app/models/post.dart';
import 'package:instagram_clone/app/models/user.dart';

import '../services/fetch_posts_service.dart';

class HomeController extends GetxController {
  late List<Post> posts;

  int numOfPages = 1;
  int setNumOfPages = 1;
  int totalNumOfProducts = 1;

  final pagingController = PagingController<int, Post>(
    firstPageKey: 1,
  );

  final searchTextController = TextEditingController();

  @override
  void onReady() {
    super.onReady();
    pagingController.addPageRequestListener((pageKey) async {
      fetchPosts(pageKey);
    });
  }

  Future<void> fetchPosts(int pageKey) async {
    try {
      final followersNewPage = await fetchPostsService(pageKey);

      final isLastPage = numOfPages == pageKey;

      if (isLastPage) {
        pagingController.appendLastPage(followersNewPage);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(followersNewPage, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
      rethrow;
    }
  }

  @override
  void onInit() {
    posts = [
      Post(
        id: '1',
        user: User(id: 'd1', name: 'sal', image: ''),
        isFavorite: false,
        isSaved: false,
        numOfLikes: 10,
        numOfComments: 10,
        postContents: [
          'https://www.fluttercampus.com/video.mp4',
          'https://static-cse.canva.com/blob/825910/ComposeStunningImages6.jpg',
          'https://www.rookiemag.com/wp-content/uploads/2018/04/1523234869westfall_wallpaper2-01-280x210.png'
        ],
      ),
      Post(
        id: '2',
        user: User(id: 'd2', name: 'moh', image: ''),
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
          id: '3',
          user: User(id: 'd3', name: 'ali', image: ''),
          isFavorite: false,
          isSaved: false,
          numOfLikes: 10,
          numOfComments: 10,
          postContents: [
            'https://www.shootproof.com/blog/wp-content/uploads/2025/07/1-1-ratio_Morgan-Caddell-2191-scaled.jpg',
          ]),
    ];
    super.onInit();
  }
}
