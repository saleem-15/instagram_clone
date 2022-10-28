import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:instagram_clone/app/routes/app_pages.dart';
import 'package:instagram_clone/utils/constants/api.dart';

import '../services/sign_in_service.dart';

class SigninController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final firstFieledController = TextEditingController();
  final passwordController = TextEditingController();

  String get firstFieled => firstFieledController.text.trim();
  String get password => passwordController.text.trim();

  RxBool isButtonDisable = true.obs;

  Future<void> logIn() async {
    final isValid = formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    final isSuccessfull = await signInService(firstFieled, password);

    if (isSuccessfull) {
      Api.authChanged();
      Get.offAllNamed(Routes.MY_APP);
    }
  }

  @override
  void onInit() {
    autoDisableLoginButton();
    super.onInit();
  }

  String? emailFieldValidator(String? value) {
    if (firstFieled.isBlank!) {
      return 'required';
    }

    return null;
  }

  String? passwordFieldValidator(String? value) {
    if (passwordController.text.length.isLowerThan(6)) {
      return 'Wrong password';
    }
    return null;
  }

  void goToSignup() {
    Get.offNamed(Routes.SIGNUP);
  }

  void forgetPassword() {}

  void autoDisableLoginButton() {
    firstFieledController.addListener(() {
      if (firstFieledController.text.trim().isEmpty || passwordController.text.trim().isEmpty) {
        isButtonDisable(true);
        return;
      }
      isButtonDisable(false);
    });
    passwordController.addListener(() {
      if (firstFieledController.text.trim().isEmpty || passwordController.text.trim().isEmpty) {
        isButtonDisable(true);
        return;
      }
      isButtonDisable(false);
    });
  }
}
