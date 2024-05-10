import 'package:get/get.dart';
import 'package:hino_driver_app/domain/core/entities/feedback_model.dart';
import 'package:hino_driver_app/domain/core/usecases/feedback_use_case.dart';

class FeedbackController extends GetxController {
  
  FeedbackController({required this.useCase});

  final FeedbackUseCase useCase;

  final data = Rx<List<FeedbackModel>>([]);
  final isFetching = true.obs;

  @override
  void onInit() {
    super.onInit();
    getFeedbackList();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
 
  Future<void> getFeedbackList() async {
    isFetching.value = true;

    final res = await useCase.getFeedbackList();
    data.value = res.data;
    print('data: ${data.value}');

    isFetching.value = false;
  }

}
