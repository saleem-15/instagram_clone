import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/utils/custom_snackbar.dart';
import 'package:instagram_clone/utils/helpers.dart';

import '../../../../utils/constants/api.dart';
import '../../../storage/my_shared_pref.dart';

/// it returnes true if signup process is successful
Future<bool> signInService(String firstField, String password) async {
  try {
    final response = await dio.post(
      SIGN_IN_URL,
      queryParameters: {
        if (GetUtils.isEmail(firstField)) 'email': firstField,
        if (GetUtils.isPhoneNumber(firstField)) 'phone': firstField,
        if (!GetUtils.isEmail(firstField) && !GetUtils.isPhoneNumber(firstField)) 'username': firstField,
        'password': password,
      },
    );
    //
    final data = response.data['Data'];
    log(data.toString());

    /// store the token in shared pref
    final token = data['access_token'].toString();
    MySharedPref.setUserToken(token);

    return true;
  } on DioError catch (e) {
    log(e.error.toString());

    CustomSnackBar.showCustomErrorSnackBar(
      title: 'Failed',
      message: formatErrorMsg(e.response!.data),
    );
  }

  return false;
}
