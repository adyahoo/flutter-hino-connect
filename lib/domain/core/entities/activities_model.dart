import 'package:equatable/equatable.dart';

class ActivityModel extends Equatable {
  final int id;
  final String type;
  final String createdAt;

  const ActivityModel({
    required this.id,
    required this.type,
    required this.createdAt,
  });

  @override
  List<Object> get props => [id, type, createdAt];
}
