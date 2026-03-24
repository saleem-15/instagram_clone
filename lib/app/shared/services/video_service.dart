import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:instagram_clone/utils/constants/api.dart';

class VideoService extends GetxService {
  static VideoService get to => Get.find();

  final Map<String, VideoPlayerController> _controllers = {};
  final Map<String, int> _refCounts = {};

  Future<VideoPlayerController> getController(String url) async {
    // Increment reference count
    _refCounts[url] = (_refCounts[url] ?? 0) + 1;

    if (_controllers.containsKey(url)) {
      return _controllers[url]!;
    }

    final controller = VideoPlayerController.networkUrl(
      Uri.parse(url),
      httpHeaders: Api.headers,
    );
    
    _controllers[url] = controller;
    await controller.initialize();
    
    return controller;
  }

  void releaseController(String url) {
    if (!_refCounts.containsKey(url)) return;

    _refCounts[url] = _refCounts[url]! - 1;

    if (_refCounts[url]! <= 0) {
      _controllers[url]?.dispose();
      _controllers.remove(url);
      _refCounts.remove(url);
    }
  }

  @override
  void onClose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    _controllers.clear();
    _refCounts.clear();
    super.onClose();
  }
}
