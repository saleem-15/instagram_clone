import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    this.size = 20,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: const ValueKey('Love Button'),
      onPressed: onHeartPressed,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      icon: Pulse(
        duration: const Duration(milliseconds: 300),
        controller: (animationController) {
          if (onInitAnimationController != null) {
            onInitAnimationController!(animationController);
          }
        },
        child: isFavorite
            ? FaIcon(
                FontAwesomeIcons.solidHeart,
                color: Colors.red,
                size: size.sp,
              )
            : FaIcon(
                FontAwesomeIcons.heart,
                color: Colors.white,
                size: size.sp,
              ),
      ),
    );
  }
}
