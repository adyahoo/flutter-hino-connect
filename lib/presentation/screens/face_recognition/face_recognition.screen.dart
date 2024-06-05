import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/face_recognition.controller.dart';

class FaceRecognitionScreen extends GetView<FaceRecognitionController> {
  const FaceRecognitionScreen({Key? key}) : super(key: key);

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
                // child: Expanded(
                  child: AspectRatio(
                    // aspectRatio: controller.cameraController.value.aspectRatio,
                    aspectRatio: 4/3,
                    child: CameraPreview(controller.cameraController),
                  ),
                ),
              // ),
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
                      GestureDetector(
                        onTap: (){
                          controller.captureFace();
                        },
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white,
                          ),
                        ),
                      ),
                      // const Expanded(child: SizedBox()),
                      // Text(
                      //   "Sedang memindai wajah...",
                      //   style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white),
                      // ),
                      const SizedBox(height: 14),
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
