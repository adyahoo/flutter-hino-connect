part of '../face_recognition.screen.dart';

class FaceManualCapture extends GetView<FaceRecognitionController> {
  const FaceManualCapture({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: controller.isManual.value,
        child: Positioned(
          left: 16,
          right: 16,
          bottom: 16,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Color(0xCC2F2F2F), borderRadius: BorderRadius.circular(12)),
                child: Text(
                  "manual_capture_desc".tr,
                  style: context.textTheme.bodySmall?.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
              AppButton(
                label: "capture_send".tr,
                onPress: controller.captureFaceManual,
                type: AppButtonType.plain,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
