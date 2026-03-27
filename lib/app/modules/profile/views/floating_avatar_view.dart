import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_clone/app/models/user.dart';

class FloatingAvatarView extends StatelessWidget {
  final User user;
  const FloatingAvatarView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final ImageProvider backgroundImage = (user.image == null
        ? const AssetImage('assets/images/default_user_image.png')
        : CachedNetworkImageProvider(user.image!)) as ImageProvider;

    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          color:
              Colors.white.withAlpha(3), // Changed from withValues to withAlpha
          child: Center(
            child: CircleAvatar(
              radius: 110.sp,
              backgroundColor: Colors.transparent,
              backgroundImage:
                  const AssetImage('assets/images/default_user_image.png'),
              foregroundImage: backgroundImage,
              onForegroundImageError: (exception, stackTrace) {
                debugPrint(
                    'User Avatar Image error: ${user.image} \n $exception');
              },
            ),
          ),
        ),
      ),
    );
  }
}
