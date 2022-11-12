import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'package:instagram_clone/app/modules/follows/controllers/following_controller.dart';
import 'package:instagram_clone/utils/helpers.dart';

import '../../../../utils/constants/api.dart';
import '../../../models/user.dart';
import '/utils/custom_snackbar.dart';

Future<List<User>> fetchFollowingsService(String userId, int pageNum,
    {required FollowingController followingController}) async {
  try {
    final response = await dio.get(
      '${Api.FOLLOWEING_PATH}/$userId',
      queryParameters: {'page': pageNum},
    );

    log(response.data.toString());

    followingController.numOfPages = response.data['last_page'];

    return _convertDataToFollowing(response.data['data'] as List);
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

List<User> _convertDataToFollowing(List data) {
  final List<User> followeings = [];
  for (var following in data) {
    followeings.add(User.fromMap(following)..printInfo());
    // log(following.toString());
  }

  return followeings;
}
