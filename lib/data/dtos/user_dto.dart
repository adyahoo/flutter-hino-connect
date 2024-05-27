import 'package:equatable/equatable.dart';

class LoginBodyDto extends Equatable {
  final String email;
  final String password;

  const LoginBodyDto({
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

class LoginDto extends Equatable {
  final String token;

  const LoginDto({
    required this.token,
  });

  Map<String, dynamic> toJson() {
    return {
      'access_token': this.token,
    };
  }

  factory LoginDto.fromJson(Map<String, dynamic> json) {
    return LoginDto(
      token: json['access_token'],
    );
  }

  @override
  List<Object> get props => [token];
}

class UserDto extends Equatable {
  final int id;
  final String name;
  final String email;
  final String profilePic;
  final String? phoneCode;
  final String? phone;

  const UserDto({
    required this.id,
    required this.name,
    required this.email,
    required this.profilePic,
    this.phoneCode,
    this.phone,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) => UserDto(
        id: json["user_id"],
        name: json["name"],
        email: json["email"],
        profilePic: json["profile_picture"],
        phoneCode: json["phone_code"],
        phone: json["phone"],
      );

  @override
  List<Object?> get props => [id, name, email, profilePic, phoneCode, phone];
}
