import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:instagram_clone/app/models/user.dart';

import '../../../../utils/constants/api.dart';
import '../../../../utils/custom_snackbar.dart';
import '../../../../utils/helpers.dart';

Future<List<User>> fetchStoriesService() async {
  try {
    final response = await dio.get(Api.STORY_URL);
    final data = response.data['Data'];
    log(data.toString());

    return _convertDataToUsers(data);
  } on DioError catch (e) {
    log(e.response!.toString());

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
