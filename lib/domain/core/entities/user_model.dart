import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int id;
  final String name;
  final String email;
  final String profilePic;
  final String? phoneCode;
  final String? phone;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.profilePic,
    this.phoneCode,
    this.phone,
  });

  //copy with
  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? profilePic,
    String? phoneCode,
    String? phone,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      profilePic: profilePic ?? this.profilePic,
      phoneCode: phoneCode ?? this.phoneCode,
      phone: phone ?? this.phone,
    );
  }

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
