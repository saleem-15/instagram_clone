import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/config/theme/light_theme_colors.dart';

import '../controllers/settings_bottom_sheet_controller.dart';

class SettingsBottomSheet
    extends GetView<SettingsBottomSheetController> {
  const SettingsBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          SizedBox(
            height: 12.sp,
          ),
          Container(
            width: 40.sp,
            height: 3.sp,
            decoration: BoxDecoration(
              color: Colors.grey.shade600,
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          ListTile(
            onTap: controller.logout,
            title: Text(
              'Logout',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: LightThemeColors.lightBlue,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
