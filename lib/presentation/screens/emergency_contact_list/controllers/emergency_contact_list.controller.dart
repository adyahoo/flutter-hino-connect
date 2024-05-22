import 'package:get/get.dart';
import 'package:hino_driver_app/domain/core/entities/model.dart';
import 'package:hino_driver_app/domain/core/usecases/contact_use_case.dart';

class EmergencyContactListController extends GetxController {
  EmergencyContactListController({required this.useCase});

  final ContactUseCase useCase;

  final data = Rx<List<ContactModel>>([]);
  final isFetching = false.obs;

  @override
  void onInit() {
    super.onInit();
    getContacts();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getContacts() async {
    isFetching.value = true;

    final res = await useCase.getSosContact();
    data.value = res;

    isFetching.value = false;
  }

  void addContact(ContactModel data) {}

  void updateContact(ContactModel data) {}

  void deleteContact(int id) {}
}
