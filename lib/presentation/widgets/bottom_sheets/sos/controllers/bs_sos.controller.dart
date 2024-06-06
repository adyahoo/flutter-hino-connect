import 'package:get/get.dart';
import 'package:hino_driver_app/domain/core/entities/model.dart';
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

    final data1 = await useCase.getSosContact();
    final data2 = await useCase.getPersonalSosContact();

    if (data2 != null) {
      data.value = [...data1, data2];
    } else {
      data.value = data1;
    }

    print('data 2' + data2.toString());

    isFetching.value = false;
  }
}
