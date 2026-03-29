import 'package:instagram_clone/core/network/api_service.dart';

import 'package:dio/dio.dart';
import 'package:instagram_clone/core/models/profile.dart';

import 'package:instagram_clone/main.dart';

import 'package:instagram_clone/core/utils/constants/api.dart';
import 'package:instagram_clone/core/utils/custom_snackbar.dart';
import 'package:instagram_clone/core/utils/helpers.dart';

Future<Profile> fetchUserSearchResultService(String userId) async {
  try {
    final response = await ApiService.to.get('${Api.PROFILE_PATH}/$userId');
    final data = response.data['Data'];
    logger.i(response.data);

    return Profile.fromMap(data);
  } on DioException catch (e) {
    String? errorMsg;
    if (e.response == null) {
      errorMsg = e.error.toString();
    } else {}

    CustomSnackBar.showCustomErrorSnackBar(
      message: formatErrorMsg(errorMsg ?? e.response!.data),
    );
    throw 'some error happend';
  }
}
