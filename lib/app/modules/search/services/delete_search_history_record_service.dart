import 'package:dio/dio.dart';

import 'package:instagram_clone/main.dart';

import '../../../../utils/constants/api.dart';
import '../../../../utils/custom_snackbar.dart';
import '../../../../utils/helpers.dart';

Future<bool> deleteSearchHistoryRecordService(String recordId) async {
  try {
    final response = await dio.delete('${Api.SEARCH_HISTORY_URL}/$recordId');
    logger.i(response.data);

    return true;
  } on DioError catch (e) {
    logger.e(e.response);

    CustomSnackBar.showCustomErrorSnackBar(
      message: formatErrorMsg(e.message),
    );
    return false;
  }
}
