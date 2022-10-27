import 'dart:developer';
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
    final response = await dio.post(Api.POST_URL, data: formData);
    final data = response.data['Data'];
    log(response.data.toString());
  } on DioError catch (e) {
    log(e.response!.data.toString());
    CustomSnackBar.showCustomErrorSnackBar(
      message: formatErrorMsg(e.response!.data),
    );
  }
}
