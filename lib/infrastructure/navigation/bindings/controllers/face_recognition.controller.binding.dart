import 'package:get/get.dart';

import '../../../../presentation/screens/face_recognition/controllers/face_recognition.controller.dart';

class FaceRecognitionControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FaceRecognitionController>(
      () => FaceRecognitionController(),
    );
  }
}
