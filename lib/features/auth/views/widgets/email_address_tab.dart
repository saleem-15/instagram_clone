import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:instagram_clone/features/auth/controllers/signup_controller.dart';
import 'package:instagram_clone/core/theme/my_fonts.dart';
import 'package:instagram_clone/core/theme/my_dark_styles.dart';
import 'package:instagram_clone/core/theme/my_styles.dart';

class EmailAddressTab extends GetView<SignupController> {
  const EmailAddressTab({super.key});
  @override
  Widget build(BuildContext context) {
    final verticalSpace = 15.h;

    return Form(
      key: controller.emailFormKey,
      child: Column(
        children: [
          TextFormField(
            controller: controller.emailController,
            validator: controller.emailFieldValidator,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            style: MyFonts.inputTextStyle,
            decoration: const InputDecoration(
              hintText: 'Email Address',
            ),
          ),
          SizedBox(
            height: verticalSpace,
          ),
          Obx(
            () => ElevatedButton(
              onPressed: controller.isEmailButtonDisable.isTrue
                  ? null
                  : controller.onNextButtonPressedEmail,
              style: Theme.of(context).brightness == Brightness.dark
                  ? MyDarkStyles.getAuthButtonStyle()
                  : MyStyles.getAuthButtonStyle(),
              child: const Text('Next'),
            ),
          ),
        ],
      ),
    );
  }
}
