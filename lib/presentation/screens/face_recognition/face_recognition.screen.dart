import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:hino_driver_app/infrastructure/theme/app_color.dart';
import 'package:hino_driver_app/infrastructure/utils.dart';
import 'package:hino_driver_app/presentation/screens/face_recognition/widgets/face_detection_painter.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';
import 'package:lottie/lottie.dart';

import 'controllers/face_recognition.controller.dart';

part 'widgets/face_detected_dialog.dart';

part 'widgets/face_manual_capture.dart';

part 'widgets/face_scanning_bar.dart';

final clipKey = GlobalKey();

class FaceRecognitionScreen extends GetView<FaceRecognitionController> {
  const FaceRecognitionScreen({Key? key}) : super(key: key);

  void _showDebugOptionBs() {
    showGetBottomSheet(
      BsDebugOption(
        onTapOption: _showForceVehicleConfirmation,
      ),
    );
  }

  void _showForceVehicleConfirmation() {
    showGetBottomSheet(
      BsConfirmation(
        type: BsConfirmationType.warning,
        title: "force_vehicle_title".tr,
        description: "force_vehicle_confirmation_desc".tr,
        positiveButtonOnClick: () {
          Get
            ..back()
            ..back();

          controller.bypassVerification();
        },
      ),
    );
  }

  Widget _cameraWidget(context) {
    var camera = controller.cameraController.value;
    final size = MediaQuery.of(context).size;
    var scale = size.aspectRatio * camera.aspectRatio;
    if (scale < 1) scale = 1 / scale;

    var zoom = 1.0;

    return Obx(
      () => Transform.scale(
          scale: scale * zoom,
          child: Stack(
            children: [
              RepaintBoundary(
                key: clipKey,
                child: ClipPath(
                  clipper: _FaceCircleMask(),
                  child: controller.capturedImage.value != null
                      ? Image.file(
                          controller.capturedImage.value!,
                          fit: BoxFit.cover,
                        )
                      : Image.asset('assets/images/home_header_illust.png'),
                ),
              ),
              Center(
                child: CameraPreview(
                  controller.cameraController,
                ),
              ),
              _SelfieMask(
                color: Colors.black.withOpacity(0.5),
              ),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.isScanning.value) {
          return false;
        }

        return true;
      },
      child: FutureBuilder(
        future: controller.initCamera(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done && snapshot.error == null) {
            return Stack(
              alignment: FractionalOffset.center,
              children: [
                Positioned.fill(
                  child: _cameraWidget(context),
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
                      if (!controller.isScanning.value) {
                        Get.back();
                      }
                    },
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).viewPadding.top + 12,
                  right: 8,
                  child: IconButton(
                    icon: Icon(
                      Icons.more_vert_rounded,
                      size: 24,
                      color: Colors.white,
                    ),
                    onPressed: _showDebugOptionBs,
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
                const FaceScanningBar(),
                const FaceManualCapture(),
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

class _SelfieMask extends StatelessWidget {
  final Color? color;

  const _SelfieMask({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ClipPath(
        clipper: _SelfieModePhoto(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: color,
        ),
      ),
    );
  }
}

class _SelfieModePhoto extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final circlePath = Path();

    circlePath.addOval(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height * 2 / 5),
        radius: (size.width / 4),
      ),
    );

    path.addPath(circlePath, const Offset(0, 0));
    path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    path.fillType = PathFillType.evenOdd;

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class _FaceCircleMask extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final circlePath = Path();

    circlePath.addOval(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height * 2 / 5),
        radius: (size.width / 4),
      ),
    );

    path.moveTo(0, 0);
    path.addPath(circlePath, const Offset(0, 0));
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
