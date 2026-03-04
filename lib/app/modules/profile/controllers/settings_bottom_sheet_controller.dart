import 'package:get/get.dart';
import 'package:instagram_clone/app/routes/app_pages.dart';
import 'package:instagram_clone/app/storage/my_shared_pref.dart';
import 'package:instagram_clone/utils/constants/api.dart';

class SettingsBottomSheetController extends GetxController {
  void logout() {
    MySharedPref.clearAllData();
    Api.authChanged();
    Get.offAllNamed(Routes.SIGN_IN);
  }
}
