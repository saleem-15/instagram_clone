import 'package:get/get.dart';

import '../controllers/auth_conroller.dart';
import '../controllers/signin_controller.dart';
import '../controllers/signup_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
    Get.lazyPut(() => SignupController(), fenix: true);
    Get.lazyPut(() => SigninController(), fenix: true);
  }
}
