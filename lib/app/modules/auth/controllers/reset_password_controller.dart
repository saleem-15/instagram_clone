import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/app/routes/app_pages.dart';

import '../services/reset_new_password_service.dart';

class ResetPasswordController extends GetxController {
  late final String email;
  late final String code;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final passwordController = TextEditingController();
  String get newPassword => passwordController.text.trim();
  RxBool isButtonDisable = true.obs;
  RxBool isWaitingForRequest = false.obs;

  @override
  void onInit() {
    email = Get.parameters['email']!;
    code = Get.parameters['code']!;
    autoDisableButton();
    super.onInit();
  }

  void autoDisableButton() {
    passwordController.addListener(() {
      if (passwordController.text.trim().isEmpty) {
        isButtonDisable(true);
        return;
      }
      isButtonDisable(false);
    });
  }

  String? passwordFieldValidator(String? value) {
    if (newPassword.isBlank!) {
      return 'required';
    }

    if (newPassword.length.isLowerThan(6)) {
      return 'Min password lenght is 6 characters';
    }
    return null;
  }

  void onResetPasswordButtonPressed() {
    /// validate the new password
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      resetPassword();
    }
  }

  Future<void> resetPassword() async {
    isWaitingForRequest(true);
    final isSuccessfull = await resetPasswordService(
      email: email,
      code: code,
      newPassword: newPassword,
    );
    isWaitingForRequest(false);

    if (isSuccessfull) {
      Get.offAllNamed(Routes.SIGN_IN);
    }
  }
}
