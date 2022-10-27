import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:instagram_clone/app/models/post.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class MyPostGridTileView extends StatelessWidget {
  const MyPostGridTileView({
    Key? key,
    required this.post,
    required this.onPostPressed,
    required this.onPressedGone,
  }) : super(key: key);
  final Post post;
  final Function(Post post) onPostPressed;
  final Function(Post post) onPressedGone;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Listener(
            onPointerDown: (event) => onPostPressed(post),
            onPointerUp: (event) => onPressedGone(post),
            child: Ink.image(
              image: NetworkImage(post.postContents[0]),
              fit: BoxFit.cover,
              child: InkWell(
                highlightColor: Colors.black45,
                splashColor: Colors.transparent,
                onTap: () {},
                // onTapDown: (details) {
                //   onPostPressed(post);
                //   log('press started');
                // },
                // onTapUp: (details) {
                //   onPressedGone(post);
                //   log('press ended');
                // },
              ),
            ),
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
        if (post.postContents.length.isEqual(1) &&
            post.postContents.first.isVideoFileName)
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
    );
  }
}
