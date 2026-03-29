import 'dart:developer';
import 'package:video_player/video_player.dart';
import 'package:instagram_clone/core/services/video_service.dart';
import 'package:instagram_clone/core/utils/constants/api.dart';

/// A smart wrapper around [VideoPlayerController] that leverages universal caching
/// and handles visibility-based auto-play and memory disposal.
class MyVideoController {
  VideoPlayerController? videoPlayerController;
  final String videoUrl;

  bool _isInitilized = false;
  bool get isInitilized => _isInitilized;

  bool _isDisposed = false;

  MyVideoController({
    required this.videoUrl,
  });

  Future<VideoPlayerController> initialize() async {
    if (_isInitilized && videoPlayerController != null)
      return videoPlayerController!;
    if (_isDisposed) throw 'Cannot initialize disposed controller';

    // 1. Check cache first
    final fileInfo = await VideoService.to.getCachedVideo(videoUrl);

    if (fileInfo != null) {
      log('Playing from cache: $videoUrl');
      videoPlayerController = VideoPlayerController.file(fileInfo.file);
    } else {
      log('Playing from network & caching background: $videoUrl');
      videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(videoUrl),
        httpHeaders: Api.headers,
      );
      // Trigger background download so it's cached for next time/views
      VideoService.to.cacheVideo(videoUrl);
    }

    await videoPlayerController!.initialize();

    if (_isDisposed) {
      videoPlayerController!.dispose();
      throw 'Controller disposed during initialization';
    }

    // Default options for loops/muted
    await videoPlayerController!.setVolume(0);
    await videoPlayerController!.setLooping(true);

    _isInitilized = true;
    return videoPlayerController!;
  }

  void playIfVisible() {
    if (_isInitilized && !_isDisposed) {
      videoPlayerController?.play();
    }
  }

  void pauseIfInvisible() {
    if (_isInitilized && !_isDisposed) {
      videoPlayerController?.pause();
    }
  }

  void toggleMute() {
    if (_isInitilized && !_isDisposed) {
      final currentVol = videoPlayerController!.value.volume;
      videoPlayerController!.setVolume(currentVol == 0 ? 1.0 : 0.0);
    }
  }

  void dispose() {
    _isDisposed = true;
    if (_isInitilized) {
      videoPlayerController?.dispose();
    }
    _isInitilized = false;
    videoPlayerController = null;
  }
}
