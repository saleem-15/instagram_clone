import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../utils/constants/api.dart';
import '../../../../utils/custom_snackbar.dart';

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

    CustomSnackBar.showCustomSnackBar(
      message: 'Your story has been shared.',
    );

    return true;
  } on DioException catch (e) {
    log(e.response!.toString());

    CustomSnackBar.showCustomErrorSnackBar(
      message: 'Could not share story. Please try again.',
    );
    return false;
  }
}
