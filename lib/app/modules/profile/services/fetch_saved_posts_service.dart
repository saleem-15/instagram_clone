import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'package:instagram_clone/app/models/post.dart';
import 'package:instagram_clone/utils/constants/api.dart';
import 'package:instagram_clone/utils/custom_snackbar.dart';
import 'package:instagram_clone/utils/helpers.dart';

Future<List<Post>> fetchSavedPostsService(int pageKey, RxInt numOfPages) async {
  try {
    final response = await dio.get(
      Api.SAVE_POST_URL,
      queryParameters: {'page': pageKey},
    );
    final data = response.data['data'];
    final metaData = response.data['meta'];

    log('fetch Saved Posts Service');

    numOfPages.value = metaData['last_page'];

    return _convertDataToPosts(data as List);
  } on DioException catch (e) {
    log(e.error.toString());
    log(e.response?.data.toString() ?? e.toString());
    CustomSnackBar.showCustomErrorSnackBar(
      message: formatErrorMsg(e.response?.data ?? {'message': 'Network Error'}),
    );
    return [];
  } catch (e) {
    log(e.toString());
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
