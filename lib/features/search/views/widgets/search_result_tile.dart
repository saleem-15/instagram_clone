import 'package:flutter/material.dart' hide SearchController;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/models/user.dart';
import 'package:instagram_clone/features/search/controllers/search_controller.dart';
import 'package:instagram_clone/shared/user_avatar.dart';

class SearchResultTile extends GetView<SearchController> {
  const SearchResultTile({
    super.key,
    required this.user,
  });

  final User user;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(splashColor: Colors.transparent),
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
