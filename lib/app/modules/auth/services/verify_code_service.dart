import 'package:dio/dio.dart';
import 'package:instagram_clone/main.dart';

import 'package:instagram_clone/utils/custom_snackbar.dart';
import 'package:instagram_clone/utils/helpers.dart';

import '../../../../utils/constants/api.dart';

/// it returnes true if the request  is successful
Future<bool> verifyCodeService({required String email, required String code}) async {
  try {
    final response = await dio.post(
      Api.CHECK_EMAIL_CODE_URL,
      queryParameters: {
        'email': email,
        'code': code,
      },
    );

    logger.i(response.data);

    return true;
  } on DioError catch (e) {
    logger.e(e.response);

    CustomSnackBar.showCustomErrorSnackBar(
      message: formatErrorMsg(e.response!.data),
    );
    return false;
  }
}
