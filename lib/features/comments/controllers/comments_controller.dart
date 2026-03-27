import 'package:instagram_clone/features/comments/services/get_comment_replies_service.dart';
import 'package:instagram_clone/features/comments/services/add_comment_service.dart';
import 'package:instagram_clone/features/comments/services/get_post_comments_service.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:instagram_clone/core/models/comment.dart';
import 'package:instagram_clone/core/models/post.dart';
import 'package:instagram_clone/core/models/user.dart';
import 'package:instagram_clone/routes/app_pages.dart';
import 'package:instagram_clone/features/root/controllers/app_controller.dart';


class CommentsController extends GetxController {
  int numOfPages = 1;
  late final PagingController<int, Comment> pagingController;
  static final Map<String, AnimationController> heartAnimationControllers = {};

  late final Post post;
  String get postText => post.caption;
  String get accountName => post.user.userName;

  final addCommentTextController = _MentionController();
  String get commentText => addCommentTextController.text.trim();

  RxBool isPostButtonDisabled = true.obs;
  final textFieldFocusNode = FocusNode();
  String? parentId;

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

      final commentsNewPage = await fetchPostCommentsService(post.id, pageKey);
      return commentsNewPage;
    } catch (error) {

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
      numOfReplies: 0.obs,
    );

    final currentParentId = parentId;
    parentId = null; // reset after picking it up

    if (currentParentId == null) {
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
    }

    final serverComment = currentParentId == null
        ? await addCommentService(myComment, post.id)
        : await addReplyService(myComment, currentParentId);

    if (serverComment != null) {
      if (currentParentId == null) {
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
        // It's a reply, we don't do optimistic update for replies yet to keep it simple,
        // but we should refresh the parent replies if visible
        // For now, let's just find the parent and add it if replies are visible
        _addReplyToParent(currentParentId, serverComment);
      }
    } else if (currentParentId == null) {
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

  void _addReplyToParent(String parentCommentId, Comment reply) {
    // Search for parent in pagingController pages
    final currentState = pagingController.value;
    if (currentState.pages == null) return;

    for (var page in currentState.pages!) {
      for (var comment in page) {
        if (comment.id == parentCommentId) {
          comment.replies.add(reply);
          comment.numOfReplies.value++;
          comment.isRepliesVisible.value = true;
          return;
        }
        // Check nested replies too (though usually only 1 level in IG)
        for (var nestedReply in comment.replies) {
          if (nestedReply.id == parentCommentId) {
            comment.replies.add(reply); // usually added to the same parent
            comment.numOfReplies.value++;
            return;
          }
        }
      }
    }
  }

  void toggleReplies(Comment comment) async {
    if (comment.isRepliesVisible.value) {
      comment.isRepliesVisible.value = false;
    } else {
      if (comment.replies.isEmpty && comment.numOfReplies > 0) {
        await fetchReplies(comment);
      }
      comment.isRepliesVisible.value = true;
    }
  }

  Future<void> fetchReplies(Comment comment) async {
    try {
      final replies = await fetchCommentRepliesService(comment.id);
      comment.replies.assignAll(replies);
    } catch (_) {
      // Fail silently if replies cannot be fetched
    }
  }

  void onReplyPressed(Comment comment) {
    parentId = comment.id;
    addCommentTextController.text = '@${comment.user.userName} ';
    textFieldFocusNode.requestFocus();
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

class _MentionController extends TextEditingController {
  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    final List<TextSpan> spans = [];
    final RegExp mentionRegex = RegExp(r'(@\w+(?: \w+)?)');

    text.splitMapJoin(
      mentionRegex,
      onMatch: (m) {
        spans.add(TextSpan(
          text: m.group(0),
          style: style?.copyWith(color: Colors.blue) ??
              const TextStyle(color: Colors.blue),
        ));
        return '';
      },
      onNonMatch: (s) {
        spans.add(TextSpan(text: s, style: style));
        return '';
      },
    );

    return TextSpan(children: spans, style: style);
  }
}
