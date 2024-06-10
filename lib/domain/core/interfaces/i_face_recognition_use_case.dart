part of 'i_use_case.dart';

abstract class IFaceRecognitionUseCase {
  Future<UserModel> verifyDriverFace(File image);
  InputImage? inputImageFromCamera(CameraImage image, int? orientation, CameraDescription camera);
}
