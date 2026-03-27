
import 'package:dio/dio.dart';

import 'package:instagram_clone/utils/constants/api.dart';
import 'package:instagram_clone/utils/custom_snackbar.dart';
import 'package:instagram_clone/utils/helpers.dart';

/// returnes true if the request was successfull
Future<bool> unFollowService(String followingId) async {

  try {
    await dio.delete('${Api.FOLLOW_USER_PATH}/$followingId');


    return true;
  } on DioException catch (e) {

    CustomSnackBar.showCustomErrorSnackBar(
      message: formatErrorMsg(e.response!.data),
    );
    return false;
  }
}
