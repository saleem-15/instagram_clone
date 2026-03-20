import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/app/models/profile.dart';
import 'package:instagram_clone/app/modules/profile/controllers/profile_controller.dart';
import 'package:instagram_clone/app/storage/my_shared_pref.dart';
import '../services/edit_profile_service.dart';
import '../services/get_profile_info_service.dart';

class EditProfileController extends GetxController {
  final Profile profile;
  EditProfileController({required this.profile});

  late final TextEditingController nickNameController;
  late final TextEditingController bioController;
  late final TextEditingController dobController;

  final isLoading = false.obs;

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
    final success = await editProfileService(
      nickName: nickNameController.text.trim(),
      bio: bioController.text.trim(),
      dateOfBirth: dobController.text.trim(),
    );

    if (success) {
      Get.back(); // close edit screen

      // Refresh the profile data
      if (Get.isRegistered<ProfileController>(tag: profile.userId)) {
        final pc = Get.find<ProfileController>(tag: profile.userId);
        pc.isLoading(true);
        pc.profile = await fetchProfileInfoService(profile.userId);
        pc.isLoading(false);
        pc.update(); // Force a rebuild if any GetBuilder is listening
      }
    } else {
      isLoading.value = false;
    }
  }
}
