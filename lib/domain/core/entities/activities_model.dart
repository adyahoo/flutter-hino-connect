part of 'model.dart';

class ActivityModel extends Equatable {
  final int id;
  final PickerModel type;
  final String createdAt;
  final String? note;

  const ActivityModel({
    required this.id,
    required this.type,
    required this.createdAt,
    this.note,
  });

  String get formatedDate => this.createdAt.formatDateFromString("dd MMMM yyyy, HH:mm");

  @override
  List<Object?> get props => [id, type, createdAt, note];
}
