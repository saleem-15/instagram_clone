import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:instagram_clone/utils/constants/api.dart';
import 'package:instagram_clone/utils/custom_snackbar.dart';

Future<bool> setPostIsSavedService(String postId, bool isSaved) async {
  try {
    final response = await dio.post(
      '${Api.POST_URL}/$postId',
      queryParameters: {'isSaved': isSaved},
    );
    final data = response.data['data'];
    log(response.data.toString());

    return true;
  } on DioError catch (e) {
    log(e.response!.data.toString());
    CustomSnackBar.showCustomErrorSnackBar(
      message: e.response!.data['Messages'].toString(),
    );
    return false;
  }
}
