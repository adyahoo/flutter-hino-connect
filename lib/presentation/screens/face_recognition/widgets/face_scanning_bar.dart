part of '../face_recognition.screen.dart';

class FaceScanningBar extends GetView<FaceRecognitionController> {
  const FaceScanningBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
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
    );
  }
}
