import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'package:instagram_clone/app/models/user.dart';

import '../../../../utils/constants/api.dart';
import '../../../../utils/custom_snackbar.dart';
import '../../../../utils/helpers.dart';
import '../controller/search_controller.dart';

Future<List<User>> searchService(String keyword, int pageKey) async {
  try {
    final response = await dio.post(
      Api.SEARCH_PATH,
      queryParameters: {
        'username': keyword,
        'paginate_num': pageKey,
      },
    );
    final data = response.data['data'];

    final numOfPages = response.data['meta']['last_page'] as int;

    Get.find<SearchController>().numOfPages = numOfPages;

    log(data.toString());

    return convertDataToUserList(data as List);
  } on DioError catch (e) {
    if (e.response == null) {
      log(e.error.toString());
    } else {
      log(e.response!.data.toString());
    }

    CustomSnackBar.showCustomErrorSnackBar(
      message: formatErrorMsg(e.message),
    );

    return [];
  }
}

List<User> convertDataToUserList(List usersData) {
  final List<User> usersList = [];

  for (Map<String, dynamic> p in usersData) {
    usersList.add(User.fromMap(p));
  }
  return usersList;
}
