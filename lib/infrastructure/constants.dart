import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hino_driver_app/domain/core/entities/picker_model.dart';
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

  static final profileMenuItems = [
    MenuItem(title: 'Edit Profile', icon: Iconsax.edit_24),
    MenuItem(title: 'Biometric Login', icon: Iconsax.scan4),
    MenuItem(title: 'Bahasa', icon: Iconsax.language_circle4, onTap: () {
      print('Bahasa clicked');
      Get.bottomSheet(CustomPicker(
        options: ['Bahasa Indonesia', 'English'],
      ));
    }),
    MenuItem(title: 'Tentang Kami', icon: Iconsax.note_21),
    MenuItem(title: 'Kebijakan Privasi', icon: Iconsax.shield_tick4),
    MenuItem(title: 'Butuh Bantuan?', icon: Iconsax.message_2),
    MenuItem(title: 'Keluar dari akun', icon: Iconsax.logout_1, onTap: () {
      Get.bottomSheet(CustomBottomSheet(
        type: BottomSheetType.confirmation,
        title: 'Quit Account?',
        description: 'Are you sure want to delete this post?',
        firstButtonOnClick: () {
          print('First button clicked');
        },
        secondButtonOnClick: () {
          print('Second button clicked');
        },
      ));
    }),
  ];

  static final activityTypeItems = [
    PickerModel(id: 1, title: 'Refuel', value: 'refuel'),
    PickerModel(id: 2, title: 'Load', value: 'load'),
    PickerModel(id: 3, title: 'Unload', value: 'unload'),
    PickerModel(id: 4, title: 'Workshop', value: 'workshop'),
  ];
}
