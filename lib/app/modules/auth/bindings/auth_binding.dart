import 'package:get/get.dart';
import 'package:instagram_clone/app/modules/auth/controllers/forgot_password_controller.dart';

import '../controllers/auth_conroller.dart';
import '../controllers/otp_form_controller.dart';
import '../controllers/reset_password_controller.dart';
import '../controllers/signin_controller.dart';
import '../controllers/signup_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
    Get.lazyPut(() => SignupController(), fenix: true);
    Get.lazyPut(() => SigninController(), fenix: true);
    Get.lazyPut(() => ForgotPasswordController(), fenix: true);
    Get.lazyPut(() => OtpFormController(), fenix: true);
    Get.lazyPut(() => ResetPasswordController(), fenix: true);
  }
}
