import 'package:instagram_clone/core/services/api_service.dart';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'package:instagram_clone/core/models/post.dart';
import 'package:instagram_clone/core/utils/constants/api.dart';
import 'package:instagram_clone/core/utils/custom_snackbar.dart';
import 'package:instagram_clone/core/utils/helpers.dart';

import '../../../../main.dart';

Future<List<Post>> fetchProfilePostsService(
    String userId, int pageKey, RxInt numOfPages) async {
  try {
    final response = await ApiService.to.get(
      '${Api.PROFILE_POSTS_URL}/$userId',
      queryParameters: {'page': pageKey},
    );
    final data = response.data['data'];
    final metaData = response.data['meta'];


    // (response.data as Map<String, dynamic>).printMap(ignoreValues: ['links','meta']);

    logger.i(response.data);
    // log((response.data as Map<String, dynamic>).printInfo().toString());
    numOfPages.value = metaData['last_page'];

    return _convertDataToPosts(data as List);
  } on DioException catch (e) {


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
