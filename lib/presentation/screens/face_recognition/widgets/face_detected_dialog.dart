part of '../face_recognition.screen.dart';

class FaceDetectedDialog extends StatelessWidget {
  const FaceDetectedDialog({super.key, required this.name, this.isSuccess = true});

  final String name;
  final bool isSuccess;

  @override
  Widget build(BuildContext context) {
    final title = isSuccess ? "face_detected_successfully".tr : "face_detected_failed".tr;

    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Color(0xff333333),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              "assets/gifs/$name",
              width: 180,
              height: 180,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(color: Colors.white),
              ),
            ),
            if (!isSuccess) ...[
              const SizedBox(height: 24),
              AppButton(
                label: 'try_again'.tr,
                onPress: () {
                  Get.back();
                },
                type: AppButtonType.transparent,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
