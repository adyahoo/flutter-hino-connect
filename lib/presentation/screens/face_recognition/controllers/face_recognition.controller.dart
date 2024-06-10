import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hino_driver_app/domain/core/usecases/face_recognition_use_case.dart';
import 'package:hino_driver_app/infrastructure/client/exceptions/ApiException.dart';
import 'package:hino_driver_app/infrastructure/utils.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class FaceRecognitionController extends GetxController {
  FaceRecognitionController({required this.useCase});

  FaceRecognitionUseCase useCase;

  late CameraController cameraController;
  late FaceDetector _faceDetector;

  bool _canProcess = true;
  bool _isBusy = false;
  XFile? imageFile;
  List<CameraDescription> _cameras = [];
  final _orientations = {
    DeviceOrientation.portraitUp: 0,
    DeviceOrientation.landscapeLeft: 90,
    DeviceOrientation.portraitDown: 180,
    DeviceOrientation.landscapeRight: 270,
  };

  Future<void> initCamera() async {
    _cameras = await availableCameras();

    cameraController = CameraController(
      _cameras[1],
      ResolutionPreset.medium,
      imageFormatGroup: ImageFormatGroup.nv21,
    );

    _initFaceDetector();
    await cameraController.initialize();
    _startImageStream();
  }

  void _initFaceDetector() {
    _faceDetector = FaceDetector(options: FaceDetectorOptions());
  }

  void _startImageStream() {
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        cameraController.startImageStream(_processCameraImage);
      },
    );
  }

  void _stopImageStream() {
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        cameraController.stopImageStream();
      },
    );
  }

  void _processCameraImage(CameraImage image) {
    final inputImage = useCase.inputImageFromCamera(image, _orientations[cameraController.value.deviceOrientation], _cameras[1]);
    if (inputImage == null) return;

    _processImage(inputImage);
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;

    final faces = await _faceDetector.processImage(inputImage);

    // if (inputImage.metadata?.size != null && inputImage.metadata?.rotation != null) {
    //check if any faces detected
    if (faces.isNotEmpty) {
      for (Face face in faces) {
        //check if face alreaady cover the overlay or not
        if (face.boundingBox.size.width >= 240) {
          _stopImageStream();
          await _captureFace();
        }
      }
    }

    _isBusy = false;
  }

  @override
  void onClose() {
    super.onClose();
    cameraController.dispose();
    _faceDetector.close();
  }

  Future<void> _captureFace() async {
    _isBusy = true;
    showLoadingOverlay();

    try {
      await Future.delayed(const Duration(seconds: 1));
      imageFile = await cameraController.takePicture();
      final file = File(imageFile?.path ?? "");

      try {
        await useCase.verifyDriverFace(file);
        cameraController.dispose();

        hideLoadingOverlay();
        Get.back();
      } on ApiException catch (e) {
        print('Error capturing face: $e');
        _isBusy = false;
        hideLoadingOverlay();
        errorHandler(
          e,
          onDismiss: () {
            _startImageStream();
          },
        );
      }
    } catch (e) {
      _isBusy = false;
      print('Error capturing face: $e');
      hideLoadingOverlay();
    }
  }
}
