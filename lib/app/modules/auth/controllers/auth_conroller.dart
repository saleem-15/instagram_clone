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
      update(['auth_listener']);
    } else {
      isAuthorized = true;
      update(['auth_listener']);
    }
  }

  @override
  void onInit() {
    // log('------------Auth controller is initilized-------------');
    // log('My token:${MySharedPref.getToken}');

    MySharedPref.userTokenListener(tokenListener);
    super.onInit();
  }

  void logout() {
    Get.back();
    MySharedPref.setUserToken(null);
    isAuthorized = false;
    logoutService();
    update(['auth_listener']);
  }
}
