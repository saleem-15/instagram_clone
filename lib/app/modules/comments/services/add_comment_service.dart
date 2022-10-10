import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:instagram_clone/utils/constants/api.dart';
import 'package:instagram_clone/utils/custom_snackbar.dart';
import 'package:instagram_clone/utils/helpers.dart';

/// if comment is posted successfullu it returns true
Future<bool> addCommentService(String comment, String postId) async {
  try {
    final response = await dio.post(
      POST_URL,
      queryParameters: {
        'comment': comment,
      },
    );
    //
    final data = response.data['Data'];
    log(data.toString());

    return true;
  } on DioError catch (e) {
    log(e.response!.data.toString());

    CustomSnackBar.showCustomErrorSnackBar(
      title: 'Failed',
      message: formatErrorMsg(e.response!.data),
    );
  }

  return false;
}
