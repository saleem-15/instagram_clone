// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:instagram_clone/config/theme/light_theme_colors.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    Key? key,
    required this.textController,
    required this.onEditingComplete,
    this.onTap,
    this.onCancelButtonPressed,
    this.isReadOnly = false,
    this.focusNode,
    this.showSearchIcon = true,
    this.showCancelButton = false,
  }) : super(key: key);

  final TextEditingController textController;
  final void Function() onEditingComplete;
  final void Function()? onTap;
  final void Function()? onCancelButtonPressed;
  final bool isReadOnly;
  final FocusNode? focusNode;
  final bool showSearchIcon;
  final bool showCancelButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 37.sp,
          // width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 15.sp, left: 10.w, right: 10.w),
          decoration: BoxDecoration(
            color: LightThemeColors.lightGrey,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 10.w,
              ),
              if (showSearchIcon)
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
                  focusNode: focusNode,
                  onTap: onTap,
                  controller: textController,
                  textInputAction: TextInputAction.search,
                  onEditingComplete: onEditingComplete,
                  readOnly: isReadOnly,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Search',
                    hintStyle: TextStyle(fontSize: 16.sp),
                  ),
                ),
              ),
              if (showCancelButton)
                IconButton(
                  onPressed: onCancelButtonPressed,
                  splashColor: Colors.transparent,
                  icon: Icon(
                    Icons.close,
                    size: 18.sp,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
