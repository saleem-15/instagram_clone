import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:instagram_clone/features/auth/views/info_view.dart';
import 'package:instagram_clone/routes/app_pages.dart';
import 'package:instagram_clone/core/utils/constants/api.dart';

import '../services/sign_up_service.dart';

class SignupController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

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

  Future<void> showDateOfBirthPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      String day = picked.day.toString().padLeft(2, '0');
      String month = picked.month.toString().padLeft(2, '0');
      dateOfBirthController.text = "$day/$month/${picked.year}";
    }
  }

  final phoneFormKey = GlobalKey<FormState>();

  final emailFormKey = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    autoDisableSignUpButtons();
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void onNextButtonPressedPhoneNumber() {
    final isValid = phoneFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    tabController.animateTo(1);
  }

  void onNextButtonPressedEmail() {
    final isValid = emailFormKey.currentState!.validate();
    if (!isValid) {
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
      Api.authChanged();
      Get.offAllNamed(Routes.MY_APP);
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

  ///****************  info screen validators  *************/
  String? fullNameFieldValidator(String? value) {
    if (fullName.isBlank!) {
      return 'required';
    }

    if (value!.length.isLowerThan(8)) {
      return 'Name  must be at least eight letters and at most 30 letters';
    }
    if (value.length.isGreaterThan(30)) {
      return 'Name  must be at most 30 letters';
    }

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
      return 'Min password lenght is 6 characters';
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
