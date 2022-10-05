import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/config/theme/light_theme_colors.dart';

import '../controllers/signup_controller.dart';
import '../views/email_address_view.dart';
import '../views/phone_num_view.dart';

class SignupScreen extends GetView<SignupController> {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = 15.w;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(),
        bottomNavigationBar: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 50.sp,
          child: Column(
            children: [
              const Divider(),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?  ',
                      style:
                          Theme.of(context).textTheme.bodyText2!.copyWith(color: Theme.of(context).hintColor),
                    ),
                    GestureDetector(
                      onTap: controller.goToLogIn,
                      child: Text(
                        'Log in',
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
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              right: horizontalPadding,
              left: horizontalPadding,
              top: 15.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FaIcon(
                  FontAwesomeIcons.user,
                  size: 60.sp,
                ),
                SizedBox(
                  height: 40.sp,
                ),
                TabBar(
                  labelStyle: Theme.of(context).textTheme.bodyText2,
                  tabs: const [
                    Tab(
                      child: Text('PHONE NUMBER'),
                    ),
                    Tab(
                      child: Text('EMAIL ADDRESS'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.sp,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 500,
                  child: const TabBarView(
                    children: [
                      PhoneNumView(),
                      EmailAddressView(),
                    ],
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
