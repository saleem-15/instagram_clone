import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:instagram_clone/app/models/reel.dart';
import 'package:instagram_clone/app/shared/loading_widget.dart';
import '../controllers/reels_controller.dart';
import 'reel_player_item_view.dart';

class ReelsView extends StatefulWidget {
  const ReelsView({super.key});

  @override
  State<ReelsView> createState() => _ReelsViewState();
}

class _ReelsViewState extends State<ReelsView> {
  late List<Reel> reels;
  late int initialIndex;
  late PageController pageController;
  int currentIndex = 0;
  bool isFromProfile = false;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args is Map) {
      reels = List<Reel>.from(args['reels'] as List);
      initialIndex = (args['index'] as int?) ?? 0;
      isFromProfile = true;
    } else if (args is Reel) {
      reels = [args];
      initialIndex = 0;
      isFromProfile = true;
    } else {
      isFromProfile = false;
      initialIndex = 0;
      reels = [];
    }
    currentIndex = initialIndex;
    pageController = PageController(initialPage: initialIndex);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isFromProfile) {
      return GetBuilder<ReelsController>(
        builder: (reelsController) {
          return Obx(() {
            if (reelsController.isLoading.value) {
              return Scaffold(
                primary: Navigator.canPop(context),
                body: const Center(child: LoadingWidget()),
              );
            }
            if (reelsController.reels.isEmpty) {
              return Scaffold(
                primary: Navigator.canPop(context),
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                body: Center(
                  child: Text('No Reels Yet',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge?.color)),
                ),
              );
            }

            reels = reelsController.reels.toList();
            return _buildPageView();
          });
        },
      );
    }
    return _buildPageView();
  }

  Widget _buildPageView() {
    return Scaffold(
      primary: Navigator.canPop(context),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            scrollDirection: Axis.vertical,
            itemCount: reels.length,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return ReelPlayerItemView(
                reel: reels[index],
                isCurrentPage: index == currentIndex,
              );
            },
          ),
          if (isFromProfile)
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                onPressed: () => Get.back(),
                icon:
                    const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              ),
            ),
        ],
      ),
    );
  }
}
