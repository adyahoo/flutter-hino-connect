part of 'data_source.dart';

class ContactDataSource {
  Future<ListApiResponse<ContactDto>> getSosContacts() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      final response = await DefaultAssetBundle.of(rootScaffoldMessengerKey.currentContext!).loadString('assets/response_helpers/contacts.json');
      final data = await json.decode(response);

      return ListApiResponse.fromJson(
        data,
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
}
