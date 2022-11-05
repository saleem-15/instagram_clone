import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/app/shared/loading_widget.dart';

import 'package:instagram_clone/config/theme/my_styles.dart';

import '../controllers/reset_password_controller.dart';

class ResetPasswordScreen extends GetView<ResetPasswordController> {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100.sp,
            ),
            Text(
              'Reset Password',
              style: Theme.of(context).textTheme.headline5,
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
                onPressed: controller.isButtonDisable.isTrue ? null : controller.onResetPasswordButtonPressed,
                style: MyStyles.getAuthButtonStyle(),
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
