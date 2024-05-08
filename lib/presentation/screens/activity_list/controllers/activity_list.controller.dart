import 'package:get/get.dart';
import 'package:hino_driver_app/domain/core/entities/activities_model.dart';
import 'package:hino_driver_app/domain/core/usecases/activity_use_case.dart';

class ActivityListController extends GetxController {
  ActivityListController({
    required this.useCase,
  });

  final ActivityUseCase useCase;

  final data = Rx<List<ActivityModel>>([]);
  final isFetching = true.obs;

  @override
  void onInit() {
    super.onInit();
    getActivityList();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getActivityList() async {
    isFetching.value = true;

    final res = await useCase.getActivityList();
    data.value = res.data;

    isFetching.value = false;
  }
}
