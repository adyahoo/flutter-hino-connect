import 'package:get/get.dart';
import 'package:hino_driver_app/domain/core/entities/model.dart';
import 'package:hino_driver_app/domain/core/usecases/contact_use_case.dart';
import 'package:hino_driver_app/infrastructure/utils.dart';

class EmergencyContactListController extends GetxController {
  EmergencyContactListController({required this.useCase});

  final ContactUseCase useCase;

  final data = Rx<ContactModel?>(null);
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

    final res = await useCase.getPersonalSosContact();
    data.value = res;

    isFetching.value = false;
  }

  void addContact(ContactModel data) async {
    await Future.delayed(const Duration(milliseconds: 500));

    showLoadingOverlay();
    await useCase.addPersonalSosContact(data);
    hideLoadingOverlay();

    getContacts();
  }

  void updateContact(ContactModel data) async {
    await Future.delayed(const Duration(milliseconds: 500));

    showLoadingOverlay();
    await useCase.updatePersonalSosContact(data);
    hideLoadingOverlay();

    getContacts();
  }

  void deleteContact(int id) async {
    await Future.delayed(const Duration(milliseconds: 500));

    showLoadingOverlay();
    await useCase.deletePersonalSosContact(id);
    hideLoadingOverlay();

    getContacts();
  }
}
