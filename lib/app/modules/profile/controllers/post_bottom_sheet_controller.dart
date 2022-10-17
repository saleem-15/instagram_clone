import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddPostBottomSheetController extends GetxController {
  goToaddPostView() async {
    final picker = ImagePicker();
  final List<XFile> images = await  picker.pickMultiImage();

  

  }
}
