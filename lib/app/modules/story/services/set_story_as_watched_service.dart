import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../utils/constants/api.dart';
import '../../../../utils/custom_snackbar.dart';
import '../../../../utils/helpers.dart';

Future<bool> setStoryAsWathcedService(String storyId) async {
  try {
    final response = await dio.post(
      Api.SET_STORY_AS_WATHCED_URL,
      queryParameters: {'story_id': storyId},
    );
    final data = response.data;
    log(data.toString());

    return true;
  } on DioError catch (e) {
    log(e.response!.toString());

    CustomSnackBar.showCustomErrorSnackBar(
      message: formatErrorMsg(e.message),
    );
    return false;
  }
}
