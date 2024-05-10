import 'package:equatable/equatable.dart';

class UserDto extends Equatable{
  final String id;
  final String name;
  final String email;
  final String role;
  final String profilePic;
  final String status;
  final String score;
  final String createdAt;
  final String updatedAt;

  const UserDto({
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

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      UserDto(
        id: json["id"].toString(),
        name: json["name"],
        email: json["email"],
        role: json["role"],
        profilePic: json["profilePic"],
        status: json["status"],
        score: json["score"].toString(),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  @override
  List<Object> get props => [id, name, email, role, profilePic, status, score, createdAt, updatedAt];
}