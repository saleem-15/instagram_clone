import 'package:instagram_clone/core/network/api_service.dart';

import 'package:dio/dio.dart';
import 'package:instagram_clone/core/utils/constants/api.dart';
import 'package:instagram_clone/core/utils/custom_snackbar.dart';
import 'package:instagram_clone/core/utils/helpers.dart';

Future<bool> editProfileService({
  String? nickName,
  String? bio,
  String? dateOfBirth,
}) async {

  try {
    await ApiService.to.put(
      Api.EDIT_PROFILE_URL,
      data: {
        if (nickName != null) 'nick_name': nickName,
        'bio': bio,
        if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      },
    );

    return true;
  } on DioException catch (e) {


    CustomSnackBar.showCustomErrorSnackBar(
      message: e.response?.data != null
          ? formatErrorMsg(e.response!.data)
          : 'Failed to update profile. Please try again.',
    );
    return false;
  } catch (e) {

    return false;
  }
}
