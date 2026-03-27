
import 'package:dio/dio.dart';

import '../../../../utils/constants/api.dart';
import '/utils/custom_snackbar.dart';

Future<void> logoutService() async {
  try {
    await dio.post(Api.LOGOUT_URL);

  } on DioException catch (e) {
    CustomSnackBar.showCustomErrorSnackBar(
      title: 'Error',
      message: e.response!.data['Messages'].toString(),
    );
  }
}
