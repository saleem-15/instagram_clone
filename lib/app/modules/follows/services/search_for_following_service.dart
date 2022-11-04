import 'package:dio/dio.dart';
import 'package:instagram_clone/app/models/user.dart';
import 'package:instagram_clone/main.dart';

import 'package:instagram_clone/utils/constants/api.dart';
import 'package:instagram_clone/utils/custom_snackbar.dart';
import 'package:instagram_clone/utils/helpers.dart';

/// follow the user (become a follower to him)
/// returnes true if the request was successfull
Future<List<User>> searchForFollowingService(String userId, String keyWord) async {
  try {
    final response = await dio.post(
      Api.SEARCH_FOLLOWEING_PATH,
      queryParameters: {
        'user_id': userId,
        'toSearch': keyWord,
      },
    );

    logger.i(response.data);

    return User.usersListFromJson(response.data['Data']);
  } on DioError catch (e) {
    logger.e(e.response);

    CustomSnackBar.showCustomErrorSnackBar(
      message: formatErrorMsg(e.response!.data),
    );
    rethrow;
  }
}
