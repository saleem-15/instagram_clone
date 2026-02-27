import 'package:flutter/material.dart' hide SearchController;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:instagram_clone/app/models/user.dart';
import 'package:instagram_clone/app/shared/user_avatar.dart';

import '../controller/search_controller.dart';

class RecentSearchTile extends GetView<SearchController> {
  const RecentSearchTile({
    Key? key,
    required this.user,
    required this.index,
  }) : super(key: key);

  final User user;
  final int index;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      // onTap: () => controller.onRecentSearchTilePressed(controller.recentSearches[index]),
      leading: UserAvatar.follower(user: user),
      title: const Text('userName'),
      subtitle: const Text('name'),
      trailing: SizedBox(
        height: 30.sp,
        child: IconButton(
          onPressed: () => controller.deleteSuggestionAtIndex(index),
          icon: Icon(
            Icons.close,
            size: 15.sp,
          ),
        ),
      ),
    );
  }
}
