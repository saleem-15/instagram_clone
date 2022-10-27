import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:instagram_clone/app/modules/auth/controllers/signup_controller.dart';
import 'package:instagram_clone/config/theme/my_styles.dart';

class PhoneNumView extends GetView<SignupController> {
  const PhoneNumView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final verticalSpace = 15.h;

    return Column(
      children: [
        Theme(
          data: Theme.of(context).copyWith(
            inputDecorationTheme: MyStyles.getInputDecorationTheme(),
            colorScheme: ThemeData().colorScheme.copyWith(
                  primary: Theme.of(context).iconTheme.color,
                ),
          ),
          child: Column(
            children: [
              TextFormField(
                controller: controller.phoneNumberController,
                validator: controller.phoneNumberValidator,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Phone number',
                  prefixIconConstraints: const BoxConstraints(
                    maxWidth: 100,
                    maxHeight: 30,
                  ),
                  prefixIcon: Container(
                    width: 70.sp,
                    height: 30,
                    padding: EdgeInsets.only(left: 5.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'IL +972 ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Theme.of(context).disabledColor),
                        ),
                        const SizedBox(
                          height: 40,
                          child: VerticalDivider(
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: verticalSpace,
              ),
              Text(
                'You may recieve SMS notifications from us for security and login purposes',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: 12.sp,
                      color: Theme.of(context).disabledColor,
                    ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: verticalSpace,
        ),
        Obx(
          () => ElevatedButton(
            onPressed: controller.isPhoneButtonDisable.isTrue
                ? null
                : controller.onNextButtonPressedPhoneNumber,
            style: MyStyles.getAuthButtonStyle(),
            child: const Text('Next'),
          ),
        ),
      ],
    );
  }
}
