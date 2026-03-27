
import 'package:dio/dio.dart';

import 'package:instagram_clone/core/utils/custom_snackbar.dart';
import 'package:instagram_clone/core/utils/constants/api.dart';
import 'package:instagram_clone/core/utils/helpers.dart';
import 'package:instagram_clone/core/services/storage_service.dart';

/// it returnes if signup process is successful
Future<bool> signupService({
  required String email,
  required String password,
  required String name,
  required String nickName,
  required String dateOfBirth,
  required String phoneNumber,
}) async {





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



    final responseData = response.data['Data'];

    /// store the token in shared pref
    final token = responseData['access_token'].toString();
    StorageService.setUserToken(token);

    final myId = responseData['user']['user_id'].toString();

    /// store user data
    StorageService.storeUserData(
      id: myId,
      name: name,
      nickName: nickName,
      image: null,
      email: email,
      phone: phoneNumber,
      dateOfBirth: dateOfBirth,
    );

    return true;
  } on DioException catch (e) {


    CustomSnackBar.showCustomErrorSnackBar(
      message: formatErrorMsg(e.response?.data),
    );
  } catch (_) {
    // Suppress general errors for now; DioException is handled above
  }

  return false;
}
