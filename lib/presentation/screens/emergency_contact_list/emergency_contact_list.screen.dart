import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:hino_driver_app/domain/core/entities/model.dart';
import 'package:hino_driver_app/infrastructure/theme/app_color.dart';
import 'package:hino_driver_app/infrastructure/utils.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';

import 'controllers/emergency_contact_list.controller.dart';

class EmergencyContactListScreen extends GetView<EmergencyContactListController> {
  const EmergencyContactListScreen({Key? key}) : super(key: key);

  void onAdd() {
    showGetBottomSheet(
      BsEmergencyContactForm(
        onSubmit: (data) {
          controller.addContact(data);
        },
      ),
      canExpand: true,
    );
  }

  void onEdit(ContactModel contact) {
    showGetBottomSheet(
      BsEmergencyContactForm(
        initData: contact,
        onSubmit: (data) {
          controller.updateContact(data);
        },
      ),
      canExpand: true,
    );
  }

  void onDelete(int id) {
    showGetBottomSheet(
      BsConfirmation(
        type: BsConfirmationType.danger,
        title: 'delete_emergency_contact'.tr,
        description: 'are_you_sure_delete_emergency'.tr,
        positiveButtonOnClick: () {
          controller.deleteContact(id);
          Get.back();
        },
        positiveTitle: 'delete'.tr,
      ),
    );
  }

  Widget _renderCardContact(BuildContext context, ContactModel contact) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 1, color: BorderColor.primary),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      contact.name,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(color: TextColor.secondary),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "(${contact.code}) ${contact.phone}",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.secondary),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              SvgPicture.asset(
                "assets/icons/ic_call_calling.svg",
                width: 40,
                height: 40,
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: const AppStrippedDivider(),
          ),
          AppCardAction(
            onEdit: () {
              onEdit(contact);
            },
            onDelete: () {
              onDelete(contact.id);
            },
          ),
        ],
      ),
    );
  }

  Widget _renderContent(BuildContext context, ContactModel contact) {
    return _renderCardContact(
      context,
      contact,
    );
  }

  Widget _renderLoading() {
    return ShimmerContainer(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  Widget _renderEmpty(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/icons/ic_call_calling_round.svg",
            width: 56,
            height: 56,
          ),
          const SizedBox(height: 20),
          Text(
            "empty_contact_title".tr,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 4),
          Text(
            "empty_contact_subtitle".tr,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.secondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "emergency_contact".tr,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Obx(() {
                if (controller.isFetching.value) {
                  return _renderLoading();
                }

                final contact = controller.data.value;

                if (contact == null) {
                  return _renderEmpty(context);
                }

                return Column(
                  children: [
                    AppTips(
                      content: "emergency_tips_content".tr,
                      variant: WidgetVariant.info,
                    ),
                    const SizedBox(height: 16),
                    _renderContent(context, contact),
                  ],
                );
              }),
            ),
            Obx(
              () => AppButton(
                label: "add_emergency_contact".tr,
                onPress: (controller.data.value != null) ? null : onAdd,
                type: AppButtonType.filled,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
