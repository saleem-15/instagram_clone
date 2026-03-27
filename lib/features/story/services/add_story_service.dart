
import 'package:dio/dio.dart';

import 'package:instagram_clone/core/utils/constants/api.dart';
import 'package:instagram_clone/core/utils/custom_snackbar.dart';

Future<bool> addStoryService(String filePath) async {
  FormData formData = FormData.fromMap({});


  formData.files.addAll([
    MapEntry("media", await MultipartFile.fromFile(filePath)),
  ]);

  try {
    await dio.post(
      Api.STORY_URL,
      data: formData,
    );


    CustomSnackBar.showCustomSnackBar(
      message: 'Your story has been shared.',
    );

    return true;
  } on DioException catch (_) {


    CustomSnackBar.showCustomErrorSnackBar(
      message: 'Could not share story. Please try again.',
    );
    return false;
  }
}
