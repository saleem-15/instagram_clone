import 'package:instagram_clone/core/network/api_service.dart';
import 'package:instagram_clone/core/utils/constants/api.dart';
import 'package:instagram_clone/core/utils/custom_snackbar.dart';
import 'package:instagram_clone/core/utils/helpers.dart';
import 'package:instagram_clone/core/network/api_exception.dart';

/// Follows a specific user identified by [userId].
/// Returns `true` if the request was successful, `false` otherwise.
Future<bool> followService(String userId) async {
  try {
    await ApiService.to.post(
      Api.FOLLOW_USER_PATH,
      queryParameters: {'user_id': userId},
    );
    return true;
  } on ApiException catch (e) {
    CustomSnackBar.showCustomErrorSnackBar(
      message: formatErrorMsg(e.originalError?.response?.data),
    );
    return false;
  }
}
