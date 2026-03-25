import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:instagram_clone/utils/constants/api.dart';
import 'package:instagram_clone/utils/custom_snackbar.dart';
import 'package:instagram_clone/utils/helpers.dart';

Future<bool> updateProfileImageService(File imageFile) async {
  try {
    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        imageFile.path,
        filename: imageFile.path.split('/').last,
      ),
    });

    final response = await dio.post(
      '/auth/user/update/image',
      data: formData,
    );

    if (response.statusCode == 200) {
      log('Profile image updated successfully');
      return true;
    }
    return false;
  } on DioException catch (e) {
    log(e.error.toString());
    log(e.response?.data.toString() ?? e.toString());
    CustomSnackBar.showCustomErrorSnackBar(
      message: e.response?.data != null
          ? formatErrorMsg(e.response!.data)
          : 'Failed to upload profile photo. Please try again.',
    );
    return false;
  } catch (e) {
    log('Error: $e');
    return false;
  }
}
