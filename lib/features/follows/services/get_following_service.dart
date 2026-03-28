import 'package:instagram_clone/core/services/api_service.dart';
import 'package:instagram_clone/core/utils/constants/api.dart';
import 'package:instagram_clone/core/utils/custom_snackbar.dart';
import 'package:instagram_clone/core/utils/helpers.dart';
import 'package:instagram_clone/core/models/user.dart';
import 'package:instagram_clone/core/network/api_exception.dart';

/// Fetches the users followed by a specific user with pagination.
/// Returns a record containing the list of [User]s and the [lastPage] number.
Future<({List<User> users, int lastPage})> fetchFollowingsService(
    String userId, int pageNum) async {
  try {
    final response = await ApiService.to.get(
      '${Api.FOLLOWING_PATH}/$userId',
      queryParameters: {'page': pageNum},
    );

    final dataList = response.data['data'] as List;
    final lastPage = response.data['meta']['last_page'] as int;

    final List<User> users = _convertDataToFollowing(dataList);

    return (
      users: users,
      lastPage: lastPage,
    );
  } on ApiException catch (e) {
    CustomSnackBar.showCustomErrorSnackBar(
      message: formatErrorMsg(e.originalError?.response?.data),
    );
    return (users: <User>[], lastPage: 0);
  }
}

List<User> _convertDataToFollowing(List data) {
  return data.map((following) => User.fromMap(following)).toList();
}
