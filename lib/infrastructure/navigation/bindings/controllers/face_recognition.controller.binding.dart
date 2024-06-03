import 'package:get/get.dart';
import 'package:hino_driver_app/infrastructure/di.dart';

import '../../../../presentation/screens/face_recognition/controllers/face_recognition.controller.dart';

class FaceRecognitionControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FaceRecognitionController>(
      () => FaceRecognitionController(useCase: inject()),
    );
  }
}
