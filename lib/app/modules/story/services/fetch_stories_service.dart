
import 'package:dio/dio.dart';
import 'package:instagram_clone/app/models/user.dart';
import 'package:instagram_clone/main.dart';

import '../../../../utils/constants/api.dart';
import '../../../../utils/custom_snackbar.dart';
import '../../../../utils/helpers.dart';

Future<List<User>> fetchStoriesService() async {
  try {
    final response = await dio.get(Api.STORY_URL);
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
