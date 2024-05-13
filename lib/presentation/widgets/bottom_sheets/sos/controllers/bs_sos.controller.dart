import 'package:get/get.dart';
import 'package:hino_driver_app/domain/core/entities/contact_model.dart';
import 'package:hino_driver_app/domain/core/usecases/contact_use_case.dart';

class BsSosController extends GetxController {
  BsSosController({required this.useCase});

  final ContactUseCase useCase;

  final data = Rx<List<ContactModel>>([]);
  final isFetching = true.obs;

  @override
  void onInit() {
    super.onInit();
    getSosContact();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getSosContact() async {
    isFetching.value = true;

    final data = await useCase.getSosContact();

    this.data.value = data;
    isFetching.value = false;
  }
}
