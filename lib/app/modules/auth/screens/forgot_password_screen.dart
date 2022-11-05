import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/app/modules/auth/controllers/forgot_password_controller.dart';
import 'package:instagram_clone/app/shared/loading_widget.dart';
import 'package:instagram_clone/config/theme/my_styles.dart';

class ForgotPasswordScreen extends GetView<ForgotPasswordController> {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Forget Password',
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50.sp,
          ),
          Text(
            'Find your account',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: 10.sp,
          ),
          Text(
            'Enter the email linked to your account',
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: Theme.of(context).disabledColor,
                ),
          ),
          SizedBox(
            height: 30.sp,
          ),
          TextFormField(
            controller: controller.emailController,
            validator: controller.emailFieldValidator,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Email Address',
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Obx(
            () => ElevatedButton(
              onPressed: controller.isEmailButtonDisable.isTrue ? null : controller.onNextButtonPressedEmail,
              style: MyStyles.getAuthButtonStyle(),
              child: controller.isWaitingResponse.isTrue ? const LoadingWidget.button() : const Text('Next'),
            ),
          ),
        ],
      ).marginSymmetric(
        horizontal: 20.w,
      ),
    );
  }
}
