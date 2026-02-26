import 'dart:developer';

import 'package:dio/dio.dart';

import '/utils/custom_snackbar.dart';
import '../../../../utils/constants/api.dart';
import '../../../../utils/helpers.dart';
import '../../../storage/my_shared_pref.dart';

/// it returnes if signup process is successful
Future<bool> signupService({
  required String email,
  required String password,
  required String name,
  required String nickName,
  required String dateOfBirth,
  required String phoneNumber,
}) async {
  log('sign up service ********');
  log('name: $name');
  log('email: $email');
  log('phone: $phoneNumber');

  try {
    final response = await dio.post(
      Api.SIGN_UP_URL,
      queryParameters: {
        'email': email,
        'password': password,
        'name': name,
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

    final myId = responseData['user']['user_id'].toString();

    /// store user data
    MySharedPref.storeUserData(
      id: myId,
      name: name,
      nickName: nickName,
      image: null,
      email: email,
      phone: phoneNumber,
      dateOfBirth: dateOfBirth,
    );

    return true;
  } on DioError catch (e) {
    log(e.error.toString());

    CustomSnackBar.showCustomErrorSnackBar(
      duration: const Duration(seconds: 10),
      message: formatErrorMsg(e.response!.data),
    );
  } catch (e) {
    log(e.toString());
  }

  return false;
}
