import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class BsImagePickerController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  //TODO: upload image still haven't implemented
  Future<void> onClickCamera() async {
    var status = await Permission.camera.status;
    print('status: $status');
    if (!status.isGranted) {
      status = await Permission.camera.request();
    }
    if (status.isGranted) {
      try {
        final pickedFile =
            await ImagePicker().pickImage(source: ImageSource.camera);
        if (pickedFile != null) {
          Get.back(result: pickedFile);
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  Future<void> onClickGallery() async {
    var status = await Permission.photos.status;
    if (!status.isGranted) {
      status = await Permission.photos.request();
    }
    if (status.isGranted) {
      try {
        final pickedFile =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          Get.back(result: pickedFile);
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }
}

