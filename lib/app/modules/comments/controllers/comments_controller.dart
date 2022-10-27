import 'dart:developer';

import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:instagram_clone/app/models/comment.dart';
import 'package:instagram_clone/app/models/post.dart';
import 'package:instagram_clone/utils/custom_snackbar.dart';

import '../services/add_comment_service.dart';
import '../services/get_post_comments_service.dart';

class CommentsController extends GetxController {
  int numOfPages = 1;
  final pagingController = PagingController<int, Comment>(
    firstPageKey: 1,
  );

  late final Post post;
  String get postText => post.caption;
  String get accountName => post.user.userName;

  final addCommentTextController = TextEditingController();
  String get commentText => addCommentTextController.text.trim();

  RxBool isPostButtonDisabled = true.obs;
  final textFieldFocusNode = FocusNode();

  @override
  void onInit() {
    post = Get.arguments as Post;

    pagingController.addPageRequestListener((pageKey) async {
      fetchComments(pageKey);
    });
    autoDisableButton();

    if (Get.parameters['isTextFieldFocused'] == 'true') {
      textFieldFocusNode.requestFocus();
    }
    super.onInit();
  }

  Future<void> fetchComments(int pageKey) async {
    try {
      log('fetch comments');
      final followersNewPage = await fetchPostCommentsService(post.id, pageKey);

      final isLastPage = numOfPages == pageKey;

      if (isLastPage) {
        pagingController.appendLastPage(followersNewPage);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(followersNewPage, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
      rethrow;
    }
  }

  void setPost(Post post) {
    this.post = post;
  }

  Future<void> postComment() async {
    final myComment = commentText;
    addCommentTextController.clear();
    final isSuccess = await addCommentService(myComment, post.id);

    if (isSuccess) {
      CustomSnackBar.showCustomSnackBar(message: 'comment was posted');
    } else {
      CustomSnackBar.showCustomErrorSnackBar(
          message: 'comment was not posted!');
    }
  }

  void autoDisableButton() {
    addCommentTextController.addListener(
      () => isPostButtonDisabled(commentText.isBlank! ? true : false),
    );
  }
}
