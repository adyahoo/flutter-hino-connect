part of 'model.dart';

class ContactModel extends Equatable {
  final int id;
  final String name;
  final String code;
  final String phone;
  final String? address;

  const ContactModel({
    required this.id,
    required this.name,
    required this.code,
    required this.phone,
    this.address,
  });

  @override
  List<Object?> get props => [id, name, code, phone, address];

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'name': this.name,
      'code': this.code,
      'phone': this.phone,
      'address': this.address,
    };
  }

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      phone: json['phone'],
      address: json['address'],
    );
  }
}
