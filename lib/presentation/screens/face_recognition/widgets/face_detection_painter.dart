import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:hino_driver_app/infrastructure/theme/app_color.dart';
import 'package:hino_driver_app/infrastructure/utils.dart';

class FaceDetectorPainter extends CustomPainter {
  FaceDetectorPainter(
      this.faces,
      this.imageSize,
      this.rotation,
      this.cameraLensDirection,
      );

  final List<Face> faces;
  final Size imageSize;
  final InputImageRotation rotation;
  final CameraLensDirection cameraLensDirection;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint1 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = PrimaryNewColor().main;

    for (final Face face in faces) {
      final left = translateX(
        face.boundingBox.left,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      final top = translateY(
        face.boundingBox.top,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      final right = translateX(
        face.boundingBox.right,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      final bottom = translateY(
        face.boundingBox.bottom,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      print("sapi ahayy $right");

      canvas.drawRect(
        Rect.fromLTRB(left, top, right, bottom),
        paint1,
      );
    }
  }

  @override
  bool shouldRepaint(FaceDetectorPainter oldDelegate) {
    return oldDelegate.imageSize != imageSize || oldDelegate.faces != faces;
  }
}

class FaceDetectPainter extends CustomPainter {
  final Size imageSize;
  final List<Face> faces;
  final bool isReflection;

  const FaceDetectPainter(
      this.imageSize,
      this.faces, {
        this.isReflection = false,
      });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = Colors.blue;

    for (final face in faces) {
      final faceRect = _reflectionRect(face.boundingBox);
      canvas.drawRect(
        _scaleRect(
          rect: faceRect,
          imageSize: imageSize,
          widgetSize: size,
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant FaceDetectPainter oldDelegate) {
    return oldDelegate.imageSize != imageSize || oldDelegate.faces != faces;
  }

  Rect _reflectionRect(Rect boundingBox) {
    if (isReflection) {
      return boundingBox;
    }
    final centerX = imageSize.width / 2;
    final left = ((boundingBox.left - centerX) * -1) + centerX;
    final right = ((boundingBox.right - centerX) * -1) + centerX;
    return Rect.fromLTRB(left, boundingBox.top, right, boundingBox.bottom);
  }

  Rect _scaleRect({
    required Rect rect,
    required Size imageSize,
    required Size widgetSize,
  }) {
    final scaleX = widgetSize.width / imageSize.width;
    final scaleY = widgetSize.height / imageSize.height;

    final scaledRect = Rect.fromLTRB(
      rect.left.toDouble() * scaleX,
      rect.top.toDouble() * scaleY,
      rect.right.toDouble() * scaleX,
      rect.bottom.toDouble() * scaleY,
    );

    return scaledRect;
  }
}