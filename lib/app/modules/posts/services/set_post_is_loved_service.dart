import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:instagram_clone/main.dart';

import 'package:instagram_clone/utils/constants/api.dart';
import 'package:instagram_clone/utils/custom_snackbar.dart';
import 'package:instagram_clone/utils/helpers.dart';

/// returnes true if request successed
Future<bool> setPostIsLovedService(String postId, bool isLoved) async {
  if (isLoved) {
    return await _markPostAsLovedService(postId);
  } else {
    return await _removeLoveFromPostService(postId);
  }
}

Future<bool> _markPostAsLovedService(String postId) async {
  try {
    final response = await dio.post(
      Api.MARK_POST_AS_FAVORITE_URL,
      queryParameters: {'post_id': postId},
      data: {'post_id': postId},
    );
    logger.i(response.data);

    return true;
  } on DioError catch (e) {
    logger.e(e.response!.data);
    return false;
  }
}

Future<bool> _removeLoveFromPostService(String postId) async {
  try {
    final response = await dio.delete(
      '${Api.MARK_POST_AS_FAVORITE_URL}/$postId',
    );
    log(response.data.toString());

    return true;
  } on DioError catch (e) {
    log(e.response!.data.toString());
    CustomSnackBar.showCustomErrorSnackBar(
      message: formatErrorMsg(e.response!.data),
    );
    return false;
  }
}
