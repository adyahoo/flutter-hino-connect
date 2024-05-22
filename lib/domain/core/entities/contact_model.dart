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
}
