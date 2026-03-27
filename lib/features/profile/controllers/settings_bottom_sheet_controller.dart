import 'package:instagram_clone/core/services/storage_service.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/routes/app_pages.dart';

class SettingsBottomSheetController extends GetxController {
  void logout() {
    Get.find<StorageService>().clearAllData();
    Get.offAllNamed(Routes.SIGN_IN);
  }
}
