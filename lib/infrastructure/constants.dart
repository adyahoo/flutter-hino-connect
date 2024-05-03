import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class Constants {
  static final bottomMainMenu = [
    BottomNavigationBarItem(
      label: 'home'.tr,
      icon: const Icon(Iconsax.home),
    ),
    BottomNavigationBarItem(
      label: 'trip'.tr,
      icon: const Icon(Iconsax.location),
    ),
    BottomNavigationBarItem(
      label: 'scan'.tr,
      icon: const SizedBox(height: 24),
    ),
    BottomNavigationBarItem(
      label: 'feedback'.tr,
      icon: const Icon(Iconsax.message_text),
    ),
    BottomNavigationBarItem(
      label: 'profile'.tr,
      icon: const Icon(Iconsax.user),
    ),
  ];
}
