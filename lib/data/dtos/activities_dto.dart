import 'package:equatable/equatable.dart';

class ActivityDto extends Equatable {
  final int id;
  final String type;
  final String createdAt;
  final String? note;

  const ActivityDto({
    required this.id,
    required this.type,
    required this.createdAt,
    this.note,
  });

  factory ActivityDto.fromJson(Map<String, dynamic> json) => ActivityDto(
        id: json["id"],
        type: json["type"],
        createdAt: json["created_at"],
        note: json['note'],
      );

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'type': this.type,
      'created_at': this.createdAt,
      'note': this.note,
    };
  }

  @override
  List<Object?> get props => [id, type, createdAt, note];
}
