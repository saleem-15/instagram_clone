import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:instagram_clone/app/models/profile.dart';

import 'package:instagram_clone/main.dart';

import '../../../../utils/constants/api.dart';
import '../../../../utils/custom_snackbar.dart';
import '../../../../utils/helpers.dart';

Future<Profile> fetchUserSearchResultService(String userId) async {
  try {
    final response = await dio.get('${Api.PROFILE_PATH}/$userId');
    final data = response.data['Data'];
    logger.i(response.data);

    return Profile.fromMap(data);
  } on DioError catch (e) {
    String? errorMsg;
    if (e.response == null) {
      errorMsg = e.error.toString();
      log(errorMsg);
    } else {
      log(e.response!.data.toString());
    }

    CustomSnackBar.showCustomErrorSnackBar(
      message: formatErrorMsg(errorMsg ?? e.response!.data),
    );
    throw 'some error happend';
  }
}
