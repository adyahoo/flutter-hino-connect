import 'package:equatable/equatable.dart';

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

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      name: json['name'],
      phoneCode: json['phoneCode'],
      code: json['code'],
      flag: json['flag'],
    );
  }

  @override
  List<Object> get props => [name, phoneCode, code, flag];
}
