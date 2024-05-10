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

  String get formatedDate {
    DateTime date = DateFormat(Constants.DATE_FORMAT_TZ).parse(this.createdAt);
    final outputFormat = DateFormat("dd MMMM yyyy, HH:mm");

    return outputFormat.format(date);
  }

  @override
  List<Object?> get props => [id, type, createdAt, note];
}
