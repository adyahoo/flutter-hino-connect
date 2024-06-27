
import 'package:hino_driver_app/domain/core/entities/model.dart';

abstract class ICountryUseCase{
  Future<List<CountryModel>> getCountries();
}
