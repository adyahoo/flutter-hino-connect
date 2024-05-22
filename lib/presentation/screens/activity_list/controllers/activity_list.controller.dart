import 'package:get/get.dart';
import 'package:hino_driver_app/domain/core/entities/model.dart';
import 'package:hino_driver_app/domain/core/usecases/activity_use_case.dart';
import 'package:hino_driver_app/infrastructure/utils.dart';

class ActivityListController extends GetxController {
  ActivityListController({
    required ActivityUseCase useCase,
  }) : _useCase = useCase;

  final ActivityUseCase _useCase;

  final data = Rx<List<ActivityModel>>([]);
  final isFetching = true.obs;

  @override
  void onInit() {
    super.onInit();
    getActivityList();
  }

  Future<void> getActivityList() async {
    isFetching.value = true;

    final res = await _useCase.getActivityList();
    data.value = res.data;

    isFetching.value = false;
  }

  void addActivity(ActivityModel data) async {
    await Future.delayed(const Duration(milliseconds: 3000));

    await _useCase.addActivity(data);
    hideLoadingOverlay();

    getActivityList();
  }

  void updateActivity(ActivityModel data) async {
    await Future.delayed(const Duration(milliseconds: 3000));

    await _useCase.updateActivity(data);
    hideLoadingOverlay();

    getActivityList();
  }

  void deleteActivity(int id) async {
    await Future.delayed(const Duration(milliseconds: 3000));

    await _useCase.deleteActivity(id);
    hideLoadingOverlay();

    getActivityList();
  }
}
