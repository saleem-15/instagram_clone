import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnimatedLoveButton extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onHeartPressed;
  final void Function(AnimationController)? onInitAnimationController;
  final double size;

  const AnimatedLoveButton({
    super.key,
    required this.isFavorite,
    required this.onHeartPressed,
    this.onInitAnimationController,
    this.size = 26,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: const ValueKey('Love Button'),
      onPressed: onHeartPressed,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      icon: Pulse(
        duration: const Duration(milliseconds: 600),
        curve: Curves.bounceInOut,
        controller: (animationController) {
          if (onInitAnimationController != null) {
            onInitAnimationController!(animationController);
          }
        },
        child: isFavorite
            ? SvgPicture.asset(
                'assets/icons/Heart (Filled).svg',
                colorFilter: const ColorFilter.mode(
                  Colors.red,
                  BlendMode.srcIn,
                ),
                width: size.sp,
                height: size.sp,
              )
            : SvgPicture.asset(
                'assets/icons/heart.svg',
                colorFilter: ColorFilter.mode(
                  Theme.of(context).iconTheme.color ?? Colors.white,
                  BlendMode.srcIn,
                ),
                width: size.sp,
                height: size.sp,
              ),
      ),
    );
  }
}
