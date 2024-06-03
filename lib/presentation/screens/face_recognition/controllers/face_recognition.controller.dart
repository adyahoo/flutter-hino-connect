import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hino_driver_app/domain/core/usecases/face_recognition_use_case.dart';
import 'package:hino_driver_app/infrastructure/di.dart';
import 'package:hino_driver_app/infrastructure/navigation/routes.dart';
import 'package:hino_driver_app/infrastructure/utils.dart';

class FaceRecognitionController extends GetxController {
  FaceRecognitionController({required this.useCase});

  FaceRecognitionUseCase useCase;

  late CameraController cameraController;

  XFile? imageFile;

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

  void captureFace() async {
    showLoadingOverlay();

    try {
      imageFile = await cameraController.takePicture();
      final file = File(imageFile?.path ?? "");

      useCase.verifyDriverFace(file);

    } catch (e) {
      print('Error capturing face: $e');
      hideLoadingOverlay();
    }
  }
}
