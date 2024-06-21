import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:hino_driver_app/infrastructure/theme/app_color.dart';
import 'package:hino_driver_app/presentation/screens/face_recognition/widgets/face_detection_painter.dart';

import 'controllers/face_recognition.controller.dart';

part 'widgets/face_detected_dialog.dart';

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
        child: CameraPreview(
          controller.cameraController,
        ),
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
                        height: Get.width,
                      ),
                      Text(
                        "face_recognition_subtitle".tr,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white),
                      ),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                ),
              ),
              Obx(
                () => Visibility(
                  visible: controller.isScanning.value,
                  child: Positioned(
                    left: 16,
                    right: 16,
                    bottom: 16,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "scanning_face".tr,
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white),
                        ),
                        const SizedBox(height: 16),
                        TweenAnimationBuilder(
                          duration: const Duration(milliseconds: 3000),
                          tween: Tween<double>(
                            begin: 0.0,
                            end: 0.99,
                          ),
                          builder: (context, value, child) {
                            controller.loadingValue.value = value;

                            return Obx(
                              () => LinearProgressIndicator(
                                backgroundColor: SuccesColor.surface,
                                color: PrimaryNewColor().main,
                                borderRadius: BorderRadius.circular(20),
                                minHeight: 6,
                                value: controller.loadingValue.value,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
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
