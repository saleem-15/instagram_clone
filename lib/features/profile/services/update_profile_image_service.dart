import 'package:instagram_clone/core/services/api_service.dart';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:instagram_clone/core/utils/custom_snackbar.dart';
import 'package:instagram_clone/core/utils/helpers.dart';

Future<bool> updateProfileImageService(File imageFile) async {
  try {
    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        imageFile.path,
        filename: imageFile.path.split('/').last,
      ),
    });

    final response = await ApiService.to.post(
      '/auth/user/update/image',
      data: formData,
    );

    if (response.statusCode == 200) {

      return true;
    }
    return false;
  } on DioException catch (e) {


    CustomSnackBar.showCustomErrorSnackBar(
      message: e.response?.data != null
          ? formatErrorMsg(e.response!.data)
          : 'Failed to upload profile photo. Please try again.',
    );
    return false;
  } catch (e) {

    return false;
  }
}
