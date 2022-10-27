import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:instagram_clone/utils/constants/api.dart';
import 'package:instagram_clone/utils/custom_snackbar.dart';
import 'package:instagram_clone/utils/helpers.dart';

/// returnes true if the request was successfull
Future<bool> unFollowService(String followingId) async {
  log('user id $followingId');
  try {
    final response = await dio.delete('${Api.FOLLOWEING_PATH}/$followingId');
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
