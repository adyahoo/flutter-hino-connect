import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hino_driver_app/domain/core/entities/model.dart';
import 'package:hino_driver_app/infrastructure/theme/app_color.dart';
import 'package:hino_driver_app/presentation/screens/event_list/widgets/event_card_header.dart';
import 'package:hino_driver_app/presentation/screens/event_list/widgets/event_card_note.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';

import 'controllers/event_list.controller.dart';

class EventListScreen extends GetView<EventListController> {
  const EventListScreen({Key? key}) : super(key: key);

  Widget _renderLoading() {
    return ShimmerContainer(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          itemCount: 4,
          itemBuilder: (context, index) => Container(
            height: 120,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          separatorBuilder: (context, index) => const SizedBox(height: 16),
        ),
      ),
    );
  }

  Widget _renderContent(EventModel item) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 1, color: BorderColor.primary),
      ),
      child: Column(
        children: [
          EventCardHeader(data: item),
          (item.note != null && item.note != "") ? EventCardNote(note: item.note!) : const SizedBox(),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: const AppStrippedDivider(),
          ),
          AppCardAction(
            isEditable: item.type.value != 'external',
            onEdit: () {
              onEdit(item);
            },
            onDelete: () {
              onDelete(item);
            },
          ),
        ],
      ),
    );
  }

  void onEdit(EventModel item) {
    Get.bottomSheet(
      BsEventForm(
        initialData: item,
        onSubmit: (data) async {
          controller.updateEvent(data);
        },
      ),
      isScrollControlled: true,
    );
  }

  void onDelete(EventModel item) {
    Get.bottomSheet(
      BsConfirmation(
        type: BsConfirmationType.danger,
        title: "delete_event_title".tr,
        description: "delete_event_subtitle".tr,
        positiveTitle: 'delete'.tr,
        positiveButtonOnClick: () async {
          Get.back();
          controller.deleteEvent(item.id);
        },
      ),
    );
  }

  void onAdd() {
    Get.bottomSheet(
      BsEventForm(
        onSubmit: (data) async {
          controller.addEvent(data);
        },
      ),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AppFab(
        onAdd: onAdd,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Obx(
            () {
              if (controller.isFetching.value) {
                return _renderLoading();
              }

              final data = controller.data.value;

              if (data.isEmpty) {
                return EmptyLog(
                  icon: "ic_empty_event.svg",
                  title: "empty_event_title".tr,
                  description: "empty_event_desc".tr,
                );
              }

              return ListView.separated(
                itemCount: data.length,
                itemBuilder: (context, index) => _renderContent(data[index]),
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                padding: const EdgeInsets.symmetric(vertical: 16),
              );
            },
          )),
    );
  }
}
