import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hino_driver_app/domain/core/usecases/face_recognition_use_case.dart';
import 'package:hino_driver_app/domain/core/usecases/vehicle_scan_use_case.dart';
import 'package:hino_driver_app/infrastructure/client/exceptions/ApiException.dart';
import 'package:hino_driver_app/infrastructure/navigation/routes.dart';
import 'package:hino_driver_app/infrastructure/utils.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:hino_driver_app/presentation/screens.dart';

class FaceRecognitionController extends GetxController {
  FaceRecognitionController({required this.useCase, required this.vehicleScanUseCase});

  FaceRecognitionUseCase useCase;
  VehicleScanUseCase vehicleScanUseCase;

  late CameraController cameraController;
  late FaceDetector _faceDetector;

  final text = ''.obs;
  final loadingValue = 0.0.obs;
  final isScanning = false.obs;
  final faces = Rx<List<Face>>([]);
  final capturedImage = Rx<File?>(null);
  final capturedImageBytes = Rx<Uint8List?>(null);
  final isManual = false.obs;

  Timer? _manualCaptureTimer;
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

  @override
  onReady() {
    super.onReady();
    _startManualCaptureTimer();
  }

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

  void _startManualCaptureTimer() {
    final duration = const Duration(seconds: 6);
    _manualCaptureTimer = Timer(duration, () {
      _stopImageStream();
      isManual.value = true;
      isScanning.value = false;
    });
  }

  void _stopManualCaptureTimer() {
    _manualCaptureTimer?.cancel();
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
    this.faces.value = faces;

    // if (inputImage.metadata?.size != null && inputImage.metadata?.rotation != null) {
    //check if any faces detected
    if (faces.isNotEmpty) {
      for (Face face in faces) {
        //check if face alreaady cover the overlay or not
        final width = face.boundingBox.size.width >= 150;
        final top = face.boundingBox.top >= 100;
        final bottom = face.boundingBox.bottom <= 320;
        final right = face.boundingBox.right >= 300;
        final left = face.boundingBox.left <= 170;

        // text.value = "${face.boundingBox.top} ${face.boundingBox.bottom} ${face.boundingBox.right} ${face.boundingBox.left} ${face.boundingBox.size.width}";
        if (width && top && right && bottom & left) {
          isScanning.value = true;

          _stopManualCaptureTimer();
          await Future.delayed(const Duration(milliseconds: 500));
          _stopImageStream();
          await _captureFace();
        }
      }
    }

    _isBusy = false;
  }

  Future<void> _captureFace() async {
    _isBusy = true;

    try {
      //capture image
      await Future.delayed(const Duration(seconds: 1));
      imageFile = await cameraController.takePicture();
      final file = File(imageFile?.path ?? "");
      capturedImage.value = file;

      //get croped image with circle masking
      final capturedFile = await useCase.getMaskedImage();

      try {
        await useCase.verifyDriverFace(capturedFile);
        loadingValue.value = 1.0;

        await Future.delayed(const Duration(milliseconds: 500));
        // Show the success dialog
        _showSuccessDialog();

        // Close the dialog after 3 seconds and navigate to the Scan QR page
        _navigateScanVehicle();

        // Get.back();
      } on ApiException catch (e) {
        _isBusy = false;
        loadingValue.value = 0.0;
        isScanning.value = false;

        errorHandler(
          e,
          onDismiss: () {
            _startManualCaptureTimer();
            _startImageStream();
          },
        );
      }
    } catch (e) {
      _isBusy = false;
      isScanning.value = false;
      _startManualCaptureTimer();
      loadingValue.value = 0.0;
    }
  }

  void captureFaceManual() async {
    _showLoadingDialog();
    _isBusy = true;

    try {
      //capture image
      await Future.delayed(const Duration(seconds: 1));
      imageFile = await cameraController.takePicture();
      final file = File(imageFile?.path ?? "");
      capturedImage.value = file;

      //get croped image with circle masking
      await Future.delayed(const Duration(seconds: 1));
      final capturedFile = await useCase.getMaskedImage();

      try {
        await useCase.verifyDriverFace(capturedFile);
        loadingValue.value = 1.0;

        Get.back();
        await Future.delayed(const Duration(milliseconds: 500));
        // Show the success dialog
        _showSuccessDialog();

        // Close the dialog after 3 seconds and navigate to the Scan QR page
        _navigateScanVehicle();
      } on ApiException catch (e) {
        _isBusy = false;

        errorHandler(e);
      }
    } catch (e) {
      _isBusy = false;
    }
  }

  void _showSuccessDialog() {
    Get.dialog(
      FaceDetectedDialog(
        name: "face_id_success.json",
        title: "face_detected_successfully".tr,
      ),
      barrierDismissible: false, // Prevent closing the dialog by tapping outside
    );
  }

  void _showLoadingDialog() {
    Get.dialog(
      FaceDetectedDialog(
        name: "face_id_loading.json",
        title: "face_detecting".tr,
      ),
      barrierDismissible: false, // Prevent closing the dialog by tapping outside
    );
  }

  void _navigateScanVehicle() async {
    await Future.delayed(Duration(seconds: 3));

    Get.back();
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        Get.offNamed(Routes.VEHICLE_SCAN); // Navigate to the next screen
        cameraController.dispose();
      },
    );
  }

  void bypassVerification() async {
    await Future.delayed(const Duration(milliseconds: 200));
    showLoadingOverlay();

    await vehicleScanUseCase.verifyVehicle();
    await Future.delayed(const Duration(seconds: 3));

    Get.offAllNamed(Routes.MAIN_TAB, arguments: {'refetch': true}); // Navigate to the home screen with argument
    hideLoadingOverlay();
  }

  @override
  void onClose() {
    super.onClose();
    cameraController.dispose();
    _faceDetector.close();
    _manualCaptureTimer?.cancel();
  }
}
