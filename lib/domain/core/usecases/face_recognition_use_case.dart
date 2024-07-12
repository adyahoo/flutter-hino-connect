import 'dart:io';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_mlkit_commons/src/input_image.dart';
import 'package:hino_driver_app/data/data_sources/data_source.dart';
import 'package:hino_driver_app/domain/core/interfaces/i_use_case.dart';
import 'package:hino_driver_app/infrastructure/client/exceptions/ApiException.dart';
import 'package:hino_driver_app/presentation/screens/face_recognition/face_recognition.screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FaceRecognitionUseCase implements IFaceRecognitionUseCase {
  const FaceRecognitionUseCase({required this.dataSource});

  final UserDataSource dataSource;

  @override
  Future<void> verifyDriverFace(File image) async {
    try {
      await dataSource.verifyDriverFace(image);
    } on ApiException catch (e) {
      rethrow;
    }
  }

  @override
  InputImage? inputImageFromCamera(CameraImage image, int? orientation, CameraDescription camera) {
    final sensorOrientation = camera.sensorOrientation;
    InputImageRotation? rotation;

    if (Platform.isIOS) {
      rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    } else if (Platform.isAndroid) {
      var rotationCompensation = orientation;
      if (rotationCompensation == null) return null;
      if (camera.lensDirection == CameraLensDirection.front) {
        // front-facing
        rotationCompensation = (sensorOrientation + rotationCompensation) % 360;
      } else {
        // back-facing
        rotationCompensation = (sensorOrientation - rotationCompensation + 360) % 360;
      }
      rotation = InputImageRotationValue.fromRawValue(rotationCompensation);
    }
    if (rotation == null) return null;

    // get image format
    final format = InputImageFormatValue.fromRawValue(image.format.raw);
    // validate format depending on platform
    // only supported formats:
    // * nv21 for Android
    // * bgra8888 for iOS
    if (format == null || (Platform.isAndroid && format != InputImageFormat.nv21) || (Platform.isIOS && format != InputImageFormat.bgra8888)) return null;

    // since format is constraint to nv21 or bgra8888, both only have one plane
    // if (image.planes.length != 1) return null;
    final plane = image.planes.first;

    // compose InputImage using bytes
    return InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        format: format, // used only in iOS
        bytesPerRow: plane.bytesPerRow, // used only in iOS
        rotation: rotation,
      ),
    );
  }

  @override
  Future<File> getMaskedImage() async {
    RenderRepaintBoundary boundary = clipKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    final img = await boundary.toImage();
    final byteData = await img.toByteData(format: ImageByteFormat.png);
    final pngByte = byteData?.buffer.asUint8List(); //convert byte image into png
    final tempDir = await getTemporaryDirectory();
    final capturedFile = await File('${tempDir.path}/image.png').create(); //create captured image file
    capturedFile.writeAsBytesSync(pngByte!); //write png image to create image file

    return capturedFile;
  }
}
