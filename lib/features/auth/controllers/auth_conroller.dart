
import 'package:get/get.dart';

import 'package:instagram_clone/core/services/storage_service.dart';
import '../services/logout_service.dart';

class AuthController extends GetxController {
  bool isAuthorized = StorageService.getToken == null ? false : true;

  void tokenListener(dynamic token) {

    if (token == null) {
      isAuthorized = false;
    } else {
      isAuthorized = true;
    }
  }

  @override
  void onInit() {
    StorageService.userTokenListener(tokenListener);
    super.onInit();
  }

  void logout() {
    Get.back();
    StorageService.setUserToken(null);
    isAuthorized = false;
    logoutService();
  }
}
