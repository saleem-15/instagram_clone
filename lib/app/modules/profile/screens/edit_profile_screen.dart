import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/config/theme/dark_theme_colors.dart';
import 'package:instagram_clone/config/theme/light_theme_colors.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileScreen extends GetView<EditProfileController> {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: Navigator.canPop(context),
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          Obx(
            () => controller.isLoading.value
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.only(right: 15.0),
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  )
                : IconButton(
                    icon: Icon(Icons.check,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? DarkThemeColors.authButtonColor
                            : LightThemeColors.lightBlue,
                        size: 30),
                    onPressed: controller.submit,
                  ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.sp),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: controller.pickImage,
                child: Obx(() => CircleAvatar(
                      radius: 50.sp,
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? DarkThemeColors.lightGrey
                              : Colors.grey.shade200,
                      backgroundImage: controller.selectedImage.value != null
                          ? FileImage(controller.selectedImage.value!)
                              as ImageProvider
                          : (controller.profile.image != null
                              ? CachedNetworkImageProvider(controller.profile.image!)
                                  as ImageProvider
                              : const AssetImage(
                                      'assets/images/default_user_image.png')
                                  as ImageProvider),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                          radius: 16.sp,
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.dark
                                  ? DarkThemeColors.authButtonColor
                                  : LightThemeColors.lightBlue,
                          child: Icon(Icons.camera_alt,
                              color: Colors.white, size: 18.sp),
                        ),
                      ),
                    )),
              ),
              SizedBox(height: 24.sp),
              _buildTextField(
                controller: controller.nickNameController,
                label: 'Name',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Name cannot be empty';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.sp),
              _buildTextField(
                controller: controller.bioController,
                label: 'Bio',
              ),
              SizedBox(height: 16.sp),
              _buildTextField(
                controller: controller.dobController,
                label: 'Date of Birth (dd/mm/yyyy)',
                readOnly: true,
                onTap: () => controller.selectDate(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool readOnly = false,
    VoidCallback? onTap,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: label,
        border: const UnderlineInputBorder(),
      ),
    );
  }
}
