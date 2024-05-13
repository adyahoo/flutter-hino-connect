import 'package:equatable/equatable.dart';

class ContactModel extends Equatable {
  final int id;
  final String name;
  final String phone;
  final String address;

  const ContactModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
  });

  @override
  List<Object> get props => [id, name, phone, address];
}
