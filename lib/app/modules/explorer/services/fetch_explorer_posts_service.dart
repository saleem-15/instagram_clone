import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/app/models/post.dart';
import 'package:instagram_clone/app/modules/profile/controllers/profile_controller.dart';
import 'package:instagram_clone/utils/constants/api.dart';
import 'package:instagram_clone/utils/custom_snackbar.dart';
import 'package:instagram_clone/utils/helpers.dart';

Future<List<Post>> fetchExplorerPostsService(int pageNum) async {
  try {
    log('before request ************************');
    final response = await dio.get(
      POST_URL,
      queryParameters: {'page': pageNum},
    );
    log('after response HI************************');
    final data = response.data['data'];
    final metaData = response.data['meta'];

    Get.find<ProfileController>().numOfPages = metaData['last_page'];
    Get.find<ProfileController>().postNum = metaData['total'];
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
