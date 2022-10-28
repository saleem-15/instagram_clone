import 'dart:developer';

import 'package:get/get.dart';

import '../../../storage/my_shared_pref.dart';
import '../services/logout_service.dart';

class AuthController extends GetxController {
  bool isAuthorized = MySharedPref.getToken == null ? false : true;

  void tokenListener(dynamic token) {
    log('token changed');
    if (token == null) {
      isAuthorized = false;
    } else {
      isAuthorized = true;
    }
  }

  @override
  void onInit() {
    MySharedPref.userTokenListener(tokenListener);
    super.onInit();
  }

  void logout() {
    Get.back();
    MySharedPref.setUserToken(null);
    isAuthorized = false;
    logoutService();
  }
}
