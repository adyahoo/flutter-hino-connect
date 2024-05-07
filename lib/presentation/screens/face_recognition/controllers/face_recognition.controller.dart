import 'package:camera/camera.dart';
import 'package:get/get.dart';

class FaceRecognitionController extends GetxController {
  CameraController? cameraController;

  void initCamera() async {
    final _cameras = await availableCameras();

    cameraController = CameraController(_cameras[0], ResolutionPreset.max);
  }

  @override
  void onInit() {
    super.onInit();
    initCamera();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    cameraController?.dispose();
  }
}
