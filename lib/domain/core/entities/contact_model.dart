part of 'model.dart';

class ContactModel extends Equatable {
  final int id;
  final String name;
  final String phone;
  final String? code;
  final String? address;
  final bool isPersonal;

  const ContactModel({
    required this.id,
    required this.name,
    required this.phone,
    this.isPersonal = false,
    this.code,
    this.address,
  });

  @override
  List<Object?> get props => [id, name, code, phone, address, isPersonal];

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
