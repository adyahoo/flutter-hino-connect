import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int id;
  final String name;
  final String email;
  final String profilePic;
  final String? phoneCode;
  final String? phone;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.profilePic,
    this.phoneCode,
    this.phone,
  });

  @override
  List<Object?> get props => [id, name, email, profilePic, phoneCode, phone];
}

class LoginBody extends Equatable {
  final String email;
  final String password;

  const LoginBody({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': this.email,
      'password': this.password,
    };
  }

  @override
  List<Object> get props => [email, password];
}
