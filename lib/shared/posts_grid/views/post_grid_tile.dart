import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:instagram_clone/core/models/post.dart';
import 'package:instagram_clone/shared/widgets/app_network_image.dart';
import 'package:instagram_clone/shared/widgets/app_video_player.dart';
import 'package:instagram_clone/shared/widgets/hold_gesture_detector.dart';

class PostGridTile extends StatefulWidget {
  const PostGridTile({
    super.key,
    required this.post,
    required this.onPostPressed,
    required this.onPressedGone,
  });

  final Post post;
  final Function(Post post) onPostPressed;
  final Function(Post post) onPressedGone;

  @override
  State<PostGridTile> createState() => _PostGridTileState();
}

class _PostGridTileState extends State<PostGridTile> {
  bool _isPressed = false;

  void _onHold() {
    setState(() {
      _isPressed = true;
    });
    widget.onPostPressed(widget.post);
  }

  void _onHoldEnd() {
    setState(() {
      _isPressed = false;
    });
    widget.onPressedGone(widget.post);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: HoldGestureDetector(
            onHold: _onHold,
            onHoldEnd: _onHoldEnd,
            holdDuration: const Duration(milliseconds: 300),
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (widget.post.postContents[0].isImageFileName ||
                    widget.post.postContents[0].endsWith('.webp'))
                  AppNetworkImage(
                    imageUrl: widget.post.postContents[0],
                    fit: BoxFit.cover,
                  )
                else
                  AppVideoPlayer(
                    videoUrl: widget.post.postContents[0],
                    isMuted: true,
                    isLooping: false,
                    showVolumeToggle: false,
                    showLoading: false,
                  ),
                if (_isPressed)
                  Container(
                    color: Colors.black.withValues(alpha: 0.4),
                  ),
              ],
            ),
          ),
        ),
        if (widget.post.postContents.length.isGreaterThan(1))
          const Positioned(
            top: 5,
            right: 5,
            child: Icon(
              Icons.copy_outlined,
              color: Colors.white,
              size: 20,
            ),
          ),
        if (widget.post.postContents.length.isEqual(1) &&
            widget.post.postContents.first.isVideoFileName)
          Positioned(
            top: 5,
            right: 5,
            child: SvgPicture.asset(
              'assets/icons/Reels.svg',
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
              width: 18.sp,
            ),
          ),
      ],
    );
  }
}
