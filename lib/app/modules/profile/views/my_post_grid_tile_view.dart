// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:instagram_clone/app/models/post.dart';

class MyPostGridTileView extends StatelessWidget {
  const MyPostGridTileView({
    Key? key,
    required this.post,
    required this.onPostLongPressed,
    required this.onPressedGone,
  }) : super(key: key);
  final Post post;
  final Function(Post post) onPostLongPressed;
  final Function(Post post) onPressedGone;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (details) {
        // _buttonPressed = true;
        onPostLongPressed(post);
      },
      onPointerUp: (details) {
        onPressedGone(post);
        // _buttonPressed = false;
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              post.postContents[0],
              fit: BoxFit.cover,
            ),
          ),
          if (post.postContents.length.isGreaterThan(1))
            const Positioned(
              top: 5,
              right: 5,
              child: Icon(
                Icons.copy_outlined,
                color: Colors.white,
                size: 20,
              ),
            ),
          if (post.postContents.length.isEqual(1) && post.postContents.first.isVideoFileName)
            const Positioned(
              top: 5,
              right: 5,
              child: Icon(
                Icons.videocam_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
        ],
      ),
    );
  }
}
