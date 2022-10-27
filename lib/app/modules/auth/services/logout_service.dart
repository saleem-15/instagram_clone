import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../utils/constants/api.dart';
import '/utils/custom_snackbar.dart';

Future<void> logoutService() async {
  try {
    final response = await dio.post(Api.LOGOUT_URL);
    log(response.data.toString());
  } on DioError catch (e) {
    CustomSnackBar.showCustomErrorSnackBar(
      title: 'Error',
      message: e.response!.data['Messages'].toString(),
    );
  }
}
