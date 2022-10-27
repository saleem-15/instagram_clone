import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:instagram_clone/app/models/profile.dart';
import 'package:instagram_clone/utils/helpers.dart';

import '../../../../utils/constants/api.dart';
import '/utils/custom_snackbar.dart';

Future<Profile> fetchProfileInfoService(String userId) async {
  try {
    log('fetch profile info service');
    final response = await dio.get('${Api.PROFILE_PATH}/$userId');
    final data = response.data['Data'];
    // log(response.data.toString());

    return Profile.fromMap(data);
  } on DioError catch (e) {
    if (e.response == null) {
      log(e.error.toString());
    } else {
      log(e.response!.data.toString());
    }
    CustomSnackBar.showCustomErrorSnackBar(
      message: formatErrorMsg(e.response!.data),
    );
    throw 'some error happend';
  }
}
