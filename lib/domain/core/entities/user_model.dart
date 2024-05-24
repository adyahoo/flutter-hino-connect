import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String role;
  late String profilePic;
  final String status;
  final String score;
  final String phoneCode;
  final String phoneNumber;
  final String createdAt;
  final String updatedAt;
  

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.profilePic,
    required this.status,
    required this.score,
    required this.phoneCode,
    required this.phoneNumber,
    required this.createdAt,
    required this.updatedAt,
  });

  //copy with
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? role,
    String? profilePic,
    String? status,
    String? score,
    String? phoneCode,
    String? phoneNumber,
    String? createdAt,
    String? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      profilePic: profilePic ?? this.profilePic,
      status: status ?? this.status,
      score: score ?? this.score,
      phoneCode: phoneCode ?? this.phoneCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object> get props => [id, name, email, role, profilePic, status, score, phoneCode, phoneNumber, createdAt, updatedAt];
}