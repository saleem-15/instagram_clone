import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/app/routes/app_pages.dart';

import '../services/forget_password_service.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();

  String get email => emailController.text.trim();

  RxBool isEmailButtonDisable = true.obs;
  RxBool isWaitingResponse = false.obs;

  @override
  void onInit() {
    autoDisableNextButton();
    super.onInit();
  }

  Future<void> onNextButtonPressedEmail() async {
    isWaitingResponse(true);
    final isSuccessfull = await forgetPasswordService(email);
    isWaitingResponse(false);

    if (isSuccessfull) {
      Get.toNamed(
        Routes.OTP_FORM,
        parameters: {'email': email},
      );
    }
  }

  void autoDisableNextButton() {
    emailController.addListener(() {
      if (emailController.text.trim().isEmpty) {
        isEmailButtonDisable(true);
        return;
      }
      isEmailButtonDisable(false);
    });
  }

  String? emailFieldValidator(String? value) {
    if (emailController.text.isEmail) {
      return null;
    }

    return 'Enter a valid email';
  }

}
