import 'package:instagram_clone/core/network/api_service.dart';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'package:instagram_clone/core/models/user.dart';

import 'package:instagram_clone/core/utils/constants/api.dart';
import 'package:instagram_clone/core/utils/custom_snackbar.dart';
import 'package:instagram_clone/core/utils/helpers.dart';
import '../controllers/search_controller.dart';

Future<List<User>> searchService(String keyword, int pageKey) async {
  try {
    final response = await ApiService.to.post(
      Api.SEARCH_PATH,
      queryParameters: {
        'username': keyword,
        'paginate_num': pageKey,
      },
    );
    final data = response.data['data'];

    final numOfPages = response.data['meta']['last_page'] as int;
    Get.find<SearchController>().numOfPages = numOfPages;

    return convertDataToUserList(data as List);
  } on DioException catch (e) {
    if (e.response == null) {
    } else {}

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
