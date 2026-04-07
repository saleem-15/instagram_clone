import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_clone/core/services/video_service.dart';
import 'package:instagram_clone/shared/loading_widget.dart';

/// A unified VideoPlayer widget that handles caching through VideoService,
/// audio toggling, and background video looping natively without manual setup.
class AppVideoPlayer extends StatefulWidget {
  const AppVideoPlayer({
    super.key,
    required this.videoUrl,
    this.width,
    this.height,
    this.isMuted = true,
    this.isLooping = false,
    this.showVolumeToggle = false,
    this.autoPlay = true,
    this.showLoading = true,
  });

  final String videoUrl;
  final double? width;
  final double? height;
  final bool isMuted;
  final bool isLooping;
  final bool showVolumeToggle;
  final bool autoPlay;
  final bool showLoading;

  @override
  State<AppVideoPlayer> createState() => _AppVideoPlayerState();
}

class _AppVideoPlayerState extends State<AppVideoPlayer> {
  VideoPlayerController? _controller;
  late bool _isMuted;

  @override
  void initState() {
    super.initState();
    _isMuted = widget.isMuted;
    _initVideo();
  }

  Future<void> _initVideo() async {
    _controller = await VideoService.to.getController(widget.videoUrl);
    if (mounted && _controller != null) {
      setState(() {});
      await _controller!.setVolume(_isMuted ? 0 : 1);
      await _controller!.setLooping(widget.isLooping);
      if (widget.autoPlay) {
        await _controller!.play();
        // Seek to 100ms to skip black frame on some android builds
        if (!widget.isLooping) {
          _controller!.seekTo(const Duration(milliseconds: 100));
        }
      }
    }
  }

  void _toggleMute() {
    if (_controller == null) return;
    setState(() {
      _isMuted = !_isMuted;
    });
    _controller!.setVolume(_isMuted ? 0 : 1);
  }

  @override
  void dispose() {
    _controller?.setVolume(0);
    _controller?.pause();
    VideoService.to.releaseController(widget.videoUrl);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return Container(
        width: widget.width,
        height: widget.height,
        color: Colors.black12,
        child: widget.showLoading
            ? const Center(
                child: LoadingWidget(size: 60, strokeWidth: 1.0),
              )
            : const SizedBox.shrink(),
      );
    }

    final videoWidget = ClipRect(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: _controller!.value.size.width,
          height: _controller!.value.size.height,
          child: VideoPlayer(_controller!),
        ),
      ),
    );

    if (!widget.showVolumeToggle) {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: videoWidget,
      );
    }

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: [
          Positioned.fill(child: videoWidget),
          Positioned(
            bottom: 12.h,
            left: 12.w,
            child: GestureDetector(
              onTap: _toggleMute,
              child: Container(
                padding: EdgeInsets.all(6.r),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _isMuted ? Icons.volume_off : Icons.volume_up,
                  color: Colors.white,
                  size: 14.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
