import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:instagram_clone/app/modules/root/controllers/app_controller.dart';

/// this is parent of the all app (Except all auth related screens) 
class MyApp extends GetView<AppController> {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final appController = Get.find<AppController>();
    return Scaffold(
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
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.add,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
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
