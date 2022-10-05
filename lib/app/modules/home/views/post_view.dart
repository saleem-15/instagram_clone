// ignore_for_file: public_member_api_docs, sort_ructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:instagram_clone/app/models/post.dart';
import 'package:instagram_clone/app/modules/home/controllers/post_controller.dart';
import 'package:instagram_clone/app/shared/user_avatar.dart';

class PostView extends GetView<PostController> {
  const PostView({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    final postPadding = EdgeInsets.only(
      left: 10.w,
      right: 2.w,
      bottom: 3.sp,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: postPadding,
          child: Row(
            children: [
              const UserAvatar(),
              const SizedBox(
                width: 10,
              ),
              Text(post.user.name),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert),
              )
            ],
          ),
        ),
        const Divider(
          height: 0,
        ),

        /// contents of the post
        GestureDetector(
          onTap: () {},
          child: Image.asset(post.photos![0]),
        ),

        /// row of buttons (love ,comment share,save)
        Padding(
          padding: postPadding,
          child: Row(
            children: [
              GetBuilder<PostController>(
                assignId: true,
                id: '${post.id} love button',
                builder: (controller) {
                  return IconButton(
                      onPressed: () => controller.onHeartPressed(post),
                      // Icons.favorite => if favorite
                      icon: post.isFavorite
                          ? const FaIcon(
                              FontAwesomeIcons.solidHeart,
                              color: Colors.red,
                            )
                          : const FaIcon(FontAwesomeIcons.heart));
                },
              ),
              const SizedBox(
                width: 15,
              ),
              IconButton(
                onPressed: () => controller.comment(post),
                icon: const FaIcon(FontAwesomeIcons.comment),

                // icon:  Icon(Icons.chat),
              ),
              const SizedBox(
                width: 15,
              ),
              IconButton(
                onPressed: () {},
                // icon: FaIcon(FontAwesomeIcons.paperPlane),
                icon: const Icon(Icons.send),
              ),
              const Spacer(),
              GetBuilder<PostController>(
                assignId: true,
                id: '${post.id} save button',
                builder: (controller) {
                  return IconButton(
                    onPressed: () => controller.onSaveButtonPressed(post),
                    icon: Icon(post.isSaved ? Icons.bookmark_sharp : Icons.bookmark_outline_sharp),
                  );
                },
              ),
            ],
          ),
        ),

        /// num of likes and comments
        Padding(
          padding: postPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${post.numOfLikes} likes',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(
                height: 4.sp,
              ),
              GestureDetector(
                onTap: () => controller.viewPostComments(post),
                child: Text(
                  'View all ${post.numOfComments} comments',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 13.sp),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
