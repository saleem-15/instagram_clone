import 'package:instagram_clone/features/auth/services/auth_service.dart';
import 'package:instagram_clone/core/services/storage_service.dart';

import 'package:get/get.dart';


class AuthController extends GetxController {
  final StorageService storage;
  final AuthService auth;

  AuthController({StorageService? storage, AuthService? auth})
      : storage = storage ?? Get.find<StorageService>(),
        auth = auth ?? Get.find<AuthService>() {
    _isAuthorized.value = this.storage.getToken != null;
    this.storage.userTokenListener(tokenListener);
  }

  final RxBool _isAuthorized = false.obs;
  bool get isAuthorized => _isAuthorized.value;

  void tokenListener(dynamic token) {
    if (token == null) {
      _isAuthorized.value = false;
    } else {
      _isAuthorized.value = true;
    }
  }


  void logout() {
    Get.back();
    storage.setUserToken(null);
    _isAuthorized.value = false;
    auth.logout();
  }
}
