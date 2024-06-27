import 'package:hino_driver_app/data/data_sources/data_source.dart';
import 'package:hino_driver_app/domain/core/entities/model.dart';
import 'package:hino_driver_app/domain/core/interfaces/i_country_use_case.dart';

class CountryUseCase implements ICountryUseCase {
  const CountryUseCase({
    required this.dataSource,
  });

  final CountryDataSource dataSource;

  @override
  Future<List<CountryModel>> getCountries() async {
    final res = await dataSource.getCountries();

    return res
        .map((e) => CountryModel(
              name: e.name,
              phoneCode: e.phoneCode,
              code: e.code,
              flag: e.flag,
            ))
        .toList();
  }
}
