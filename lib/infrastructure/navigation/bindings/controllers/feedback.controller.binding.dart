import 'package:get/get.dart';

import '../../../../presentation/screens/feedback/controllers/feedback.controller.dart';

class FeedbackControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeedbackController>(
      () => FeedbackController(),
    );
  }
}