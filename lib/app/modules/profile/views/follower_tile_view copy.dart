import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:instagram_clone/app/shared/user_avatar.dart';
import 'package:instagram_clone/config/theme/light_theme_colors.dart';

class FollowerTileView extends GetView {
  const FollowerTileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const UserAvatar(),
      title: const Text('userName'),
      subtitle: const Text('name'),
      trailing: SizedBox(
        height: 30.sp,
        child: ElevatedButton(
          onPressed: () {},
          child: const Text(
            'Remove',
            style: TextStyle(color: LightThemeColors.buttonTextColor),
          ),
        ),
      ),
    );
  }
}
