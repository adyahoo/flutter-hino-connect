import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/face_recognition.controller.dart';

class FaceRecognitionScreen extends GetView<FaceRecognitionController> {
  const FaceRecognitionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(controller.cameraController?.value.isInitialized == false) {
      return const SizedBox();
    }

    return Stack(
      alignment: FractionalOffset.center,
      children: <Widget>[
        // Positioned.fill(
        //   child: AspectRatio(
        //     aspectRatio: 16/9,
        //     child: CameraPreview(controller.cameraController!),
        //   ),
        // ),
        Positioned.fill(
          child: Opacity(
            opacity: 0.3,
            child: Image.network(
              'https://picsum.photos/3000/4000',
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    );
  }
}
