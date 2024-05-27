import 'package:camera/camera.dart';
import 'package:get/get.dart';

class FaceRecognitionController extends GetxController {
  late CameraController cameraController;

  Future<void> initCamera() async {
    final _cameras = await availableCameras();

    cameraController = CameraController(
      _cameras[1],
      ResolutionPreset.medium,
    );

    await cameraController.initialize();
  }

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
    cameraController.dispose();
  }
}
