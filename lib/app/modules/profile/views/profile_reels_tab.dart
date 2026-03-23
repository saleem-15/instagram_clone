import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/app/shared/posts_grid/views/post_grid_tile.dart';

import '../../../routes/app_pages.dart';
import '../controllers/profile_reels_controller.dart';

class ProfileReelsTab extends StatelessWidget {
  final ProfileReelsController controller;

  const ProfileReelsTab({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.isError.value) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Error loading reels'),
              TextButton(
                onPressed: controller.fetchUserReels,
                child: const Text('Retry'),
              )
            ],
          ),
        );
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
              Get.toNamed(Routes.SINGLE_REEL, arguments: reel);
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                VideoThumbnail(
                  videoUrl: reel.reelMediaUrl,
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
