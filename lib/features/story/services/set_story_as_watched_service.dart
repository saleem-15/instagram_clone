import 'package:dio/dio.dart';

import '../../../../main.dart';
import 'package:instagram_clone/core/utils/constants/api.dart';
import 'package:instagram_clone/core/utils/custom_snackbar.dart';
import 'package:instagram_clone/core/utils/helpers.dart';

Future<bool> setStoryAsWathcedService(String storyId) async {
  try {
    final response = await dio.post(
      Api.SET_STORY_AS_WATHCED_URL,
      queryParameters: {'story_id': storyId},
    );
    final data = response.data;
    // log(data.toString());
    logger.i(data);

    return true;
  } on DioException catch (e) {
    // log(e.response!.toString());
    logger.e(e.response);

    CustomSnackBar.showCustomErrorSnackBar(
      message: formatErrorMsg(e.message),
    );
    return false;
  }
}
