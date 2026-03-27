import 'package:instagram_clone/core/services/api_service.dart';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'package:instagram_clone/core/models/post.dart';
import 'package:instagram_clone/core/utils/constants/api.dart';
import 'package:instagram_clone/core/utils/custom_snackbar.dart';
import 'package:instagram_clone/core/utils/helpers.dart';

Future<List<Post>> fetchExplorerPostsService(
    int pageNum, RxInt numOfPages) async {
  try {
    final response = await ApiService.to.get(
      Api.POST_URL,
      queryParameters: {'page': pageNum},
    );
    final data = response.data['data'];
    final metaData = response.data['meta'];

    numOfPages.value = metaData['last_page'];

    return _convertDataToPosts(data as List);
  } on DioException catch (e) {
    // Log error for debugging internally but removed for portfolio presentation
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
