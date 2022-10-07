import 'package:get/get.dart';

import '../controllers/explorer_controller.dart';

class ExplorerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ExplorerController>(ExplorerController());
  }
}
