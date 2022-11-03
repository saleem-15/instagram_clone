import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'package:instagram_clone/utils/constants/api.dart';
import 'package:instagram_clone/utils/custom_snackbar.dart';
import 'package:instagram_clone/utils/helpers.dart';

import '../../../models/user.dart';
import '../controllers/followers_controller.dart';

Future<List<User>> fetchFollowersService(String userId, int pageNum,{required FollowersController followersController}) async {
  try {
    final response = await dio.get(
      '${Api.FOLLOWERS_PATH}/$userId',
      queryParameters: {'page': pageNum},
    );
    log(response.data.toString());

    followersController.numOfPages = response.data['last_page'];

    return _convertDataToFollowers(response.data['data'] as List);
  } on DioError catch (e) {
    if (e.response == null) {
      log(e.error.toString());
    } else {
      log(e.response!.data.toString());
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
