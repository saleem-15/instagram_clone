import 'package:dio/dio.dart';

import 'package:instagram_clone/core/models/user.dart';
import 'package:instagram_clone/main.dart';

import 'package:instagram_clone/core/utils/constants/api.dart';
import 'package:instagram_clone/core/utils/custom_snackbar.dart';
import 'package:instagram_clone/core/utils/helpers.dart';

Future<User> fetchSearchHistoryService(String userId) async {
  try {
    final response = await dio.get(Api.SEARCH_HISTORY_URL);
    final data = response.data['data'];
    logger.i(response.data);

    return User.fromMap(data);
  } on DioException catch (e) {
    logger.e(e.response);

    CustomSnackBar.showCustomErrorSnackBar(
      message: formatErrorMsg(e.message),
    );
    rethrow;
  }
}
