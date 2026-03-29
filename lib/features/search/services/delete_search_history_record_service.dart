import 'package:instagram_clone/core/network/api_service.dart';
import 'package:dio/dio.dart';

import 'package:instagram_clone/main.dart';

import 'package:instagram_clone/core/utils/constants/api.dart';
import 'package:instagram_clone/core/utils/custom_snackbar.dart';
import 'package:instagram_clone/core/utils/helpers.dart';

Future<bool> deleteSearchHistoryRecordService(String recordId) async {
  try {
    final response =
        await ApiService.to.delete('${Api.SEARCH_HISTORY_URL}/$recordId');
    logger.i(response.data);

    return true;
  } on DioException catch (e) {
    logger.e(e.response);

    CustomSnackBar.showCustomErrorSnackBar(
      message: formatErrorMsg(e.message),
    );
    return false;
  }
}
