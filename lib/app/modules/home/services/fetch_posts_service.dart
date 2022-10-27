import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'package:instagram_clone/app/models/post.dart';
import 'package:instagram_clone/app/modules/home/controllers/home_controller.dart';
import 'package:instagram_clone/utils/constants/api.dart';
import 'package:instagram_clone/utils/custom_snackbar.dart';
import 'package:instagram_clone/utils/helpers.dart';

Future<List<Post>> fetchPostsService(int pageNum) async {
  log('HI************************');
  try {
    final response = await dio.get(
      Api.POST_URL,
      queryParameters: {'page': pageNum},
    );
    log('HI************************');
    final data = response.data['data'];
    final metaData = response.data['meta'];

    Get.find<HomeController>().numOfPages = metaData['last_page'];
    log(response.data.toString());

    return _convertDataToPosts(data as List);
  } on DioError catch (e) {
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
