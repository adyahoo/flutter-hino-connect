part of 'model.dart';

class PickerModel extends Equatable {
  final int id;
  final String title;
  final String value;

  const PickerModel({
    required this.id,
    required this.title,
    required this.value,
  });

  @override
  List<Object> get props => [id, title, value];
}
