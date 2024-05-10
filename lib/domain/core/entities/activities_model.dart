import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:hino_driver_app/domain/core/entities/picker_model.dart';
import 'package:hino_driver_app/infrastructure/constants.dart';

class ActivityModel extends Equatable {
  final int id;
  final PickerModel type;
  final String createdAt;

  const ActivityModel({
    required this.id,
    required this.type,
    required this.createdAt,
  });

  String get formatedDate {
    DateTime date = DateFormat(Constants.DATE_FORMAT_TZ).parse(this.createdAt);
    final outputFormat = DateFormat("dd MMMM yyyy, HH:mm");

    return outputFormat.format(date);
  }

  @override
  List<Object> get props => [id, type, createdAt];
}
