part of 'data_source.dart';

class ContactDataSource {
  Future<ListApiResponse<ContactDto>> getSosContacts() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      final data = await inject<StorageService>().getJsonData(StorageService.CONTACTS_JSON);

      return ListApiResponse.fromJson(
        data!,
        (json) => json
            .map(
              (e) => ContactDto.fromJson(e),
            )
            .toList(),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<ContactDto?> getPersonalSosContacts() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      final data = await inject<StorageService>().getJsonData(StorageService.PERSONAL_CONTACTS_JSON);

      if (data != null) {
        return ContactDto.fromJson(data["data"]);
      }

      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addPersonalSosContact(ContactDto newData) async {
    try {
      await Future.delayed(const Duration(seconds: 3));

      inject<StorageService>().setJsonData(StorageService.PERSONAL_CONTACTS_JSON, {"data": newData.toJson()});
    } catch (e) {
      rethrow;
    }
  }

  //it look simple because the contact only hold 1 data, so we can override using key only
  Future<void> updatePersonalSosContact(ContactDto newData) async {
    try {
      await Future.delayed(const Duration(seconds: 3));

      inject<StorageService>().setJsonData(StorageService.PERSONAL_CONTACTS_JSON, {"data": newData.toJson()});
    } catch (e) {
      rethrow;
    }
  }

  //we clear the data by key because it only hold 1 data, and it can't edit without any data exist
  Future<void> deletePersonalSosContact(int id) async {
    try{
      inject<StorageService>().clearByKey(StorageService.PERSONAL_CONTACTS_JSON);
    }catch (e){
      rethrow;
    }
  }
}
