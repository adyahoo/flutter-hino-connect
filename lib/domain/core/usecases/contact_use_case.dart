import 'package:hino_driver_app/data/data_sources/data_source.dart';
import 'package:hino_driver_app/data/dtos/base_response_dto.dart';
import 'package:hino_driver_app/domain/core/entities/contact_model.dart';
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
}
