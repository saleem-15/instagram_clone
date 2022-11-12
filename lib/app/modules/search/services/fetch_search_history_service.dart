import 'package:dio/dio.dart';

import 'package:instagram_clone/app/models/user.dart';
import 'package:instagram_clone/main.dart';

import '../../../../utils/constants/api.dart';
import '../../../../utils/custom_snackbar.dart';
import '../../../../utils/helpers.dart';

Future<User> fetchSearchHistoryService(String userId) async {
  try {
    final response = await dio.get(Api.SEARCH_HISTORY_URL);
    final data = response.data['data'];
    logger.i(response.data);

    return User.fromMap(data);
  } on DioError catch (e) {
    logger.e(e.response);

    CustomSnackBar.showCustomErrorSnackBar(
      message: formatErrorMsg(e.message),
    );
    rethrow;
  }
}
