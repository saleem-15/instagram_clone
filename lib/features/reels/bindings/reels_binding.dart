import 'package:get/get.dart';
import '../controllers/reels_controller.dart';

class ReelsBinding extends Bindings {
  ReelsBinding();

  @override
  void dependencies() {
    Get.put(ReelsController(), permanent: true);
  }
}
