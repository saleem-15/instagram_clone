import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:instagram_clone/core/services/video_service.dart';
import 'package:video_player/video_player.dart';

/// A lightweight, lifecycle-safe wrapper around [VideoPlayerController].
///
/// This class replaces the old dual-constructor pattern (`.network` / `.file`)
/// with a single, cache-aware initialization pipeline powered by [VideoService].
///
/// ## How Initialization Works
/// 1. [VideoService.getCachedVideo] is called first with the given [videoUrl].
/// 2. If a locally-cached file is found, the controller is created with
///    [VideoPlayerController.file] — zero network cost.
/// 3. If no cached file exists, the controller falls back to
///    [VideoPlayerController.networkUrl] and immediately triggers a background
///    download via [VideoService.preCacheVideo] so the next playback is instant.
///
/// ## Safe-Pause Guarantee
/// A caller may invoke [pauseVideo] before [initialize] completes (e.g., the
/// widget scrolls off-screen during the async init). The [_pendingPause] flag
/// captures this intent and applies it the moment initialization finishes.
///
/// ## Memory Safety
/// [_controller] is kept **nullable**. After [disposeVideo] is called, the
/// reference is set to `null`, which prevents any further writes or reads on a
/// disposed object and avoids OOM (Out-Of-Memory) crashes.
class MyVideoController {
  /// The URL of the video to play. Must be a valid absolute URL.
  final String videoUrl;

  /// The underlying [VideoPlayerController]. Nullable to allow strict disposal.
  VideoPlayerController? _controller;

  /// Exposes the controller to the UI once initialization is complete.
  VideoPlayerController? get controller => _controller;

  /// Whether the video has been fully initialized and is ready to play.
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  /// Whether the video is currently paused.
  bool _isPaused = false;
  bool get isPaused => _isPaused;

  /// Captures a pause intent that was requested before initialization finished.
  ///
  /// This is the core of the "safe pause" guarantee — see class-level docs.
  bool _pendingPause = false;

  Timer? _visibilityTimer;

  MyVideoController({required this.videoUrl});

  /// Initializes the video controller using the [VideoService] caching pipeline.
  ///
  /// Steps:
  /// 1. Checks [VideoService] for a locally-cached copy of [videoUrl].
  /// 2. Creates the appropriate [VideoPlayerController] (file or network).
  /// 3. If no cache exists, fires a background pre-cache for the next session.
  /// 4. After `initialize()` completes, applies any pending pause intent.
  ///
  /// Throws if the URL is empty or initialization itself fails.
  Future<void> initialize() async {
    assert(videoUrl.isNotEmpty, 'videoUrl must not be empty');

    final cachedFile = await VideoService.to.getCachedVideo(videoUrl);

    if (cachedFile != null) {
      // Cache hit: play from local storage — no network cost.
      _controller = VideoPlayerController.file(cachedFile.file,);
    } else {
      // Cache miss: stream over the network and cache for the next session.
      _controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl));

      // Fire-and-forget background pre-cache. Any failure is handled inside
      // VideoService.preCacheVideo (corrupted files are removed automatically).
      VideoService.to.preCacheVideo(videoUrl);
    }

    await _controller!.initialize();
    _isInitialized = true;

    // Apply the pending pause that arrived before init completed.
    if (_pendingPause) {
      _controller!.pause();
      _isPaused = true;
      _pendingPause = false;
    }
  }

  /// Debounces visibility events to avoid triggering playback during rapid scrolls.
  void handleVisibility(double visibleFraction, {VoidCallback? onStateChanged}) {
    _visibilityTimer?.cancel();
    _visibilityTimer = Timer(const Duration(milliseconds: 200), () {
      if (visibleFraction >= 0.5) {
        if (_isPaused) {
          playVideo();
          if (onStateChanged != null) onStateChanged();
        }
      } else {
        if (!_isPaused) {
          pauseVideo();
          if (onStateChanged != null) onStateChanged();
        }
      }
    });
  }

  /// Starts or resumes video playback.
  ///
  /// Safe to call before [initialize] completes — it will simply clear any
  /// pending pause intent so the video plays as soon as init finishes.
  void playVideo() {
    _pendingPause = false;
    _isPaused = false;

    if (_isInitialized && _controller != null) {
      _controller!.play();
    }
  }

  /// Pauses video playback.
  ///
  /// If called before [initialize] completes, the pause intent is stored in
  /// [_pendingPause] and applied automatically once the controller is ready.
  /// This prevents the player from playing even a single frame before the
  /// widget is ready (e.g., a reel that scrolls off-screen mid-load).
  void pauseVideo() {
    _isPaused = true;

    if (_isInitialized && _controller != null) {
      _controller!.pause();
    } else {
      // Capture the intent for post-init application.
      _pendingPause = true;
    }
  }

  /// Fully disposes the [VideoPlayerController] and nullifies the reference.
  ///
  /// This is the **primary memory-safety mechanism** in this class:
  /// - [controller.dispose()] releases the native video decoder resources.
  /// - Setting [_controller] to `null` ensures no further method calls can be
  ///   made on the disposed object, preventing OOM crashes and use-after-free
  ///   bugs.
  ///
  /// Always call this when the owning widget is removed from the tree.
  void disposeVideo() {
    _visibilityTimer?.cancel();
    _controller?.dispose();
    _controller = null;
    _isInitialized = false;
    _isPaused = false;
    _pendingPause = false;
  }
}
