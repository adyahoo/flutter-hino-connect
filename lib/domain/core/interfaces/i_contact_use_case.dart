part of 'i_use_case.dart';

abstract class IContactUseCase {
  Future<List<ContactModel>> getSosContact();
  Future<ContactModel?> getPersonalSosContact();
  Future<void> addPersonalSosContact(ContactModel data);
  Future<void> updatePersonalSosContact(ContactModel data);
  Future<void> deletePersonalSosContact(int id);
}
