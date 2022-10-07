import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../utils/constants/api.dart';
import '/utils/custom_snackbar.dart';
import '../../../../utils/helpers.dart';
import '../../../storage/my_shared_pref.dart';

/// at the first index it returns the id of the user ,
/// ath the second index it returnes if signup process is successful
/// if signup process is Not successful then userId is Null
Future<List> signupService(String email, String password, String fullName, String nickName,
    String dateOfBirth, String phoneNumber) async {
  String? userId;

  log('sign up service ********');
  log('email: $email********');
  log('phone: $phoneNumber********');
  try {
    final response = await dio.post(
      SIGN_UP_URL,
      queryParameters: {
        'email': email,
        'password': password,
        'name': fullName,
        'nick_name': nickName,
        'date_of_birth': dateOfBirth,
        'phone': phoneNumber,
      },
    );
    log(response.toString());
    log(response.data.toString());

    final responseData = response.data['Data'];

    /// store the token in shared pref
    final token = responseData['access_token'].toString();
    MySharedPref.setUserToken(token);

    userId = responseData['id'].toString();

    return [userId, true];
  } on DioError catch (e) {
    log(e.error.toString());
    CustomSnackBar.showCustomErrorSnackBar(
      title: 'Failed',
      message: formatErrorMsg(e.response!.data),
    );
  }

  return [userId, false];
}
