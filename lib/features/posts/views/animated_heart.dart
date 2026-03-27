import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnimatedHeart extends StatelessWidget {
  const AnimatedHeart({super.key});

  @override
  Widget build(BuildContext context) {
    final iconSize = 90.sp;
    return ElasticIn(
      duration: const Duration(milliseconds: 900),
      child: Stack(
        children: [
          Center(
            child: SvgPicture.asset(
              'assets/icons/Heart (Filled).svg',
              colorFilter: const ColorFilter.mode(
                Color.fromARGB(15, 0, 0, 0),
                BlendMode.srcIn,
              ),
              width: iconSize + 10.sp,
              height: iconSize + 10.sp,
            ),
          ),
          Center(
            child: SvgPicture.asset(
              'assets/icons/Heart (Filled).svg',
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
              width: iconSize,
              height: iconSize,
            ),
          ),
        ],
      ),
    );
  }
}
