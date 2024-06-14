part of '../face_recognition.screen.dart';

class FaceDetectedDialog extends StatelessWidget {
  const FaceDetectedDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xff333333),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(
              image: AssetImage('assets/images/face_recog_success.gif'),
              height: 140,
              width: 140,
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "face_detected_successfully".tr,
                style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
