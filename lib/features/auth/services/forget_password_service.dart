import 'package:dio/dio.dart';
import 'package:instagram_clone/main.dart';

import 'package:instagram_clone/core/utils/custom_snackbar.dart';
import 'package:instagram_clone/core/utils/helpers.dart';

import 'package:instagram_clone/core/utils/constants/api.dart';

/// it returnes true if the request  is successful
Future<bool> forgetPasswordService(String email) async {
  try {
    final response = await dio.post(
      Api.FORGET_PASSWORD_URL,
      queryParameters: {
        'email': email,
      },
    );

    logger.i(response.data);

    return true;
  } on DioException catch (e) {
    logger.e(e.response);

    CustomSnackBar.showCustomErrorSnackBar(
      title: 'Failed',
      message: formatErrorMsg(e.response!.data),
    );
    return false;
  }
}
