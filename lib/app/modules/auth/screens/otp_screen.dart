import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:instagram_clone/app/modules/auth/controllers/otp_form_controller.dart';
import 'package:instagram_clone/app/shared/loading_widget.dart';
import 'package:instagram_clone/config/theme/light_theme_colors.dart';
import 'package:instagram_clone/config/theme/my_styles.dart';

class OtpForm extends GetView<OtpFormController> {
  const OtpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification Code'),
      ),
      body: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'We have sent a verification code to',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: Theme.of(context).disabledColor,
                  ),
            ),
            SizedBox(
              height: 5.sp,
            ),
            Text(
              controller.email,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 16.sp,
                  ),
            ),
            SizedBox(
              height: 20.sp,
            ),

            /// otp field
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                6,
                (index) => OtpField(index: index),
              ),
            ).paddingSymmetric(horizontal: 5.w),
            SizedBox(
              height: 40.sp,
            ),

            /// resend && confrim buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: controller.resendCode,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        width: 1,
                        color: LightThemeColors.lightBlue,
                      ),
                    ),
                    child: const Text('Resend Code'),
                  ),
                ),
                SizedBox(
                  width: 30.w,
                ),
                Expanded(
                  child: Obx(
                    () => ElevatedButton(
                      onPressed: controller.isConfirmButtonDisable.isTrue ? null : controller.confirmCode,
                      style: MyStyles.getAuthButtonStyle(),
                      child: controller.isWaitingResponse.isTrue
                          ?const LoadingWidget.button()
                          : const Text('Confirm'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ).paddingSymmetric(
          horizontal: 15.w,
          vertical: 30.sp,
        ),
      ),
    );
  }
}

class OtpField extends GetView<OtpFormController> {
  const OtpField({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;
  bool get isFirstField => index == 0;
  bool get isLastField => index == 5;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.w,
      width: 40.w,
      child: TextFormField(
        autofocus: false,
        controller: controller.otpFieldstextControllers[index],
        focusNode: controller.otpFocusNodes[index],
        onTap: controller.onOtpFieldTapped,
        onChanged: (value) => controller.onOtpFieldChange(index, value, context),
        style: Theme.of(context).textTheme.headline6,
        decoration: const InputDecoration(
          filled: false,
          border: UnderlineInputBorder(),
          enabledBorder: UnderlineInputBorder(),
          focusedBorder: UnderlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        textInputAction: isLastField ? TextInputAction.done : TextInputAction.none,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }
}
