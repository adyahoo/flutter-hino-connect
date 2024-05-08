import 'package:easy_localization/easy_localization.dart';
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

  String get formatedDate {
    DateTime date = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(this.createdAt);
    final outputFormat = DateFormat("dd MMMM yyyy, HH:mm");

    return outputFormat.format(date);
  }

  @override
  List<Object> get props => [id, type, createdAt];
}
