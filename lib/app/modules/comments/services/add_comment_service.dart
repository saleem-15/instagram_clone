import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:instagram_clone/utils/constants/api.dart';
import 'package:instagram_clone/utils/custom_snackbar.dart';
import 'package:instagram_clone/utils/helpers.dart';

/// if comment is posted successfullu it returns true
Future<bool> addCommentService(String comment, String postId) async {
  try {
    final response = await dio.post(
   Api.   COMMNETS_URL,
      queryParameters: {
        'comment': comment,
        'post_id': postId,
      },
    );
    //
    final data = response.data['Data'];
    log(data.toString());

    return true;
  } on DioError catch (e) {
    log(e.response!.data.toString());

    CustomSnackBar.showCustomErrorSnackBar(
      message: formatErrorMsg(e.response!.data),
    );
  }

  return false;
}
