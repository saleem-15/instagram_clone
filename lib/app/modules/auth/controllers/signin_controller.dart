import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../main.dart';
import '../screens/signup_screen.dart';
import '../services/sign_in_service.dart';

class SigninController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  RxBool isButtonDisable = true.obs;

  Future<void> logIn() async {
    final isValid = formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final isSuccessfull = await signInService(email, password);

    if (isSuccessfull) {
      Get.off(() => const Main());
    }
  }

  @override
  void onInit() {
    autoDisableLoginButton();
    super.onInit();
  }

  String? emailFieldValidator(String? value) {
    if (emailController.text.isEmail) {
      return null;
    }

    return 'Enter a valid email';
  }

  String? passwordFieldValidator(String? value) {
    if (passwordController.text.length.isLowerThan(6)) {
      return 'Wrong password';
    }
    return null;
  }

  void goToSignup() {
    Get.off(() => const SignupScreen());
  }

  void forgetPassword() {}

  void autoDisableLoginButton() {
    emailController.addListener(() {
      if (emailController.text.trim().isEmpty || passwordController.text.trim().isEmpty) {
        isButtonDisable(true);
        return;
      }
      isButtonDisable(false);
    });
    passwordController.addListener(() {
      if (emailController.text.trim().isEmpty || passwordController.text.trim().isEmpty) {
        isButtonDisable(true);
        return;
      }
      isButtonDisable(false);
    });
  }
}
