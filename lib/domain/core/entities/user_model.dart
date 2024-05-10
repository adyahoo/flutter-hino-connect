import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
    final String id;
  final String name;
  final String email;
  final String role;
  final String profilePic;
  final String status;
  final String score;
  final String createdAt;
  final String updatedAt;
  

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.profilePic,
    required this.status,
    required this.score,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object> get props => [id, name, email, role, profilePic, status, score, createdAt, updatedAt];
}