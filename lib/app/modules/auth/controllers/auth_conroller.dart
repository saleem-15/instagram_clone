import 'package:get/get.dart';

import '../../../storage/my_shared_pref.dart';
import '../services/logout_service.dart';

class AuthController extends GetxController {
  bool isUserSignedIn = MySharedPref.getToken == null ? false : true;

  void tokenListener(dynamic token) {
    if (token == null) {
      isUserSignedIn = false;
      update(['auth_listener']);
    } else {
      isUserSignedIn = true;
      update(['auth_listener']);
    }
  }

  @override
  void onInit() {
    // log('------------Auth controller is initilized-------------');
    // log('My token:${MySharedPref.getToken}');
    // log('is User logged in: $isUserSignedIn');

    MySharedPref.userTokenListener(tokenListener);
    super.onInit();
  }

  void logout() {
    Get.back();
    MySharedPref.setUserToken(null);
    isUserSignedIn = false;
    logoutService();
    update(['auth_listener']);
  }
}
