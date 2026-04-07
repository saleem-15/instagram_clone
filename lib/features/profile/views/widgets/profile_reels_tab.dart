import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/shared/widgets/app_video_player.dart';

import '../../../../routes/app_pages.dart';
import '../../controllers/profile_reels_controller.dart';

class ProfileReelsTab extends StatelessWidget {
  final ProfileReelsTabController controller;

  const ProfileReelsTab({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.reels.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/camera_inside_circle.png',
                width: 120,
                color: Theme.of(context).iconTheme.color,
              ),
              const SizedBox(height: 16),
              Text(
                'No Reels Yet'.tr,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        );
      }

      return GridView.builder(
        padding: const EdgeInsets.all(2),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
          childAspectRatio: 9 / 16,
        ),
        itemCount: controller.reels.length,
        itemBuilder: (context, index) {
          final reel = controller.reels[index];
          return GestureDetector(
            onTap: () {
              Get.toNamed(Routes.REELS, arguments: {
                'reels': controller.reels.toList(),
                'index': index,
              });
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                AppVideoPlayer(
                  videoUrl: reel.reelMediaUrl,
                  isMuted: true,
                  isLooping: false,
                  showVolumeToggle: false,
                  showLoading: false,
                ),
                Positioned(
                  bottom: 5,
                  left: 5,
                  child: SvgPicture.asset(
                    'assets/icons/Reels.svg',
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                    width: 18.sp,
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
