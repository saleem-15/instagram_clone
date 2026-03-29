import 'package:instagram_clone/core/network/api_service.dart';

import 'package:dio/dio.dart';
import 'package:instagram_clone/core/models/user.dart';
import 'package:instagram_clone/main.dart';

import 'package:instagram_clone/core/utils/constants/api.dart';
import 'package:instagram_clone/core/utils/custom_snackbar.dart';
import 'package:instagram_clone/core/utils/helpers.dart';

Future<List<User>> fetchStoriesService() async {
  try {
    final response = await ApiService.to.get(Api.STORY_URL);
    logger.i(response.data);
    final data = response.data['Data'];

    return _convertDataToUsers(data);
  } on DioException catch (e) {
    CustomSnackBar.showCustomErrorSnackBar(
      message: formatErrorMsg(e.message),
    );
    rethrow;
  }
}

List<User> _convertDataToUsers(List data) {
  final List<User> users = [];
  for (var user in data) {
    users.add(User.fromMap(user));
  }

  return users;
}
