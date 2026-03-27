import 'package:instagram_clone/core/services/api_service.dart';
import 'package:instagram_clone/core/services/storage_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/models/user.dart';
import 'package:instagram_clone/core/utils/constants/api.dart';
import 'package:instagram_clone/core/utils/custom_snackbar.dart';
import 'package:instagram_clone/core/utils/helpers.dart';
import 'package:instagram_clone/main.dart'; // for logger

class AuthService extends GetxService {
  static AuthService get to => Get.find<AuthService>();

  Future<bool> signIn(String firstField, String password) async {
    try {
      final response = await ApiService.to.post(
        Api.SIGN_IN_URL,
        queryParameters: {
          if (GetUtils.isEmail(firstField)) 'email': firstField,
          if (GetUtils.isPhoneNumber(firstField)) 'phone': firstField,
          if (!GetUtils.isEmail(firstField) && !GetUtils.isPhoneNumber(firstField))
            'username': firstField,
          'password': password,
        },
      );
      
      final data = response.data['Data'];

      /// store the token in shared pref
      final token = data['access_token'].toString();
      Get.find<StorageService>().setUserToken(token);

      final user = User.fromMap(data['user']);

      /// store user data
      Get.find<StorageService>().storeUserData(
        id: user.id,
        name: user.userName,
        nickName: user.nickName,
        image: user.image,
        email: 'no email',
        phone: 'no phoneNumber',
        dateOfBirth: 'no dateOfBirth',
      );

      return true;
    } on DioException catch (e) {
      CustomSnackBar.showCustomErrorSnackBar(
        message: formatErrorMsg(e.response?.data),
      );
      return false;
    }
  }

  Future<bool> signUp({
    required String email,
    required String password,
    required String name,
    required String nickName,
    required String dateOfBirth,
    required String phoneNumber,
  }) async {
    try {
      final response = await ApiService.to.post(
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
      Get.find<StorageService>().setUserToken(token);

      final myId = responseData['user']['user_id'].toString();

      /// store user data
      Get.find<StorageService>().storeUserData(
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

  Future<void> logout() async {
    try {
      await ApiService.to.post(Api.LOGOUT_URL);
    } on DioException catch (e) {
      CustomSnackBar.showCustomErrorSnackBar(
        title: 'Error',
        message: e.response?.data['Messages']?.toString() ?? 'Logout failed',
      );
    }
  }

  Future<bool> forgetPassword(String email) async {
    try {
      final response = await ApiService.to.post(
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
        message: formatErrorMsg(e.response?.data),
      );
      return false;
    }
  }

  Future<bool> verifyCode({required String email, required String code}) async {
    try {
      final response = await ApiService.to.post(
        Api.CHECK_EMAIL_CODE_URL,
        queryParameters: {
          'email': email,
          'code': code,
        },
      );

      logger.i(response.data);

      return true;
    } on DioException catch (e) {
      logger.e(e.response);

      CustomSnackBar.showCustomErrorSnackBar(
        message: formatErrorMsg(e.response?.data),
      );
      return false;
    }
  }

  Future<bool> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    try {
      final response = await ApiService.to.post(
        Api.RESET_PASSWORD_URL,
        queryParameters: {
          'email': email,
          'code': code,
          'password': newPassword,
        },
      );

      logger.i(response.data);

      return true;
    } on DioException catch (e) {
      logger.e(e.response);

      CustomSnackBar.showCustomErrorSnackBar(
        message: formatErrorMsg(e.response?.data),
      );
      return false;
    }
  }
}
