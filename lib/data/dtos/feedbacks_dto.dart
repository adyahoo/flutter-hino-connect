import 'package:equatable/equatable.dart';

class FeedbackDto extends Equatable {
  final int id;
  final String title;
  final String description;
  final String createdBy;
  final String createdAt;

  const FeedbackDto({
    required this.id,
    required this.title,
    required this.description,
    required this.createdBy,
    required this.createdAt,
  });

  factory FeedbackDto.fromJson(Map<String, dynamic> json) =>
      FeedbackDto(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        createdBy: json["createdBy"],
        createdAt: json["createdAt"],
      );

  @override
  List<Object> get props => [id, title, description, createdBy, createdAt];
}