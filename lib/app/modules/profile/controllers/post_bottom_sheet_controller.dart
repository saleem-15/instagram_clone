import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../services/add_post_service.dart';
import 'package:instagram_clone/app/modules/reels/controllers/reels_controller.dart';
import 'package:instagram_clone/app/modules/reels/services/reels_service.dart';

class AddPostBottomSheetController extends GetxController {
  Future<void> addPost() async {
    final picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();
    final mediaFiles = images.map((e) => File(e.path)).toList();

    addPostService(mediaFiles);
  }

  Future<void> addReel() async {
    final picker = ImagePicker();
    final XFile? video = await picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      Get.back();
      final file = File(video.path);
      if (Get.isRegistered<ReelsController>()) {
        await Get.find<ReelsController>().uploadReel(file);
      } else {
        await ReelsService.uploadReel(file);
      }
    }
  }
}
