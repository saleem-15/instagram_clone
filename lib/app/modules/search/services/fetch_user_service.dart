
import 'package:dio/dio.dart';

import 'package:instagram_clone/app/models/user.dart';

import '../../../../utils/constants/api.dart';
import '../../../../utils/custom_snackbar.dart';
import '../../../../utils/helpers.dart';

Future<User> fetchUserService(String userId) async {
  try {
    final response = await dio.get('${Api.USER_URL}/$userId');
    final data = response.data['data'];


    return User.fromMap(data);
  } on DioException catch (e) {


    CustomSnackBar.showCustomErrorSnackBar(
      message: formatErrorMsg(e.message),
    );
    rethrow;
  }
}
