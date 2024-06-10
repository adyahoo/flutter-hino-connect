import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/face_recognition.controller.dart';

class FaceRecognitionScreen extends GetView<FaceRecognitionController> {
  const FaceRecognitionScreen({Key? key}) : super(key: key);

  Widget cameraWidget(context) {
    var camera = controller.cameraController.value;
    final size = MediaQuery.of(context).size;
    var scale = size.aspectRatio * camera.aspectRatio;
    if (scale < 1) scale = 1 / scale;

    var zoom = 1.0;

    return Transform.scale(
      scale: scale * zoom,
      child: Center(
        child: CameraPreview(controller.cameraController),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.initCamera(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Stack(
            alignment: FractionalOffset.center,
            children: [
              Positioned.fill(
                child: cameraWidget(context),
              ),
              Positioned.fill(
                child: Opacity(
                  opacity: 0.3,
                  child: Image.asset(
                    'assets/images/camera_overlay.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).viewPadding.top + 16,
                left: 8,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    size: 24,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
              Positioned(
                child: Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top + kToolbarHeight),
                  child: Column(
                    children: [
                      SizedBox(
                        height: kToolbarHeight + Get.width,
                      ),
                      Text(
                        "Pastikan wajah anda berada di frame oval",
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white),
                      ),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                ),
              ),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
