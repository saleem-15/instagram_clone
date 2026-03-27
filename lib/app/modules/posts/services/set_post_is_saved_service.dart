
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
    await dio.post(
      Api.SAVE_POST_URL,
      queryParameters: {'post_id': postId},
    );


    return true;
  } on DioException catch (e) {

    CustomSnackBar.showCustomErrorSnackBar(
      message: formatErrorMsg(e.response!.data),
    );
    return false;
  }
}

Future<bool> _unsavePostService(String postId) async {
  try {
    await dio.delete(
      '${Api.SAVE_POST_URL}/$postId',
    );


    return true;
  } on DioException catch (e) {

    CustomSnackBar.showCustomErrorSnackBar(
      message: formatErrorMsg(e.response!.data),
    );
    return false;
  }
}
