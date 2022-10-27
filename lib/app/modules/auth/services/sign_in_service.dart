import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/app/models/user.dart';

import 'package:instagram_clone/utils/custom_snackbar.dart';
import 'package:instagram_clone/utils/helpers.dart';

import '../../../../utils/constants/api.dart';
import '../../../storage/my_shared_pref.dart';

/// it returnes true if signup process is successful
Future<bool> signInService(String firstField, String password) async {
  try {
    log('sign in service');
    final response = await dio.post(
      Api.SIGN_IN_URL,
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

    final user = User.fromMap(data['user']);

    /// store user data
    MySharedPref.storeUserData(
      id: user.id,
      name: user.userName,
      nickName: user.nickName,
      image: user.image,
      email: 'no email',
      phone: 'no phoneNumber',
      dateOfBirth: 'no dateOfBirth',
    );

    return true;
  } on DioError catch (e) {
    log(e.error.toString());
    log(e.response!.data.toString());

    CustomSnackBar.showCustomErrorSnackBar(
      title: 'Failed',
      message: formatErrorMsg(e.response!.data),
    );
    return false;
  }
}
