import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:instagram_clone/app/models/user.dart';

import '../../../../utils/constants/api.dart';
import '../../../../utils/custom_snackbar.dart';
import '../../../../utils/helpers.dart';

Future<User> fetchUserService(String userId) async {
  try {
    final response = await dio.get('${Api.USER_URL}/$userId');
    final data = response.data['data'];
    log(data.toString());

  return  User.fromMap(data);

  } on DioError catch (e) {
    log(e.response!.toString());

    CustomSnackBar.showCustomErrorSnackBar(
      message: formatErrorMsg(e.message),
    );
    rethrow;
  }
}
