import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../services/add_post_service.dart';

class AddPostBottomSheetController extends GetxController {
  addPost() async {
    final picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();
    final mediaFiles = images.map((e) => File(e.path)).toList();

    addPostService(mediaFiles);
  }
}
