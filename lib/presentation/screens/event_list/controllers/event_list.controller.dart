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
    await Future.delayed(const Duration(milliseconds: 500));
    showLoadingOverlay();
    await Future.delayed(const Duration(milliseconds: 1000));

    await _useCase.addEvent(data);
    hideLoadingOverlay();

    getEventList();
  }

  void updateEvent(EventModel data) async {
    await Future.delayed(const Duration(milliseconds: 500));
    showLoadingOverlay();
    await Future.delayed(const Duration(milliseconds: 1000));

    await _useCase.updateEvent(data);
    hideLoadingOverlay();

    getEventList();
  }

  void deleteEvent(int id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    showLoadingOverlay();
    await Future.delayed(const Duration(milliseconds: 1000));

    await _useCase.deleteEvent(id);
    hideLoadingOverlay();

    getEventList();
  }
}
