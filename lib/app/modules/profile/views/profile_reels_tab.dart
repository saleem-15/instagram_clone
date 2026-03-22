import 'package:flutter/material.dart';
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
        return const Center(child: Text('No reels yet'));
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
                const Positioned(
                  bottom: 5,
                  left: 5,
                  child: Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 20,
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
