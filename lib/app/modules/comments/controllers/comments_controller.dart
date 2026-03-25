import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:instagram_clone/app/models/comment.dart';
import 'package:instagram_clone/app/models/post.dart';
import 'package:instagram_clone/app/models/user.dart';
import 'package:instagram_clone/app/routes/app_pages.dart';
import 'package:instagram_clone/utils/custom_snackbar.dart';

import '../services/add_comment_service.dart';
import '../services/get_post_comments_service.dart';

class CommentsController extends GetxController {
  int numOfPages = 1;
  late final PagingController<int, Comment> pagingController;
  static final Map<String, AnimationController> heartAnimationControllers = {};

  late final Post post;
  String get postText => post.caption;
  String get accountName => post.user.userName;

  final addCommentTextController = TextEditingController();
  String get commentText => addCommentTextController.text.trim();

  RxBool isPostButtonDisabled = true.obs;
  final textFieldFocusNode = FocusNode();

  @override
  void onInit() {
    if (Get.arguments != null && Get.arguments is Post) {
      post = Get.arguments as Post;
    }
    pagingController = PagingController<int, Comment>(
      getNextPageKey: getNextPageKey,
      fetchPage: fetchComments,
    );

    autoDisableButton();

    if (Get.parameters['isTextFieldFocused'] == 'true') {
      textFieldFocusNode.requestFocus();
    }
    super.onInit();
  }

  Future<List<Comment>> fetchComments(int pageKey) async {
    try {
      log('fetch comments');
      final commentsNewPage = await fetchPostCommentsService(post.id, pageKey);
      return commentsNewPage;
    } catch (error) {
      log("error fetching comments: $error");
      return [];
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
      // No snackbar needed on success as the comment will appear in the list
    } else {
      CustomSnackBar.showCustomErrorSnackBar(
          message: 'Failed to post comment. Please try again.');
    }
  }

  void autoDisableButton() {
    addCommentTextController.addListener(
      () => isPostButtonDisabled(commentText.isBlank! ? true : false),
    );
  }

  void onUserNamePressd(User user) {
    Get.toNamed(
      Routes.PROFILE,
      arguments: user,
      parameters: {'user_id': user.id},
    );
  }

  int? getNextPageKey(PagingState<int, Comment> state) {
    int currentPage = state.nextIntPageKey - 1;
    if (currentPage >= numOfPages) {
      return null;
    }

    return state.nextIntPageKey;
  }

  void onCommentLikePressed(Comment comment) {
    comment.isCommentLiked.toggle();
    heartAnimationControllers[comment.id]?.reset();
    heartAnimationControllers[comment.id]?.forward();
  }
}
