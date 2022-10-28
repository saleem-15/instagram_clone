import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../utils/constants/api.dart';
import '../../../../utils/custom_snackbar.dart';
import '../../../../utils/helpers.dart';

Future<bool> addStoryService(String filePath) async {
  FormData formData = FormData.fromMap({});
  log('file path $filePath');

  formData.files.addAll([
    MapEntry("media", await MultipartFile.fromFile(filePath)),
  ]);

  try {
    final response = await dio.post(
      Api.STORY_URL,
      data: formData,
    );
    final data = response.data;
    log(data.toString());

    return true;
  } on DioError catch (e) {
    log(e.response!.toString());

    CustomSnackBar.showCustomErrorSnackBar(
      message: formatErrorMsg(e.message),
    );
    return false;
  }
}
