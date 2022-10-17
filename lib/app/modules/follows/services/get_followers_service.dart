import '../../../models/user.dart';

Future<List<User>> fetchFollowersService(int pageNum) async {
  return [
    User(id: '1', name: 'sal', image: ''),
    User(id: '2', name: 'moh', image: ''),
    User(id: '3', name: 'ali', image: ''),
  ];
  // try {
  //   final response = await dio.get(
  //     FOLLOWERS_PATH,
  //     queryParameters: {'page': pageNum},
  //   );
  //   final data = response.data['data'];
  //   log(response.data.toString());

  //   return _convertDataToFollowers(data as List);
  // } on DioError catch (e) {
  //   log(e.response!.data.toString());
  //   CustomSnackBar.showCustomErrorSnackBar(
  //     message: e.response!.data['Messages'].toString(),
  //   );
  //   return [];
  // }
}

List<User> _convertDataToFollowers(List data) {
  final List<User> followers = [];
  for (var follower in data) {
    followers.add(User.fromMap(follower));
  }

  return followers;
}
