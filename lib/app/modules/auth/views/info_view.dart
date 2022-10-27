import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:instagram_clone/app/modules/auth/controllers/signup_controller.dart';
import 'package:instagram_clone/config/theme/my_styles.dart';

class InfoView extends GetView<SignupController> {
  const InfoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final verticalSpace = 15.h;
    final horizontalPadding = 15.w;

    return Scaffold(
      body: Form(
        key: controller.formKey,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              children: [
                SizedBox(
                  height: 30.sp,
                ),
                Text(
                  'NAME AND PASSWORD',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(
                  height: verticalSpace,
                ),
                TextFormField(
                  controller: controller.fullNameController,
                  validator: controller.fullNameFieldValidator,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    hintText: 'Full name',
                  ),
                ),
                SizedBox(
                  height: verticalSpace,
                ),
                TextFormField(
                  controller: controller.userNameController,
                  validator: controller.userNameFieldValidator,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    hintText: 'Username',
                  ),
                ),
                SizedBox(
                  height: verticalSpace,
                ),
                TextFormField(
                  controller: controller.passwordController,
                  validator: controller.passwordFieldValidator,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                ),
                SizedBox(
                  height: verticalSpace,
                ),
                TextFormField(
                  controller: controller.dateOfBirthController,
                  validator: controller.dateOfBirthFieldValidator,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.datetime,
                  decoration: const InputDecoration(
                    hintText: 'Date of birth',
                  ),
                ),
                SizedBox(
                  height: verticalSpace,
                ),
                Obx(
                  () => ElevatedButton(
                    onPressed: controller.isContinueButtonDisable.isTrue
                        ? null
                        : controller.onSignupButtonPressed,
                    style: MyStyles.getAuthButtonStyle(),
                    child: const Text('Continue'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
