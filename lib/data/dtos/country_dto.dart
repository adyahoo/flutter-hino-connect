import 'package:equatable/equatable.dart';

class CountryDto extends Equatable {
  final String name;
  final String phoneCode;
  final String code;
  final String flag;

  const CountryDto({
    required this.name,
    required this.phoneCode,
    required this.code,
    required this.flag,
  });

  factory CountryDto.fromJson(Map<String, dynamic> json) {
    return CountryDto(
      name: json['name'],
      phoneCode: json['phone_code'],
      code: json['code'],
      flag: json['flag'],
    );
  }

  @override
  List<Object> get props => [name, phoneCode, code, flag];
}
