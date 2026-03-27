import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnimatedLoveButton extends StatefulWidget {
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
  State<AnimatedLoveButton> createState() => _AnimatedLoveButtonState();
}

class _AnimatedLoveButtonState extends State<AnimatedLoveButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _animation = TweenSequence<double>([
      TweenSequenceItem(
          tween: Tween<double>(begin: 1.0, end: 1.2)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 50),
      TweenSequenceItem(
          tween: Tween<double>(begin: 1.2, end: 1.0)
              .chain(CurveTween(curve: Curves.easeIn)),
          weight: 50),
    ]).animate(_controller);

    if (widget.onInitAnimationController != null) {
      widget.onInitAnimationController!(_controller);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: const ValueKey('Love Button'),
      onPressed: widget.onHeartPressed,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      icon: ScaleTransition(
        scale: _animation,
        child: widget.isFavorite
            ? Stack(
                children: [
                  Transform.translate(
                    offset: const Offset(1, 1),
                    child: SvgPicture.asset(
                      'assets/icons/Heart (Filled).svg',
                      colorFilter: const ColorFilter.mode(
                        Colors.black12,
                        BlendMode.srcIn,
                      ),
                      width: widget.size.sp,
                      height: widget.size.sp,
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/icons/Heart (Filled).svg',
                    colorFilter: const ColorFilter.mode(
                      Colors.red,
                      BlendMode.srcIn,
                    ),
                    width: widget.size.sp,
                    height: widget.size.sp,
                  ),
                ],
              )
            : Stack(
                children: [
                  Transform.translate(
                    offset: const Offset(1, 1),
                    child: SvgPicture.asset(
                      'assets/icons/heart.svg',
                      colorFilter: const ColorFilter.mode(
                        Colors.black12,
                        BlendMode.srcIn,
                      ),
                      width: widget.size.sp,
                      height: widget.size.sp,
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/icons/heart.svg',
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).iconTheme.color ?? Colors.white,
                      BlendMode.srcIn,
                    ),
                    width: widget.size.sp,
                    height: widget.size.sp,
                  ),
                ],
              ),
      ),
    );
  }
}
