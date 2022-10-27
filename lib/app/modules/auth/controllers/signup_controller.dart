import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:instagram_clone/app/modules/auth/views/info_view.dart';
import 'package:instagram_clone/app/routes/app_pages.dart';

import '../services/sign_up_service.dart';

class SignupController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final fullNameController = TextEditingController();
  final userNameController = TextEditingController();
  final dateOfBirthController = TextEditingController();

  RxBool isPhoneButtonDisable = true.obs;
  RxBool isEmailButtonDisable = true.obs;

  /// in the info screen (name,password,birthday form)
  RxBool isContinueButtonDisable = true.obs;
  String get email => emailController.text.trim();
  String get password => passwordController.text.trim();
  String get phoneNumber => phoneNumberController.text.trim();
  String get fullName => fullNameController.text.trim();
  String get userName => userNameController.text.trim();
  String get dateOfBirth => dateOfBirthController.text.trim();

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    autoDisableSignUpButtons();
    super.onInit();
  }

  void onNextButtonPressedPhoneNumber() {
    if (phoneNumber.isBlank! || !phoneNumber.isPhoneNumber) {
      return;
    }

    Get.to(() => const InfoView());
  }

  void onNextButtonPressedEmail() {
    if (email.isBlank! || !email.isEmail) {
      return;
    }
    Get.to(() => const InfoView());
  }

  Future<void> onSignupButtonPressed() async {
    final isValid = formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    await signup();
  }

  Future<void> signup() async {
    final isSuccessfull = await signupService(
      email: email,
      password: password,
      name: fullName,
      nickName: userName,
      dateOfBirth: dateOfBirth,
      phoneNumber: phoneNumber,
    );

    if (isSuccessfull) {
      update(['auth_listener']);
    }

    // if (isSuccessfull) {
    //   Get.off(() => const Main());
    // }
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

  ///****************  info screen validators  *************/
  String? fullNameFieldValidator(String? value) {
    if (fullName.isBlank!) {
      return 'required';
    }

    // if (!GetUtils.isUsername(fullName)) {
    //   return 'not a valid name';
    // }
    return null;
  }

  String? userNameFieldValidator(String? value) {
    if (userName.isBlank!) {
      return 'required';
    }

    return null;
  }

  String? passwordFieldValidator(String? value) {
    if (password.isBlank!) {
      return 'required';
    }

    if (password.length.isLowerThan(6)) {
      return 'min password lenght is 6 characters';
    }
    return null;
  }

  String? dateOfBirthFieldValidator(String? value) {
    if (dateOfBirth.isBlank!) {
      return 'required';
    }
    return null;
  }

  ///****************  info screen validators  *************/

  void goToLogIn() {
    Get.offNamed(Routes.SIGN_IN);
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
      if (fullNameController.text.trim().isEmpty ||
          passwordController.text.trim().isEmpty ||
          dateOfBirthController.text.trim().isEmpty ||
          userNameController.text.trim().isEmpty) {
        isContinueButtonDisable(true);
        return;
      }
      isContinueButtonDisable(false);
    });
    passwordController.addListener(() {
      if (passwordController.text.trim().isEmpty ||
          fullNameController.text.trim().isEmpty ||
          dateOfBirthController.text.trim().isEmpty ||
          userNameController.text.trim().isEmpty) {
        isContinueButtonDisable(true);
        return;
      }
      isContinueButtonDisable(false);
    });
    dateOfBirthController.addListener(() {
      if (passwordController.text.trim().isEmpty ||
          fullNameController.text.trim().isEmpty ||
          dateOfBirthController.text.trim().isEmpty ||
          userNameController.text.trim().isEmpty) {
        isContinueButtonDisable(true);
        return;
      }
      isContinueButtonDisable(false);
    });
    userNameController.addListener(() {
      if (passwordController.text.trim().isEmpty ||
          fullNameController.text.trim().isEmpty ||
          dateOfBirthController.text.trim().isEmpty ||
          userNameController.text.trim().isEmpty) {
        isContinueButtonDisable(true);
        return;
      }
      isContinueButtonDisable(false);
    });
  }
}
