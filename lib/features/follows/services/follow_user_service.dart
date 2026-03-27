import 'package:instagram_clone/core/services/api_service.dart';

import 'package:dio/dio.dart';

import 'package:instagram_clone/core/utils/constants/api.dart';
import 'package:instagram_clone/core/utils/custom_snackbar.dart';
import 'package:instagram_clone/core/utils/helpers.dart';

/// follow the user (become a follower to him)
/// returnes true if the request was successfull
Future<bool> followService(String userId) async {

  try {
    await ApiService.to.post(
      Api.FOLLOW_USER_PATH,
      queryParameters: {'user_id': userId},
    );


    return true;
  } on DioException catch (e) {

    CustomSnackBar.showCustomErrorSnackBar(
      message: formatErrorMsg(e.response!.data),
    );
    return false;
  }
}
