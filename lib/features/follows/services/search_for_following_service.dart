import 'package:instagram_clone/core/network/api_service.dart';
import 'package:instagram_clone/core/models/user.dart';
import 'package:instagram_clone/core/utils/constants/api.dart';
import 'package:instagram_clone/core/utils/custom_snackbar.dart';
import 'package:instagram_clone/core/utils/helpers.dart';
import 'package:instagram_clone/core/network/api_exception.dart';

/// Searches for users followed by the specified [userId] using a [searchKeyWord].
/// Returns a list of [User] objects matching the search criteria.
Future<List<User>> searchForFollowingService(
    String userId, String searchKeyWord) async {
  try {
    final response = await ApiService.to.get(
      '${Api.SEARCH_FOLLOWING_PATH}/$userId',
      queryParameters: {'q': searchKeyWord},
    );

    final dataList = response.data['data'] as List;
    return _convertDataToUsers(dataList);
  } on ApiException catch (e) {
    CustomSnackBar.showCustomErrorSnackBar(
      message: formatErrorMsg(e.originalError?.response?.data),
    );
    return [];
  }
}

List<User> _convertDataToUsers(List data) {
  return data.map((user) => User.fromMap(user)).toList();
}
