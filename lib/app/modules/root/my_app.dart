import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:instagram_clone/app/modules/root/controllers/app_controller.dart';

/// this is parent of the all app (Except all auth related screens)
class MyApp extends GetView<AppController> {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: false,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          /// to remove the splash effect when clicking on a [BottomNavigationBarItem]
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Obx(
          () => BottomNavigationBar(
            iconSize: 25.sp,
            currentIndex: controller.selectedIndex.value,
            onTap: (index) => controller.selectedIndex(index),
            unselectedFontSize: 0, // <-- for NOT saving space for the label
            selectedFontSize: 0, // <-- for NOT saving space for the labe
            items: [
              BottomNavigationBarItem(
                icon: Obx(() => SvgPicture.asset(
                      controller.selectedIndex.value == 0
                          ? 'assets/icons/Home (Filled).svg'
                          : 'assets/icons/Home.svg',
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).iconTheme.color!,
                        BlendMode.srcIn,
                      ),
                      width: 25.sp,
                    )),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Obx(() => SvgPicture.asset(
                      controller.selectedIndex.value == 1
                          ? 'assets/icons/Search (Filled).svg'
                          : 'assets/icons/Search.svg',
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).iconTheme.color!,
                        BlendMode.srcIn,
                      ),
                      width: 25.sp,
                    )),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Obx(() => SvgPicture.asset(
                      controller.selectedIndex.value == 2
                          ? 'assets/icons/Reels (Filled).svg'
                          : 'assets/icons/Reels.svg',
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).iconTheme.color!,
                        BlendMode.srcIn,
                      ),
                      width: 25.sp,
                    )),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Obx(() {
                  final img = controller.userImage.value;
                  final isSelected = controller.selectedIndex.value == 3;
                  return Container(
                    padding: EdgeInsets.all(isSelected ? 1.sp : 0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: isSelected
                          ? Border.all(
                              color: Theme.of(context).iconTheme.color!,
                              width: 2.sp,
                            )
                          : null,
                    ),
                    child: img.isEmpty
                        ? Icon(isSelected ? Icons.person : Icons.person_outline)
                        : CircleAvatar(
                            radius: 12.sp,
                            backgroundColor: Colors.transparent,
                            backgroundImage: NetworkImage(img),
                          ),
                  );
                }),
                label: '',
              ),
            ],
          ),
        ),
      ),
      body: Obx(
        () {
          controller.selectedIndex.value;
          return controller.selectedScreen;
        },
      ),
    );
  }
}


/// count down UI tester
/*
Scaffold(
        appBar: AppBar(
          title: const Text('timer'),
        ),
        body: Column(
          children: [
            const Text(''),
            ElevatedButton(
              onPressed: () {
                counter.startTimer();
              },
              child: const Text('start timer'),
            ),
            ElevatedButton(
              onPressed: () {
                counter.pauseCountDown();
              },
              child: const Text('pause'),
            ),
            ElevatedButton(
              onPressed: () {
                counter.resumeCountDown();
              },
              child: const Text('Resume'),
            ),
          ],
        ),
      ),
*/

/// video player
/*
// final appController = Get.find<AppController>();
    VideoPlayerController video = VideoPlayerController.network(
        'https://jsoncompare.org/LearningContainer/SampleFiles/Video/MP4/sample-mp4-file.mp4');

    return Scaffold(
      appBar: AppBar(
        title: const Text('timer'),
      ),
      body: Column(
        children: [
          SizedBox(
            width: 400,
            height: 300,
            child: VideoPlayer(video),
          ),
          ElevatedButton(
            onPressed: () async {
              await video.initialize();
              video.play();
            },
            child: const Text('start'),
          ),
          ElevatedButton(
            onPressed: () {
              video.pause();
            },
            child: const Text('pause'),
          ),
          ElevatedButton(
            onPressed: () {
              video.play();
            },
            child: const Text('Resume'),
          ),
        ],
      ),
    );
*/