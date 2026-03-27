import 'package:get/get.dart';
import 'package:instagram_clone/routes/app_pages.dart';
import 'package:instagram_clone/core/services/storage_service.dart';
import 'package:instagram_clone/core/utils/constants/api.dart';

class SettingsBottomSheetController extends GetxController {
  void logout() {
    StorageService.clearAllData();
    Api.authChanged();
    Get.offAllNamed(Routes.SIGN_IN);
  }
}
