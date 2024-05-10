import 'package:equatable/equatable.dart';

class FeedbackModel extends Equatable {
  final int id;
  final String title;
  final String description;
  final String createdBy;
  final String createdAt;

  const FeedbackModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdBy,
    required this.createdAt,
  });

  @override
  List<Object> get props => [id, title, description, createdBy, createdAt];
}