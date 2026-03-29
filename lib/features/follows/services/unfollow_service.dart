import 'package:instagram_clone/core/network/api_service.dart';
import 'package:instagram_clone/core/utils/constants/api.dart';
import 'package:instagram_clone/core/utils/custom_snackbar.dart';
import 'package:instagram_clone/core/utils/helpers.dart';
import 'package:instagram_clone/core/network/api_exception.dart';

/// Stops following a user identified by the [followingId].
/// Returns `true` if the request was successful, `false` otherwise.
Future<bool> unFollowService(String followingId) async {
  try {
    await ApiService.to.delete('${Api.FOLLOW_USER_PATH}/$followingId');
    return true;
  } on ApiException catch (e) {
    CustomSnackBar.showCustomErrorSnackBar(
      message: formatErrorMsg(e.originalError?.response?.data),
    );
    return false;
  }
}
