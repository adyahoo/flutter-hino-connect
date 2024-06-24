part of 'i_use_case.dart';

abstract class IFaceRecognitionUseCase {
  Future<void> verifyDriverFace(File image);
  Future<PermissionStatus?> checkPermission();
  InputImage? inputImageFromCamera(CameraImage image, int? orientation, CameraDescription camera);
}
