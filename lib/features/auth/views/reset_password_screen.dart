import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/shared/loading_widget.dart';
import 'package:instagram_clone/core/theme/my_fonts.dart';
import 'package:instagram_clone/core/theme/my_dark_styles.dart';
import 'package:instagram_clone/core/theme/my_styles.dart';

import '../controllers/reset_password_controller.dart';

class ResetPasswordScreen extends GetView<ResetPasswordController> {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        primary: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100.sp,
            ),
            Text(
              'Reset Password',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(
              height: 15.sp,
            ),
            Form(
              key: controller.formKey,
              // the textField is wrapped in (theme) so when the textField has Focus the icon color
              //(in the textField) change to my specific color
              child: TextFormField(
                controller: controller.passwordController,
                validator: controller.passwordFieldValidator,
                style: MyFonts.inputTextStyle,
                decoration: const InputDecoration(
                  hintText: 'New Password',
                ),
              ),
            ),
            SizedBox(
              height: 15.sp,
            ),
            Obx(
              () => ElevatedButton(
                onPressed: controller.isButtonDisable.isTrue
                    ? null
                    : controller.onResetPasswordButtonPressed,
                style: Theme.of(context).brightness == Brightness.dark
                    ? MyDarkStyles.getAuthButtonStyle()
                    : MyStyles.getAuthButtonStyle(),
                child: Obx(
                  () => controller.isWaitingForRequest.isTrue
                      ? const LoadingWidget.button()
                      : const Text('Reset Password'),
                ),
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
          ],
        ).paddingSymmetric(horizontal: 20.w),
      ),
    );
  }
}
