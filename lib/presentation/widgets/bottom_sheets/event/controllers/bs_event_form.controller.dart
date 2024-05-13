import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hino_driver_app/domain/core/entities/model.dart';
import 'package:hino_driver_app/infrastructure/constants.dart';
import 'package:hino_driver_app/infrastructure/extension.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';

class BsEventFormController extends GetxController {
  final typeState = AppTextFieldState();
  final dateState = AppTextFieldState();
  final timeState = AppTextFieldState();
  final noteState = AppTextFieldState();

  final typeController = TextEditingController().obs;
  final dateController = TextEditingController().obs;
  final timeController = TextEditingController().obs;
  final noteController = TextEditingController().obs;

  final isLoading = false.obs;

  PickerModel? type;
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  int _editedId = 0;

  void setType(PickerModel value) {
    type = value;
    typeController.value.text = value.title.capitalize!;
  }

  void setDate(DateTime? value) {
    if (value != null) {
      date = value;
      dateController.value.text = value.getActivityDate();
    }
  }

  void setTime(TimeOfDay? value) {
    if (value != null) {
      time = value;
      timeController.value.text = value.getActivityTime();
    }
  }

  EventModel submit() {
    final mergedDate = date.copyWith(hour: time.hour, minute: time.minute);
    final formattedDate = DateFormat(Constants.DATE_FORMAT_TZ).format(mergedDate);

    // if submit update use selected item's id else use static id for v1
    final data = EventModel(
      id: (_editedId != 0) ? _editedId : 5,
      type: type!,
      createdAt: formattedDate.toString(),
      note: noteController.value.text,
    );

    return data;
  }

  void setInitData(EventModel event) {
    final date = DateFormat(Constants.DATE_FORMAT_TZ).parse(event.createdAt);
    final time = TimeOfDay.fromDateTime(date);

    typeController.value.text = event.type.title;
    dateController.value.text = date.getActivityDate();
    timeController.value.text = time.getActivityTime();
    noteController.value.text = event.note ?? "";

    this.type = event.type;
    this.date = date;
    this.time = time;

    _editedId = event.id;
  }
}
