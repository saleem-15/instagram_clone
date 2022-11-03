import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:instagram_clone/app/models/user.dart';

import '../../../../utils/constants/api.dart';
import '../../../../utils/custom_snackbar.dart';
import '../../../../utils/helpers.dart';

Future<List<User>> fetchStoriesService() async {
  //       media: 'https://www.pexels.com/video/4778723/download/?fps=25.0&h=960&w=506.mp4',

  // final stories1 = [
  //   Story(
  //     id: '1',
  //     media: 'https://jsoncompare.org/LearningContainer/SampleFiles/Video/MP4/sample-mp4-file.mp4',
  //     isWathced: false,
  //   ),
  //   Story(
  //     id: '1',
  //     media:
  //         'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/Mercury_in_color_-_Prockter07-edit1.jpg/480px-Mercury_in_color_-_Prockter07-edit1.jpg',
  //     isWathced: false,
  //   ),
  //   Story(
  //     id: '2',
  //     media:
  //         'https://images.pexels.com/photos/4298629/pexels-photo-4298629.jpeg?auto=compress&cs=tinysrgb&w=600.jpg',
  //     isWathced: false,
  //   ),
  //   Story(
  //     id: '2',
  //     media:
  //         'https://images.pexels.com/photos/5473962/pexels-photo-5473962.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1.jpg',
  //     isWathced: false,
  //   ),
  //   Story(
  //     id: '2',
  //     media: 'https://live.staticflickr.com/65535/49168363698_337ea6289c_c.jpg',
  //     isWathced: false,
  //   ),
  //   Story(
  //     id: '2',
  //     media:
  //         'https://dvyvvujm9h0uq.cloudfront.net/com/articles/1525891879-886386-sam-burriss-457746-unsplashjpg.jpg',
  //     isWathced: false,
  //   ),
  // ];
  // final stories2 = [
  //   Story(
  //     id: '2',
  //     media:
  //         'https://dvyvvujm9h0uq.cloudfront.net/com/articles/1525891879-886386-sam-burriss-457746-unsplashjpg.jpg',
  //     isWathced: false,
  //   ),
  // ];
  // return [
  //   User(
  //     id: '1',
  //     userName: 'saleem',
  //     nickName: "soso",
  //     image:
  //         'https://dm.henkel-dam.com/is/image/henkel/men_perfect_com_thumbnails_home_pack_400x400-wcms-international?scl=1&fmt=jpg',
  //     userStories: stories1,
  //   ),
  //   User(
  //     id: '2',
  //     userName: 'ahmed',
  //     nickName: "hoho",
  //     image: 'https://cdn.carbuzz.com/gallery-images/2022-mclaren-720s-carbuzz-543544.jpg',
  //     userStories: stories2,
  //   ),
  //   User(
  //     id: '3',
  //     userName: 'mohammed',
  //     nickName: "alajel",
  //     image: 'https://cdn.carbuzz.com/gallery-images/2022-mclaren-720s-carbuzz-543544.jpg',
  //     userStories: stories1,
  //   ),
  // ];
  try {
    final response = await dio.get(Api.STORY_URL);
    log('fethced stories:  ${response.data.toString()}');
    final data = response.data['Data'];

    return _convertDataToUsers(data);
  } on DioError catch (e) {
    log(e.response!.toString());

    CustomSnackBar.showCustomErrorSnackBar(
      message: formatErrorMsg(e.message),
    );
    rethrow;
  }
}

List<User> _convertDataToUsers(List data) {
  final List<User> users = [];
  for (var user in data) {
    users.add(User.fromMap(user));
  }

  return users;
}
