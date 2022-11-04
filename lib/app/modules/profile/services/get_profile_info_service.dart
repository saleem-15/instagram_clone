import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:instagram_clone/app/models/profile.dart';
import 'package:instagram_clone/main.dart';
import 'package:instagram_clone/utils/helpers.dart';

import '../../../../utils/constants/api.dart';
import '/utils/custom_snackbar.dart';

Future<Profile> fetchProfileInfoService(String userId) async {
  try {
    final response = await dio.get('${Api.PROFILE_PATH}/$userId');
    final data = response.data['Data'];
    // log('fetch profile info service: ${response.data}');
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
