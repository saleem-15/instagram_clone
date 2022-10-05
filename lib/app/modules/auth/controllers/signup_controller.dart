import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:instagram_clone/app/modules/auth/views/info_view.dart';

import '../../../../main.dart';
import '../screens/signin_screen.dart';
import '../services/sign_up_service.dart';

class SignupController extends GetxController {
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();

  RxBool isPhoneButtonDisable = true.obs;
  RxBool isEmailButtonDisable = true.obs;

  /// in the info screen (name,password form)
  RxBool isContinueButtonDisable = true.obs;

  String get email => emailController.text.trim();
  String get password => passwordController.text.trim();

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    autoDisableSignUpButtons();
    super.onInit();
  }

  void onNextButtonPressedPhoneNumber() {
    Get.off(const InfoView());
  }

  void onNextButtonPressedEmail() {
    Get.off(const InfoView());
  }

  Future<void> onSignupButtonPressed() async {
    final isValid = formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    await signup();
  }

  Future<void> signup() async {
    final results = await signupService(
      email,
      password,
    );

    /// is sign up process is done correctly
    final isSuccessfull = results[1];

    if (isSuccessfull) {
      Get.off(() => const Main());
    }
  }

  String? phoneNumberValidator(String? value) {
    if (GetUtils.isPhoneNumber(value!)) {
      return null;
    }
    return 'not valid phone number';
  }

  String? emailFieldValidator(String? value) {
    if (emailController.text.isEmail) {
      return null;
    }

    return 'Enter a valid email';
  }

  String? passwordFieldValidator(String? value) {
    if (passwordController.text.length.isLowerThan(6)) {
      return 'min password lenght is 6 characters';
    }
    return null;
  }

  String? fullNameFieldValidator(String? value) {
    if (passwordController.text.isEmpty) {
      return 'required';
    }
    return null;
  }

  void goToLogIn() {
    Get.off(() => const SigninScreen());
  }

  void autoDisableSignUpButtons() {
    phoneNumberController.addListener(() {
      if (phoneNumberController.text.trim().isEmpty) {
        isPhoneButtonDisable(true);
        return;
      }
      isPhoneButtonDisable(false);
    });
    emailController.addListener(() {
      if (emailController.text.trim().isEmpty) {
        isEmailButtonDisable(true);
        return;
      }
      isEmailButtonDisable(false);
    });
    fullNameController.addListener(() {
      if (fullNameController.text.trim().isEmpty || passwordController.text.trim().isEmpty) {
        isContinueButtonDisable(true);
        return;
      }
      isContinueButtonDisable(false);
    });
    passwordController.addListener(() {
      if (passwordController.text.trim().isEmpty || fullNameController.text.trim().isEmpty) {
        isContinueButtonDisable(true);
        return;
      }
      isContinueButtonDisable(false);
    });
  }
}
