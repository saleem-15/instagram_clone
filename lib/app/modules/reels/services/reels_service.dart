import 'package:dio/dio.dart';
import 'package:instagram_clone/app/models/reel.dart';
import 'package:instagram_clone/main.dart';
import 'package:instagram_clone/utils/constants/api.dart';
import 'package:instagram_clone/utils/custom_snackbar.dart';
import 'package:instagram_clone/utils/helpers.dart';
import 'dart:io';

class ReelsService {
  static Future<List<Reel>> getUserReels({String? userId}) async {
    try {
      final url =
          userId != null ? '${Api.REELS_USER_URL}/$userId' : Api.REELS_URL;
      final response = await dio.get(url);
      logger.i(response.data);

      List<Reel> reels = [];
      dynamic rawData = response.data;

      // Handle cases where the response is a Map with 'data' or 'Data' keys,
      // or if the response itself is a List.
      if (rawData is Map) {
        final nestedData =
            rawData['data'] ?? rawData['Data'] ?? rawData['reels'];
        if (nestedData is List) {
          for (var item in nestedData) {
            reels.add(Reel.fromMap(item));
          }
        } else if (rawData.containsKey('id')) {
          // Case where it returned a single reel instead of a list
          reels.add(Reel.fromMap(rawData as Map<String, dynamic>));
        }
      } else if (rawData is List) {
        for (var item in rawData) {
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

      dynamic rawData = response.data;
      List<dynamic> dataList = [];
      if (rawData is Map) {
        dataList = rawData['data'] ?? rawData['Data'] ?? rawData['reels'] ?? [];
      } else if (rawData is List) {
        dataList = rawData;
      }
      return dataList.map((reel) => Reel.fromMap(reel)).toList();
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
        message: 'Your reel has been shared.',
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
