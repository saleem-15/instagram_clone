import 'package:flutter/material.dart' hide SearchController;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/app/models/user.dart';
import 'package:instagram_clone/app/modules/search/controller/search_controller.dart';
import 'package:instagram_clone/app/shared/user_avatar.dart';

class SearchResultTile extends GetView<SearchController> {
  const SearchResultTile({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data:
          Theme.of(context).copyWith(splashColor: Colors.transparent),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
        onTap: () => controller.onSearchResultPressed(user),
        leading: SizedBox(
          width: 50.sp,
          child: UserAvatar.follower(
            user: user,
          ),
        ),
        title: Text(user.userName),
        subtitle: Text(user.nickName),
      ),
    );
  }
}
