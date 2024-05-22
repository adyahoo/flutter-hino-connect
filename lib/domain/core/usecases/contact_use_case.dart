import 'package:hino_driver_app/data/data_sources/data_source.dart';
import 'package:hino_driver_app/data/dtos/contacts_dto.dart';
import 'package:hino_driver_app/domain/core/entities/model.dart';
import 'package:hino_driver_app/domain/core/interfaces/i_use_case.dart';

class ContactUseCase implements IContactUseCase {
  const ContactUseCase({required this.dataSource});

  final ContactDataSource dataSource;

  @override
  Future<List<ContactModel>> getSosContact() async {
    try {
      final response = await dataSource.getSosContacts();
      final data = response.data
          .map(
            (e) => ContactModel(
              id: e.id,
              name: e.name,
              code: e.code,
              phone: e.phone,
              address: e.address,
            ),
          )
          .toList();

      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ContactModel?> getPersonalSosContact() async {
    try {
      final response = await dataSource.getPersonalSosContacts();

      if (response != null) {
        final data = ContactModel(
          id: response.id,
          name: response.name,
          code: response.code,
          phone: response.phone,
          address: response.address,
        );

        return data;
      }

      return null;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addPersonalSosContact(ContactModel data) async {
    try {
      final dto = ContactDto(
        id: data.id,
        name: data.name,
        code: data.code,
        phone: data.phone,
        address: data.address,
      );

      await dataSource.addPersonalSosContact(dto);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updatePersonalSosContact(ContactModel data) async {
    try {
      final dto = ContactDto(
        id: data.id,
        name: data.name,
        code: data.code,
        phone: data.phone,
        address: data.address,
      );

      await dataSource.updatePersonalSosContact(dto);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deletePersonalSosContact(int id) async {
    try{
      await dataSource.deletePersonalSosContact(id);
    }catch (e){
      rethrow;
    }
  }
}
