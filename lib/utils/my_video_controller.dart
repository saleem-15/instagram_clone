import 'dart:developer';
import 'dart:io';

import 'package:video_player/video_player.dart';

/// this class is my custom wrapper around [VideoPlayerController]
///
/// I did this because the [VideoPlayerController] didn't support pausing the video if
/// it was not initilized, and I needed this feature :)
class MyVideoController {
  late final VideoPlayerController videoPlayerController;
  bool _isPaused = false;
  bool get isPaused => _isPaused;

  /// video url in case of network video,
  /// file path in case of file video
  final String videoPath;
  late final DataSourceType _dataSourceType;

  bool _isInitilized = false;
  bool get isInitilized => _isInitilized;

  MyVideoController.network({
    required this.videoPath,
  }) : _dataSourceType = DataSourceType.network;

  MyVideoController.file({
    required this.videoPath,
  }) : _dataSourceType = DataSourceType.file;

  Future<VideoPlayerController> initialize() async {
    switch (_dataSourceType) {
      case DataSourceType.network:
        log('network video');
        videoPlayerController =
            VideoPlayerController.networkUrl(Uri.https(videoPath));
        break;

      case DataSourceType.file:
        log('file video');
        videoPlayerController =
            VideoPlayerController.file(File(videoPath));
        break;
      default:
        throw 'The video source is not from network Nor File, Check if the file path is correct';
    }

    await videoPlayerController.initialize();
    _isInitilized = true;

    if (_isPaused) {
      videoPlayerController.pause();
    }

    return videoPlayerController;
  }

  void resume() {
    _isPaused = false;
    videoPlayerController.play();
  }

  void pause() {
    _isPaused = true;
    videoPlayerController.pause();
  }
}
