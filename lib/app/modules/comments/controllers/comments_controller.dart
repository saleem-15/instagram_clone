import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/app/models/comment.dart';
import 'package:instagram_clone/app/models/user.dart';

class CommentsController extends GetxController {
  String postText =
      'hi guys this is post text which will be displayed on home page and in the comments screen';

  String accountName = 'resrito';
  final addCommentTextController = TextEditingController();

  late List<Comment> comments;

  final textFieldFocusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    comments = [
      Comment(
        id: '1',
        postId: '',
        user: User(id: '1', name: accountName, image: ''),
        text: 'Lorem ipsum dolor sit  accusantium consectetur?',
      ),
      Comment(
        id: '2',
        postId: '',
        user: User(id: '2', name: accountName, image: ''),
        text: 'Lorem ipsum dolor sit  accusantium consectetur?',
      ),
      Comment(
        id: '3',
        postId: '',
        user: User(id: '3', name: accountName, image: ''),
        text: 'Lorem ipsum dolor sit  accusantium consectetur?',
      ),
      Comment(
        id: '4',
        postId: '',
        user: User(id: '4', name: accountName, image: ''),
        text: 'Lorem ipsum dolor sit  accusantium consectetur?',
      ),
      Comment(
        id: '5',
        postId: '',
        user: User(id: '5', name: accountName, image: ''),
        text: 'Lorem ipsum dolor sit  accusantium consectetur?',
      ),
    ];

    if (Get.parameters['isTextFieldFocused'] == 'true') {
      textFieldFocusNode.requestFocus();
    }
  }
}
