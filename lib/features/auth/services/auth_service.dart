import 'package:instagram_clone/core/services/api_service.dart';
import 'package:instagram_clone/core/services/storage_service.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/models/user.dart';
import 'package:instagram_clone/core/utils/constants/api.dart';
import 'package:instagram_clone/core/utils/custom_snackbar.dart';
import 'package:instagram_clone/core/utils/helpers.dart';
import 'package:instagram_clone/core/network/api_exception.dart';

/// [AuthService] handles all authentication-related requests such as sign in, sign up, and logout.
class AuthService extends GetxService {
  static AuthService get to => Get.find<AuthService>();

  /// Sign in a user with their [firstField] (email, phone, or username) and [password].
  /// Returns `true` if successful, `false` otherwise.
  Future<bool> signIn(String firstField, String password) async {
    try {
      final response = await ApiService.to.post(
        Api.SIGN_IN_URL,
        queryParameters: {
          if (GetUtils.isEmail(firstField)) 'email': firstField,
          if (GetUtils.isPhoneNumber(firstField)) 'phone': firstField,
          if (!GetUtils.isEmail(firstField) &&
              !GetUtils.isPhoneNumber(firstField))
            'username': firstField,
          'password': password,
        },
      );

      final data = response.data['Data'];

      // Store the token in local storage
      final token = data['access_token'].toString();
      Get.find<StorageService>().setUserToken(token);

      final user = User.fromMap(data['user']);

      // Store user metadata
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
    } on ApiException catch (e) {
      CustomSnackBar.showCustomErrorSnackBar(
        message: formatErrorMsg(e.originalError?.response?.data),
      );
      return false;
    }
  }

  /// Sign up a new user with the provided details.
  /// Returns `true` if successful, `false` otherwise.
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

      // Store the token in local storage
      final token = responseData['access_token'].toString();
      Get.find<StorageService>().setUserToken(token);

      final myId = responseData['user']['user_id'].toString();

      // Store user metadata
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
    } on ApiException catch (e) {
      CustomSnackBar.showCustomErrorSnackBar(
        message: formatErrorMsg(e.originalError?.response?.data),
      );
      return false;
    }
  }

  /// Logs out the current user.
  Future<void> logout() async {
    try {
      await ApiService.to.post(Api.LOGOUT_URL);
    } on ApiException catch (e) {
      CustomSnackBar.showCustomErrorSnackBar(
        title: 'Error',
        message:
            e.originalError?.response?.data['Messages']?.toString() ?? 'Logout failed',
      );
    }
  }

  /// Sends a code to the user's [email] for password recovery.
  Future<bool> forgetPassword(String email) async {
    try {
      await ApiService.to.post(
        Api.FORGET_PASSWORD_URL,
        queryParameters: {
          'email': email,
        },
      );
      return true;
    } on ApiException catch (e) {
      CustomSnackBar.showCustomErrorSnackBar(
        title: 'Failed',
        message: formatErrorMsg(e.originalError?.response?.data),
      );
      return false;
    }
  }

  /// Verifies the [code] sent to the user's [email].
  Future<bool> verifyCode({required String email, required String code}) async {
    try {
      await ApiService.to.post(
        Api.CHECK_EMAIL_CODE_URL,
        queryParameters: {
          'email': email,
          'code': code,
        },
      );
      return true;
    } on ApiException catch (e) {
      CustomSnackBar.showCustomErrorSnackBar(
        message: formatErrorMsg(e.originalError?.response?.data),
      );
      return false;
    }
  }

  /// Resets the user's password to [newPassword] using the [code].
  Future<bool> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    try {
      await ApiService.to.post(
        Api.RESET_PASSWORD_URL,
        queryParameters: {
          'email': email,
          'code': code,
          'password': newPassword,
        },
      );
      return true;
    } on ApiException catch (e) {
      CustomSnackBar.showCustomErrorSnackBar(
        message: formatErrorMsg(e.originalError?.response?.data),
      );
      return false;
    }
  }
}
