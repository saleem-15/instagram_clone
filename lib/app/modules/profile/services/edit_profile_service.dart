import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:instagram_clone/utils/constants/api.dart';
import 'package:instagram_clone/utils/custom_snackbar.dart';
import 'package:instagram_clone/utils/helpers.dart';

Future<bool> editProfileService({
  String? nickName,
  String? bio,
  String? dateOfBirth,
}) async {
  log('Edit Profile Service: $nickName $bio $dateOfBirth');
  try {
    final response = await dio.put(
      Api.EDIT_PROFILE_URL,
      data: {
        if (nickName != null) 'nick_name': nickName,
        if (bio != null) 'bio': bio,
        if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      },
    );
    log('Edit Profile Service: ${response.data.toString()}');
    return true;
  } on DioException catch (e) {
    log(e.error.toString());
    log(e.response?.data.toString() ?? e.toString());
    CustomSnackBar.showCustomErrorSnackBar(
      message: e.response?.data != null
          ? formatErrorMsg(e.response!.data)
          : 'An error occurred',
    );
    return false;
  } catch (e) {
    log(e.toString());
    return false;
  }
}
