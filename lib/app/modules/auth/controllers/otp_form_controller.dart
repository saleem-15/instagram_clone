import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/app/routes/app_pages.dart';

import '../services/forget_password_service.dart';
import '../services/verify_code_service copy.dart';

class OtpFormController extends GetxController {
  // final firstOtpFieldController = TextEditingController();
  // final secondOtpFieldController = TextEditingController();
  // final thirdOtpFieldController = TextEditingController();
  // final fourthOtpFieldController = TextEditingController();
  // final fifthOtpFieldController = TextEditingController();
  // final sixthOtpFieldController = TextEditingController();

  List<TextEditingController> otpFieldstextControllers = List.generate(6, (_) => TextEditingController());
  List<FocusNode> otpFocusNodes = List.generate(6, (_) => FocusNode());

  // String get firstOtpField => firstOtpFieldController.text;
  // String get secondOtpField => firstOtpFieldController.text;
  // String get thirdOtpField => firstOtpFieldController.text;
  // String get fourthOtpField => firstOtpFieldController.text;
  // String get fifthOtpField => firstOtpFieldController.text;
  // String get sixthOtpField => firstOtpFieldController.text;

  late final String email;

  RxBool isConfirmButtonDisable = true.obs;
  RxBool isWaitingResponse = false.obs;

  String get verificationCode {
    String x = '';
    for (final otpField in otpFieldstextControllers) {
      x += otpField.text;
    }

    return x;
  }

  @override
  void onInit() {
    email = Get.parameters['email']!;
    super.onInit();
  }

  Future<void> onConfirmButtonPressed() async {
    isWaitingResponse(true);
    final isSuccessfull = await forgetPasswordService(email);
    isWaitingResponse(false);

    if (isSuccessfull) {
      Get.toNamed(Routes.OTP_FORM);
    }
  }

  /// this method must be called whenever a field changes
  ///
  /// it checks if all the fields are full so it enables the confirm button
  void changeConfirmButtonStatus() {
    final bool isAllOtpFieldsFull =
        otpFieldstextControllers.every((textController) => textController.text.isNotEmpty);
    if (isAllOtpFieldsFull) {
      isConfirmButtonDisable(false);
    } else {
      isConfirmButtonDisable(true);
    }
  }

  Future<void> confirmCode() async {
    isWaitingResponse(true);
    final isSuccess = await verifyCodeService(
      email: email,
      code: verificationCode,
    );
    isWaitingResponse(false);

    if (isSuccess) {
      Get.toNamed(Routes.RESET_PASSWORD, parameters: {
        'email': email,
        'code': verificationCode,
      });
    }
  }

  void resendCode() {}

  void onOtpFieldTapped() {
    if (otpFieldstextControllers[0].text.isEmpty) {
      otpFocusNodes[0].requestFocus();
      return;
    }
    if (otpFieldstextControllers[1].text.isEmpty) {
      otpFocusNodes[1].requestFocus();
      return;
    }
    if (otpFieldstextControllers[2].text.isEmpty) {
      otpFocusNodes[2].requestFocus();
      return;
    }
    if (otpFieldstextControllers[3].text.isEmpty) {
      otpFocusNodes[3].requestFocus();
      return;
    }
    if (otpFieldstextControllers[4].text.isEmpty) {
      otpFocusNodes[4].requestFocus();
      return;
    }
    if (otpFieldstextControllers[5].text.isEmpty) {
      otpFocusNodes[5].requestFocus();
      return;
    }
  }

  onOtpFieldChange(int index, String value, BuildContext context) {
    changeConfirmButtonStatus();
    if (value.length == 1 && index != 5) {
      FocusScope.of(context).nextFocus();
      return;
    }

    if (value.isEmpty && index != 0) {
      FocusScope.of(context).previousFocus();
    }
  }
}
