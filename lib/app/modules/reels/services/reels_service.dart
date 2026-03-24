import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:instagram_clone/app/models/reel.dart';
import 'package:instagram_clone/main.dart';
import 'package:instagram_clone/utils/constants/api.dart';
import 'package:instagram_clone/utils/custom_snackbar.dart';
import 'package:instagram_clone/utils/helpers.dart';
import 'dart:io';

class ReelsService {
  static Future<List<Reel>> getUserReels({String? userId}) async {
    log('user Id: $userId');
    try {
      final url = userId != null ? '${Api.REELS_URL}/$userId' : Api.REELS_URL;
      final response = await dio.get(url);
      logger.i(response.data);

      List<Reel> reels = [];
      if (response.data["Data"] is List) {
        for (var item in response.data["Data"]) {
          reels.add(Reel.fromMap(item));
        }
      }
      return reels;
    } on DioException catch (e) {
      logger.e(e.response?.data);
      CustomSnackBar.showCustomErrorSnackBar(
        message: formatErrorMsg(e.response?.data ?? 'Error fetching reels'),
      );
      return [];
    }
  }

  static Future<List<Reel>> getReelsFeed({int page = 1}) async {
    try {
      final response = await dio.get(
        Api.REELS_FEED_URL,
        queryParameters: {'page': page},
      );
      logger.i(response.data);

      List<dynamic> data = response.data['data'] ?? [];
      return data.map((reel) => Reel.fromMap(reel)).toList();
    } on DioException catch (e) {
      logger.e(e.response?.data);
      CustomSnackBar.showCustomErrorSnackBar(
        message: formatErrorMsg(e.response?.data ?? 'Error fetching reels'),
      );
      return [];
    }
  }

  static Future<Reel?> getReelById(String id) async {
    try {
      final response = await dio.get('${Api.REELS_URL}/$id');
      logger.i(response.data);
      return Reel.fromMap(response.data);
    } on DioException catch (e) {
      logger.e(e.response?.data);
      CustomSnackBar.showCustomErrorSnackBar(
        message: formatErrorMsg(e.response?.data ?? 'Error fetching reel'),
      );
      return null;
    }
  }

  static Future<Reel?> uploadReel(File videoFile) async {
    try {
      String fileName = videoFile.path.split('/').last;
      FormData formData = FormData.fromMap({
        'reels': await MultipartFile.fromFile(
          videoFile.path,
          filename: fileName,
        ),
      });

      final response = await dio.post(
        Api.REELS_URL,
        data: formData,
      );
      logger.i(response.data);
      CustomSnackBar.showCustomSnackBar(
        title: 'Success',
        message: 'Reel uploaded successfully',
      );
      return Reel.fromMap(response.data);
    } on DioException catch (e) {
      logger.e(e.response?.data);
      CustomSnackBar.showCustomErrorSnackBar(
        message: formatErrorMsg(e.response?.data ?? 'Error uploading reel'),
      );
      return null;
    }
  }

  static Future<bool> deleteReel(String id) async {
    try {
      final response = await dio.delete('${Api.REELS_URL}/$id');
      logger.i(response.data);
      CustomSnackBar.showCustomSnackBar(
        title: 'Success',
        message: 'Reel deleted',
      );
      return true;
    } on DioException catch (e) {
      logger.e(e.response?.data);
      CustomSnackBar.showCustomErrorSnackBar(
        message: formatErrorMsg(e.response?.data ?? 'Error deleting reel'),
      );
      return false;
    }
  }
}
