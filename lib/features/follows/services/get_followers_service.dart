
import 'package:dio/dio.dart';
import 'package:instagram_clone/main.dart';

import 'package:instagram_clone/core/utils/constants/api.dart';
import 'package:instagram_clone/core/utils/custom_snackbar.dart';
import 'package:instagram_clone/core/utils/helpers.dart';

import 'package:instagram_clone/core/models/user.dart';
import '../controllers/followers_controller.dart';

Future<List<User>> fetchFollowersService(String userId, int pageNum,
    {required FollowersController followersController}) async {
  try {
    final response = await dio.get(
      '${Api.FOLLOWERS_PATH}/$userId',
      queryParameters: {'page': pageNum},
    );
    logger.i(response.data);

    followersController.numOfPages = response.data['meta']['last_page'];


    return _convertDataToFollowers(response.data['data'] as List);
  } on DioException catch (e) {
    if (e.response == null) {

    } else {

    }
    CustomSnackBar.showCustomErrorSnackBar(
      message: formatErrorMsg(e.response!.data),
    );
    return [];
  }
}

List<User> _convertDataToFollowers(List data) {
  final List<User> followers = [];
  for (var follower in data) {
    followers.add(User.fromMap(follower));
  }

  return followers;
}
