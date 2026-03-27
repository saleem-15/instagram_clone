import 'dart:io';

import 'package:dio/dio.dart';

import 'package:instagram_clone/utils/helpers.dart';

import '../../../../utils/constants/api.dart';
import '/utils/custom_snackbar.dart';

Future<void> addPostService(List<File> media) async {
  FormData formData = FormData.fromMap({
    'caption': 'this is caption',
  });

  for (var file in media) {
    formData.files.addAll([
      MapEntry("media[]", await MultipartFile.fromFile(file.path)),
    ]);
  }
  try {
    await dio.post(Api.POST_URL, data: formData);

    CustomSnackBar.showCustomSnackBar(
      message: 'Your post has been shared.',
    );
  } on DioException catch (e) {

    CustomSnackBar.showCustomErrorSnackBar(
      message: formatErrorMsg(e.response!.data),
    );
  }
}
