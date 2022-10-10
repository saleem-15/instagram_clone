// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:instagram_clone/config/theme/light_theme_colors.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    Key? key,
    required this.onEditingComplete,
    required this.textController,
  }) : super(key: key);

  final void Function() onEditingComplete;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 40.sp,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 15.sp, left: 10.w, right: 10.w),
          decoration: BoxDecoration(
            color: lightGrey,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 10.w,
              ),
              FaIcon(
                FontAwesomeIcons.magnifyingGlass,
                color: Theme.of(context).disabledColor,
                size: 15.sp,
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: TextField(
                  controller: textController,
                  textInputAction: TextInputAction.search,
                  onEditingComplete: onEditingComplete,
                  decoration: const InputDecoration.collapsed(hintText: 'Search'),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
