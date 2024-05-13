import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hino_driver_app/data/locals/StorageService.dart';
import 'package:hino_driver_app/domain/core/entities/map_filter_model.dart';
import 'package:hino_driver_app/domain/core/entities/model.dart';
import 'package:hino_driver_app/infrastructure/di.dart';
import 'package:hino_driver_app/presentation/screens/profile/controllers/profile.controller.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';
import 'package:iconsax/iconsax.dart';

class ButtonShapeValue {
  final double radius;

  const ButtonShapeValue({
    required this.radius,
  });
}

class MenuItem {
  final String title;
  final IconData icon;
  final Function()? onTap;

  const MenuItem({
    required this.title,
    required this.icon,
    this.onTap,
  });
}

class Constants {
  static final DATE_FORMAT_TZ = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";

  static final bottomMainMenu = [
    BottomNavigationBarItem(
      label: 'home'.tr,
      icon: const Icon(Iconsax.home),
    ),
    BottomNavigationBarItem(
      label: 'map'.tr,
      icon: const Icon(Iconsax.map_1),
    ),
    BottomNavigationBarItem(
      label: 'scan'.tr,
      icon: const SizedBox(height: 24),
    ),
    BottomNavigationBarItem(
      label: 'log'.tr,
      icon: const Icon(Iconsax.note_text),
    ),
    BottomNavigationBarItem(
      label: 'sos'.tr,
      icon: const Icon(Iconsax.call_calling),
    ),
  ];

  static final buttonShapeValue = {
    AppButtonShape.rounded: ButtonShapeValue(
      radius: 320,
    ),
    AppButtonShape.rect: ButtonShapeValue(
      radius: 12,
    ),
  };

  static final faceScanInformationItems = [
    {
      'icon': Iconsax.user_search,
      'content': 'face_scan_item_1'.tr,
    },
    {
      'icon': Iconsax.glass_1,
      'content': 'face_scan_item_2'.tr,
    },
  ];

  static List<MenuItem> get profileMenuItems => [
        MenuItem(title: 'edit_profile'.tr, icon: Iconsax.edit_24),
        MenuItem(title: 'biometric_login'.tr, icon: Iconsax.scan4),
        MenuItem(
            title: 'language'.tr,
            icon: Iconsax.language_circle4,
            onTap: () {
              print('Bahasa clicked');
              print(
                  'Selected language: ${inject<StorageService>().getSelectedLanguage()}');
              Get.bottomSheet(BsSinglePicker(
                  options: languageOptions,
                  title: 'Pilih Bahasa',
                  selectedId:
                      inject<StorageService>().getSelectedLanguage() ?? 0,
                  onSubmit: (value) {
                    print('Selected language: ${value.title}');
                  }));
            }),
        MenuItem(title: 'about_us'.tr, icon: Iconsax.note_21),
        MenuItem(title: 'privacy_policy'.tr, icon: Iconsax.shield_tick4),
        MenuItem(title: 'need_help'.tr, icon: Iconsax.message_2),
        MenuItem(
            title: 'logout_title'.tr,
            icon: Iconsax.logout_1,
            onTap: () {
              Get.bottomSheet(BsConfirmation(
                type: BsConfirmationType.danger,
                title: 'Quit Account?',
                description: 'Are you sure want to delete this post?',
                positiveButtonOnClick: Get.find<ProfileController>().logout,
              ));
            }),
      ];

  static final activityTypeItems = [
    PickerModel(id: 1, title: 'Refuel', value: 'refuel'),
    PickerModel(id: 2, title: 'Load', value: 'load'),
    PickerModel(id: 3, title: 'Unload', value: 'unload'),
    PickerModel(id: 4, title: 'Workshop', value: 'workshop'),
  ];

    static final eventTypeItems = [
    PickerModel(id: 1, title: 'Malfunction', value: 'malfunction'),
    PickerModel(id: 2, title: 'Accident', value: 'accident'),
    PickerModel(id: 3, title: 'External Event', value: 'external_event'),
  ];

  static final languageOptions = [
    PickerModel(id: 0, title: 'Sesuai device', value: 'default'),
    PickerModel(id: 1, title: 'Bahasa Indonesia', value: 'id'),
    PickerModel(id: 2, title: 'English', value: 'en'),
  ];

}
