import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../utils/constants/api.dart';
import '../../../models/user.dart';
import '/utils/custom_snackbar.dart';

Future<List<User>> getProfileInfoService() async {
  try {
    final response = await dio.get(USER_PATH);
    final data = response.data['data'];
    log(response.data.toString());

    return _convertDataToFollowing(data as List);
  } on DioError catch (e) {
    log(e.response!.data.toString());
    CustomSnackBar.showCustomErrorSnackBar(
      message: e.response!.data['Messages'].toString(),
    );
    return [];
  }
}

List<User> _convertDataToFollowing(List data) {
  final List<User> followers = [];
  for (var follower in data) {
    followers.add(User.fromMap(follower));
  }

  return followers;
}
