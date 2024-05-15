import 'package:equatable/equatable.dart';

class ContactDto extends Equatable {
  final int id;
  final String name;
  final String code;
  final String phone;
  final String address;

  const ContactDto({
    required this.id,
    required this.name,
    required this.code,
    required this.phone,
    required this.address,
  });

  factory ContactDto.fromJson(Map<String, dynamic> json) {
    return ContactDto(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      phone: json['phone'],
      address: json['address'],
    );
  }

  @override
  List<Object> get props => [id, name, code, phone, address];
}
