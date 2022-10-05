import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:instagram_clone/app/modules/auth/controllers/signup_controller.dart';
import 'package:instagram_clone/config/theme/my_styles.dart';

class EmailAddressView extends GetView<SignupController> {
  const EmailAddressView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final verticalSpace = 15.h;

    return Column(
      children: [
        TextFormField(
          controller: controller.emailController,
          validator: controller.emailFieldValidator,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            hintText: 'Email Address',
          ),
        ),
        SizedBox(
          height: verticalSpace,
        ),
        Obx(
          () => ElevatedButton(
            onPressed: controller.isEmailButtonDisable.isTrue ? null : controller.onNextButtonPressedEmail,
            style: MyStyles.getAuthButtonStyle(),
            child: const Text('Next'),
          ),
        ),
      ],
    );
  }
}
