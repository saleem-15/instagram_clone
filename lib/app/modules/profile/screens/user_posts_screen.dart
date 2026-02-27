// import 'package:flutter/material.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

// import 'package:instagram_clone/app/models/post.dart';
// import 'package:instagram_clone/app/modules/posts/views/post_view.dart';

// import '../controllers/user_posts_controller.dart';

// class UserPostsScreen extends GetView<UserPostsController> {
//   const UserPostsScreen({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Posts'),
//       ),
//       body: PagedListView<int, Post>(
//         pagingController: controller.pagingController,
//         builderDelegate: PagedChildBuilderDelegate(
//           itemBuilder: (context, post, index) {
//             return Padding(
//               padding: EdgeInsets.only(bottom: 3.sp),
//               child: PostView(
//                 post: post,
//               ),
//             );
//           },
//           firstPageErrorIndicatorBuilder: (context) =>
//               Text(controller.pagingController.error.toString()),
//           noItemsFoundIndicatorBuilder: (context) => Center(
//             child: Text(
//               'No Posts was Found'.tr,
//               style: Theme.of(context).textTheme.titleLarge,
//             ),
//           ),
//           newPageErrorIndicatorBuilder: (context) => const Text('coludnt load'),
//         ),
//       ),
//     );
//   }
// }
