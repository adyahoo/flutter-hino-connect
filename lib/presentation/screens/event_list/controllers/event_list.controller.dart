import 'package:get/get.dart';
import 'package:hino_driver_app/domain/core/entities/model.dart';
import 'package:hino_driver_app/domain/core/usecases/event_use_case.dart';
import 'package:hino_driver_app/infrastructure/utils.dart';

class EventListController extends GetxController {
  EventListController({
    required EventUseCase useCase,
  }) : _useCase = useCase;

  final EventUseCase _useCase;

  final data = Rx<List<EventModel>>([]);
  final isFetching = true.obs;

  @override
  void onInit() {
    super.onInit();
    getEventList();
  }

  Future<void> getEventList() async {
    isFetching.value = true;

    final res = await _useCase.getEventlist();
    data.value = res.data;

    isFetching.value = false;
  }

  void addEvent(EventModel data) async {
    await Future.delayed(const Duration(milliseconds: 3000));

    this.data.value = [data, ...this.data.value];
    hideLoadingOverlay();
  }

  void updateEvent(EventModel data) async {
    await Future.delayed(const Duration(milliseconds: 3000));

    final updatedIndex = this.data.value.indexWhere((element) => element.id == data.id);

    this.data.value[updatedIndex] = data;
    this.data.refresh();
    hideLoadingOverlay();
  }

  void deleteEvent(int id) async {
    await Future.delayed(const Duration(milliseconds: 3000));

    this.data.value.removeWhere((element) => element.id == id);
    this.data.refresh();
    hideLoadingOverlay();
  }
}
