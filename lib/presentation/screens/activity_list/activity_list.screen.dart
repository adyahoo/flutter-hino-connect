import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hino_driver_app/domain/core/entities/model.dart';
import 'package:hino_driver_app/infrastructure/theme/app_color.dart';
import 'package:hino_driver_app/infrastructure/utils.dart';
import 'package:hino_driver_app/presentation/screens/activity_list/widgets/activity_card_content.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';

import 'controllers/activity_list.controller.dart';

class ActivityListScreen extends GetView<ActivityListController> {
  const ActivityListScreen({Key? key}) : super(key: key);

  void onEdit(ActivityModel item) {
    Get.bottomSheet(
      BsActivityForm(
        initialData: item,
        onSubmit: (data) async {
          await Future.delayed(const Duration(milliseconds: 500));
          showLoadingOverlay();

          controller.updateActivity(data);
        },
      ),
    );
  }

  void onDelete(ActivityModel item) {
    Get.bottomSheet(
      BsConfirmation(
        type: BsConfirmationType.danger,
        title: "delete_activity_title".tr,
        description: "delete_activity_subtitle".tr,
        positiveTitle: 'delete'.tr,
        positiveButtonOnClick: () async {
          Get.back();
          await Future.delayed(const Duration(milliseconds: 500));
          showLoadingOverlay();

          controller.deleteActivity(item.id);
        },
      ),
    );
  }

  void onAdd() {
    Get.bottomSheet(
      BsActivityForm(
        onSubmit: (data) async {
          await Future.delayed(const Duration(milliseconds: 500));
          showLoadingOverlay();

          controller.addActivity(data);
        },
      ),
    );
  }

  Widget _renderContent(ActivityModel item) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 1, color: BorderColor.primary),
      ),
      child: Column(
        children: [
          ActivityCardContent(data: item),
          Container(margin: const EdgeInsets.symmetric(vertical: 16), child: const AppStrippedDivider()),
          AppCardAction(
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
