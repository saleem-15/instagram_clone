import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'package:instagram_clone/app/models/post.dart';
import 'package:instagram_clone/app/modules/profile/controllers/user_posts_controller.dart';
import 'package:instagram_clone/utils/constants/api.dart';
import 'package:instagram_clone/utils/custom_snackbar.dart';
import 'package:instagram_clone/utils/helpers.dart';

import '../../../../main.dart';

Future<List<Post>> fetchProfilePostsService(String userId, int pageNum) async {
  try {
    final response = await dio.get(
      '${Api.PROFILE_POSTS_URL}/$userId',
      queryParameters: {'page': pageNum},
    );
    final data = response.data['data'];
    final metaData = response.data['meta'];

    log('fetch Profile Posts Service');
    // (response.data as Map<String, dynamic>).printMap(ignoreValues: ['links','meta']);

    logger.i(response.data);
    // log((response.data as Map<String, dynamic>).printInfo().toString());
    Get.find<UserPostsController>(tag: userId).numOfPages = metaData['last_page'];

    return _convertDataToPosts(data as List);
  } on DioError catch (e) {
    log(e.error.toString());
    log(e.response!.data.toString());
    CustomSnackBar.showCustomErrorSnackBar(
      message: formatErrorMsg(e.response!.data),
    );
    return [];
  }
}

List<Post> _convertDataToPosts(List data) {
  final List<Post> posts = [];
  for (var post in data) {
    posts.add(Post.fromMap(post));
  }

  return posts;
}
