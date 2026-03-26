import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:instagram_clone/app/models/comment.dart';
import 'package:instagram_clone/app/models/post.dart';
import 'package:instagram_clone/app/models/user.dart';
import 'package:instagram_clone/app/routes/app_pages.dart';
import 'package:instagram_clone/app/modules/root/controllers/app_controller.dart';

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
    if (myComment.isEmpty) return;

    addCommentTextController.clear();

    // Optimistic Update: Add to UI immediately
    final appController = Get.find<AppController>();
    final optimisticComment = Comment(
      id: 'temp_${DateTime.now().millisecondsSinceEpoch}',
      user: appController.myUser,
      text: myComment,
      createdAt: 'Just now',
      isCommentLiked: false.obs,
    );

    final currentState = pagingController.value;
    final List<List<Comment>> currentPages =
        List.from(currentState.pages ?? []);

    if (currentPages.isEmpty) {
      currentPages.add([optimisticComment]);
    } else {
      final firstPage = List<Comment>.from(currentPages[0]);
      firstPage.insert(0, optimisticComment);
      currentPages[0] = firstPage;
    }

    pagingController.value = PagingState<int, Comment>(
      pages: currentPages,
      keys: currentState.keys ?? [0],
      error: currentState.error,
      hasNextPage: currentState.hasNextPage,
      isLoading: currentState.isLoading,
    );

    final serverComment = await addCommentService(myComment, post.id);

    if (serverComment != null) {
      // Replace optimistic with real one to get correct ID and details
      final updatedState = pagingController.value;
      final List<List<Comment>> updatedPages =
          List.from(updatedState.pages ?? []);

      if (updatedPages.isNotEmpty) {
        final firstPage = List<Comment>.from(updatedPages[0]);
        final index = firstPage.indexOf(optimisticComment);
        if (index != -1) {
          firstPage[index] = serverComment;
          updatedPages[0] = firstPage;
          pagingController.value = PagingState<int, Comment>(
            pages: updatedPages,
            keys: updatedState.keys,
            error: updatedState.error,
            hasNextPage: updatedState.hasNextPage,
            isLoading: updatedState.isLoading,
          );
        }
      }
    } else {
      // Rollback on failure: Remove the optimistic comment
      final updatedState = pagingController.value;
      final List<List<Comment>> updatedPages =
          List.from(updatedState.pages ?? []);

      if (updatedPages.isNotEmpty) {
        final firstPage = List<Comment>.from(updatedPages[0]);
        firstPage.remove(optimisticComment);
        updatedPages[0] = firstPage;
        pagingController.value = PagingState<int, Comment>(
          pages: updatedPages,
          keys: updatedState.keys,
          error: updatedState.error,
          hasNextPage: updatedState.hasNextPage,
          isLoading: updatedState.isLoading,
        );
      }
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
    update(['love_button_${comment.id}']);
  }
}
