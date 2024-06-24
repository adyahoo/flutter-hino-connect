part of 'model.dart';

class CountryModel extends Equatable {
  final String name;
  final String phoneCode;
  final String code;
  final String flag;

  const CountryModel({
    required this.name,
    required this.phoneCode,
    required this.code,
    required this.flag,
  });

  @override
  List<Object> get props => [name, phoneCode, code, flag];
}
