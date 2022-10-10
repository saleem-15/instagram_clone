import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:instagram_clone/app/models/comment.dart';

import '../../../../utils/constants/api.dart';
import '/utils/custom_snackbar.dart';
import '../../../../utils/helpers.dart';

Future<List<Comment>> getPostCommentsService(String postId) async {
  try {
    final response = await dio.get('$COMMNETS_URL/$postId');

    final responseData = response.data['Data'];
    log(responseData.toString());

    return _convertDataToCommentsList(responseData as List);
  } on DioError catch (e) {
    log(e.response!.data.toString());
    CustomSnackBar.showCustomErrorSnackBar(
      message: formatErrorMsg(e.response!.data),
    );
    return [];
  }
}

List<Comment> _convertDataToCommentsList(List responseData) {
  List<Comment> comments = [];
  for (var comment in responseData) {
    comments.add(Comment.fromMap(comment));
  }

  return comments;
}
