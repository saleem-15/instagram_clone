import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:instagram_clone/utils/constants/api.dart';
import 'package:instagram_clone/utils/custom_snackbar.dart';

Future<bool> setPostIsLovedService(String postId, bool isLoved) async {
  try {
    final response = await dio.post(
      '$POST_URL/$postId',
      queryParameters: {'isLoved': isLoved},
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
