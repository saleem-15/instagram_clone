import 'package:instagram_clone/core/utils/my_video_controller.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:instagram_clone/core/models/post.dart';
import 'package:video_player/video_player.dart';

class PostGridTile extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Listener(
            onPointerDown: (event) => onPostPressed(post),
            onPointerUp: (event) => onPressedGone(post),
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (post.postContents[0].isImageFileName ||
                    post.postContents[0].endsWith('.webp'))
                  CachedNetworkImage(
                    imageUrl: post.postContents[0],
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) {
                      debugPrint(
                          'Image error: ${post.postContents[0]} \n $error');
                      return const Center(
                        child: Icon(Icons.broken_image, color: Colors.grey),
                      );
                    },
                  )
                else
                  VideoThumbnail(videoUrl: post.postContents[0]),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    highlightColor: Colors.black45,
                    splashColor: Colors.transparent,
                    onTap: () {},
                  ),
                ),
              ],
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

class VideoThumbnail extends StatefulWidget {
  final String videoUrl;
  const VideoThumbnail({super.key, required this.videoUrl});

  @override
  State<VideoThumbnail> createState() => _VideoThumbnailState();
}

class _VideoThumbnailState extends State<VideoThumbnail> {
  late MyVideoController _myVideoController;
  VideoPlayerController? _controller;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _initController();
  }

  Future<void> _initController() async {
    _myVideoController = MyVideoController(videoUrl: widget.videoUrl);
    _controller = await _myVideoController.initialize();

    if (mounted) {
      setState(() {
        _initialized = true;
        // Optionally seek to 1 second to avoid black frames on some videos
        _controller!.seekTo(const Duration(milliseconds: 100));
      });
    }
  }

  @override
  void dispose() {
    _myVideoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _initialized && _controller != null
        ? ClipRect(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller!.value.size.width,
                height: _controller!.value.size.height,
                child: VideoPlayer(_controller!),
              ),
            ),
          )
        : Container(color: Colors.black12);
  }
}
