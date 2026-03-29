import 'package:instagram_clone/core/network/api_service.dart';
import 'package:dio/dio.dart';
import 'package:instagram_clone/core/models/reel.dart';
import 'package:instagram_clone/core/utils/constants/api.dart';
import 'package:instagram_clone/core/utils/custom_snackbar.dart';
import 'package:instagram_clone/core/utils/helpers.dart';
import 'package:instagram_clone/core/network/api_exception.dart';
import 'dart:io';

/// Fetches reels with pagination.
/// Returns a record containing the list of [Reel]s and the [lastPage] number.
Future<({List<Reel> reels, int lastPage})> fetchReelsService(
    int pageKey) async {
  try {
    final response = await ApiService.to.get(
      Api.REELS_URL,
      queryParameters: {'page': pageKey},
    );

    final dataList = response.data['data'] as List;
    final lastPage = response.data['meta']['last_page'] as int;

    return (
      reels: _convertDataToReels(dataList),
      lastPage: lastPage,
    );
  } on ApiException catch (e) {
    CustomSnackBar.showCustomErrorSnackBar(
      message: formatErrorMsg(e.originalError?.response?.data),
    );
    return (reels: <Reel>[], lastPage: 0);
  }
}

List<Reel> _convertDataToReels(List responseData) {
  return responseData
      .map((reel) => Reel.fromMap(reel as Map<String, dynamic>))
      .toList();
}

class ReelsService {
  /// Fetches reels for a user profile or the public feed.
  /// If [userId] is null, fetches the public reels list.
  static Future<List<Reel>> getUserReels({String? userId}) async {
    try {
      final url =
          userId != null ? '${Api.REELS_USER_URL}/$userId' : Api.REELS_URL;
      final response = await ApiService.to.get(url);

      List<Reel> reels = [];
      dynamic rawData = response.data;

      if (rawData is Map) {
        final nestedData =
            rawData['data'] ?? rawData['Data'] ?? rawData['reels'];
        if (nestedData is List) {
          for (var item in nestedData) {
            reels.add(Reel.fromMap(item));
          }
        } else if (rawData.containsKey('id')) {
          reels.add(Reel.fromMap(rawData as Map<String, dynamic>));
        }
      } else if (rawData is List) {
        for (var item in rawData) {
          reels.add(Reel.fromMap(item));
        }
      }
      return reels;
    } on ApiException catch (e) {
      CustomSnackBar.showCustomErrorSnackBar(
        message: formatErrorMsg(e.originalError?.response?.data),
      );
      return [];
    }
  }

  /// Fetches the reels feed for the home screen with pagination.
  static Future<List<Reel>> getReelsFeed({int page = 1}) async {
    try {
      final response = await ApiService.to.get(
        Api.REELS_FEED_URL,
        queryParameters: {'page': page},
      );

      dynamic rawData = response.data;
      List<dynamic> dataList = [];
      if (rawData is Map) {
        dataList = rawData['data'] ?? rawData['Data'] ?? rawData['reels'] ?? [];
      } else if (rawData is List) {
        dataList = rawData;
      }
      return dataList.map((reel) => Reel.fromMap(reel)).toList();
    } on ApiException catch (e) {
      CustomSnackBar.showCustomErrorSnackBar(
        message: formatErrorMsg(e.originalError?.response?.data),
      );
      return [];
    }
  }

  /// Fetches a single reel by its [id].
  static Future<Reel?> getReelById(String id) async {
    try {
      final response = await ApiService.to.get('${Api.REELS_URL}/$id');
      return Reel.fromMap(response.data);
    } on ApiException catch (e) {
      CustomSnackBar.showCustomErrorSnackBar(
        message: formatErrorMsg(e.originalError?.response?.data),
      );
      return null;
    }
  }

  /// Uploads a new reel from a [videoFile].
  static Future<Reel?> uploadReel(File videoFile) async {
    try {
      String fileName = videoFile.path.split('/').last;
      FormData formData = FormData.fromMap({
        'reels': await MultipartFile.fromFile(
          videoFile.path,
          filename: fileName,
        ),
      });

      final response = await ApiService.to.post(
        Api.REELS_URL,
        data: formData,
      );
      CustomSnackBar.showCustomSnackBar(
        message: 'Your reel has been shared.',
      );
      return Reel.fromMap(response.data);
    } on ApiException catch (e) {
      CustomSnackBar.showCustomErrorSnackBar(
        message: formatErrorMsg(e.originalError?.response?.data),
      );
      return null;
    }
  }

  /// Deletes a reel identify by [id].
  static Future<bool> deleteReel(String id) async {
    try {
      await ApiService.to.delete('${Api.REELS_URL}/$id');
      CustomSnackBar.showCustomSnackBar(
        title: 'Success',
        message: 'Reel deleted',
      );
      return true;
    } on ApiException catch (e) {
      CustomSnackBar.showCustomErrorSnackBar(
        message: formatErrorMsg(e.originalError?.response?.data),
      );
      return false;
    }
  }
}
