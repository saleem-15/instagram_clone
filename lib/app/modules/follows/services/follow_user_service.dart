import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:instagram_clone/utils/constants/api.dart';
import 'package:instagram_clone/utils/custom_snackbar.dart';
import 'package:instagram_clone/utils/helpers.dart';

/// follow the user (become a follower to him)
/// returnes true if the request was successfull
Future<bool> followService(String userId) async {
  log('user id $userId');
  try {
    final response = await dio.post(
      Api.FOLLOWEING_PATH,
      queryParameters: {'user_id': userId},
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
