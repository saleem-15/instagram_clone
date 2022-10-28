import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:instagram_clone/utils/constants/api.dart';
import 'package:instagram_clone/utils/custom_snackbar.dart';
import 'package:instagram_clone/utils/helpers.dart';


/// returnes true if request successed
Future<bool> setPostIsSavedService(String postId, bool isSave) async {
  if (isSave) {
    return await _savePostService(postId);
  } else {
    return await _unsavePostService(postId);
  }
}

Future<bool> _savePostService(String postId) async {
  try {
    final response = await dio.post(
      Api.SAVE_POST_URL,
      queryParameters: {'post_id': postId},
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

Future<bool> _unsavePostService(String postId) async {
  try {
    final response = await dio.delete(
      '${Api.SAVE_POST_URL}/$postId',
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
