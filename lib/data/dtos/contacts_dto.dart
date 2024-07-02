import 'package:equatable/equatable.dart';

class ContactDto extends Equatable {
  final int id;
  final String name;
  final String phone;
  final String? code;
  final String? address;

  const ContactDto({
    required this.id,
    required this.name,
    required this.phone,
    this.address,
    this.code,
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

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'name': this.name,
      'code': this.code,
      'phone': this.phone,
      'address': this.address,
    };
  }

  @override
  List<Object?> get props => [id, name, code, phone, address];
}
