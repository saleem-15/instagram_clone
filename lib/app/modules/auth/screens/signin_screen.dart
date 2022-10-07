import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/config/theme/light_theme_colors.dart';
import 'package:instagram_clone/config/theme/my_styles.dart';

import '../controllers/signin_controller.dart';

// ignore_for_file: prefer_const_constructors

class SigninScreen extends GetView<SigninController> {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxBool isShowPassword = false.obs;

    /// vertical space between feilds && vertical space last feild and the button
    final verticalSpace = 15.h;

    /// padding for the form
    final horizontalPadding = 20.w;
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
      ),
      bottomNavigationBar: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 50.sp,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Divider(),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?  ',
                    style:
                        Theme.of(context).textTheme.bodyText2!.copyWith(color: Theme.of(context).hintColor),
                  ),
                  GestureDetector(
                    onTap: controller.goToSignup,
                    child: Text(
                      'Sign up',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: LightThemeColors.authButtonColor.withOpacity(.6)),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              children: [
                Image.asset(
                  'assets/icons/instagram-word-logo-removebg.png',
                  width: 150.sp,
                ),
                SizedBox(
                  height: 20.sp,
                ),
                Form(
                  key: controller.formKey,
                  // the textField is wrapped in (theme) so when the textField has Focus the icon color
                  //(in the textField) change to my specific color
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller.firstFieledController,
                        validator: controller.emailFieldValidator,
                        textInputAction: TextInputAction.next, // Moves focus to next field
                        decoration: InputDecoration(
                          hintText: 'Phone number, email address or username',
                        ),
                      ),
                      SizedBox(
                        height: verticalSpace,
                      ),
                      Obx(
                        () => TextFormField(
                          controller: controller.passwordController,
                          validator: controller.passwordFieldValidator,
                          obscureText: isShowPassword.isTrue,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            suffixIcon: IconButton(
                              splashRadius: 5,
                              onPressed: () => isShowPassword.toggle(),
                              icon: isShowPassword.isTrue
                                  ? FaIcon(
                                      FontAwesomeIcons.eye,
                                      color: LightThemeColors.authButtonColor,
                                      size: 15.sp,
                                    )
                                  : FaIcon(
                                      FontAwesomeIcons.eyeSlash,
                                      color: Theme.of(context).disabledColor,
                                      size: 15.sp,
                                    ),
                            ),
                          ),
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
                    onPressed: controller.isButtonDisable.isTrue ? null : controller.logIn,
                    style: MyStyles.getAuthButtonStyle(),
                    child: const Text('Log in'),
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
