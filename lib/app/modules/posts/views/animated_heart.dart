import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedHeart extends StatelessWidget {
  const AnimatedHeart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconSize = 90.sp;
    return ElasticIn(
      duration: const Duration(milliseconds: 900),
      // from: 1.5,
      // manualTrigger: true,
      // controller: AnimationController(duration: Duration(milliseconds: 600),vsync: ),
      child: Stack(
        children: [
          Center(
            child: Icon(
              Icons.favorite_rounded,
              color: const Color.fromARGB(15, 0, 0, 0),
              size: iconSize + 10.sp,
            ),
          ),
          Center(
            child: Icon(
              Icons.favorite_rounded,
              color: Colors.white,
              size: iconSize,
            ),
          ),
        ],
      ),
    );
  }
}
