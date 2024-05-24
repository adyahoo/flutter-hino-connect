import 'package:equatable/equatable.dart';

class ActivityDto extends Equatable {
  final int id;
  final String type;
  final String createdAt;

  const ActivityDto({
    required this.id,
    required this.type,
    required this.createdAt,
  });

  factory ActivityDto.fromJson(Map<String, dynamic> json) =>
      ActivityDto(
        id: json["id"],
        type: json["type"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'type': this.type,
      'created_at': this.createdAt,
    };
  }

  @override
  List<Object> get props => [id, type, createdAt];
}
