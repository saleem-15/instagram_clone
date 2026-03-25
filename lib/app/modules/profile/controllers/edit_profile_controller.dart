import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/app/models/profile.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/app/storage/my_shared_pref.dart';
import 'package:instagram_clone/app/modules/profile/controllers/profile_controller.dart';
import 'package:instagram_clone/app/modules/root/controllers/app_controller.dart';
import '../../../../utils/custom_snackbar.dart';
import '../services/edit_profile_service.dart';
import '../services/get_profile_info_service.dart';
import '../services/update_profile_image_service.dart';

class EditProfileController extends GetxController {
  final Profile profile;
  EditProfileController({required this.profile});

  late final TextEditingController nickNameController;
  late final TextEditingController bioController;
  late final TextEditingController dobController;

  final Rx<File?> selectedImage = Rx<File?>(null);

  final isLoading = false.obs;

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  @override
  void onInit() {
    nickNameController = TextEditingController(text: profile.nickName);
    bioController = TextEditingController(text: profile.bio ?? '');

    // Fallback to locally stored birthday if the profile API payload doesn't provide it
    final defaultDob =
        profile.dateOfBirth ?? MySharedPref.getUserDateOfBirth ?? '';
    dobController = TextEditingController(text: defaultDob);

    super.onInit();
  }

  @override
  void onClose() {
    nickNameController.dispose();
    bioController.dispose();
    dobController.dispose();
    super.onClose();
  }

  Future<void> submit() async {
    isLoading.value = true;

    // First update the multi-part image, if a new one was selected
    if (selectedImage.value != null) {
      await updateProfileImageService(selectedImage.value!);
    }

    final success = await editProfileService(
      nickName: nickNameController.text.trim(),
      bio: bioController.text.trim(),
      dateOfBirth: dobController.text.trim(),
    );

    if (success) {
      Get.back(); // close edit screen
      CustomSnackBar.showCustomSnackBar(
        message: 'Profile updated successfully!',
      );

      // Refresh the profile data
      if (Get.isRegistered<ProfileController>(tag: profile.userId)) {
        final pc = Get.find<ProfileController>(tag: profile.userId);
        pc.isLoading(true);
        pc.profile = await fetchProfileInfoService(profile.userId);

        // Critically propagate the freshly updated photo back onto the legacy User property
        pc.user.image = pc.profile.image;
        if (pc.isMyProfile) {
          MySharedPref.setUserImage(pc.profile.image);
          if (Get.isRegistered<AppController>()) {
            Get.find<AppController>().myUser.image = pc.profile.image;
            Get.find<AppController>().userImage.value = pc.profile.image ?? '';
          }
        }

        pc.isLoading(false);
        pc.update(); // Force a rebuild if any GetBuilder is listening
      }
    } else {
      isLoading.value = false;
    }
  }
}
