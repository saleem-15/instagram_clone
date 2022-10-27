import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/post_bottom_sheet_controller.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class AddPostBottomSheet extends GetView<AddPostBottomSheetController> {
  const AddPostBottomSheet({Key? key}) : super(key: key);

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
          SizedBox(
            height: 12.sp,
          ),
          Text(
            'Create',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontSize: 18.sp),
          ),
          SizedBox(
            height: 8.sp,
          ),
          const Divider(),
          MyListTile(
            leading: const Icon(
              Icons.grid_4x4_outlined,
              color: Colors.black,
            ),
            title: const Text('Post'),
            onTap: controller.addPost,
            endsWithDivider: true,
          ),
          MyListTile(
            leading: const Icon(
              Icons.add_circle_outline,
              color: Colors.black,
            ),
            title: const Text('Story'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class MyListTile extends StatelessWidget {
  const MyListTile({
    Key? key,
    required this.leading,
    required this.title,
    this.endsWithDivider = false,
    required this.onTap,
  }) : super(key: key);

  final Widget leading;
  final Widget title;
  final bool endsWithDivider;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: SizedBox(
            height: 55,
            child: Row(
              children: [
                const SizedBox(
                  width: 16,
                ),
                leading,
                const SizedBox(
                  width: 22,
                ),
                title,
              ],
            ),
          ),
        ),
        if (endsWithDivider)
          const Divider(
            indent: 60,
            thickness: .1,
          ),
      ],
    );
  }
}
