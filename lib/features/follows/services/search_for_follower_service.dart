import 'package:instagram_clone/core/network/api_service.dart';
import 'package:instagram_clone/core/models/user.dart';
import 'package:instagram_clone/core/utils/constants/api.dart';
import 'package:instagram_clone/core/utils/custom_snackbar.dart';
import 'package:instagram_clone/core/utils/helpers.dart';
import 'package:instagram_clone/core/network/api_exception.dart';

/// Searches for followers of the specified [userId] using a [searchKeyWord].
/// Returns a list of [User] objects matching the search criteria.
Future<List<User>> searchForFollowerService(
    String userId, String searchKeyWord) async {
  try {
    final response = await ApiService.to.post(
      Api.SEARCH_FOLLOWERS_PATH,
      queryParameters: {
        'user_id': userId,
        'toSearch': searchKeyWord,
      },
    );

    return User.usersListFromJson(response.data['Data']);
  } on ApiException catch (e) {
    CustomSnackBar.showCustomErrorSnackBar(
      message: formatErrorMsg(e.originalError?.response?.data),
    );
    return [];
  }
}
