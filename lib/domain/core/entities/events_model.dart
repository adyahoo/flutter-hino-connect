part of 'model.dart';

class EventModel extends Equatable {
  final int id;
  final PickerModel type;
  final String createdAt;
  final String? note;

  const EventModel({
    required this.id,
    required this.type,
    required this.createdAt,
    required this.note,
  });

  String get formatedDate => this.createdAt.formatDateFromString("dd MMMM yyyy, HH:mm");

  @override
  List<Object?> get props => [id, type, createdAt, note];
}
