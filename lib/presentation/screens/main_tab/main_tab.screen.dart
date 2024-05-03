import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hino_driver_app/infrastructure/constants.dart';
import 'package:hino_driver_app/infrastructure/theme/app_color.dart';
import 'package:hino_driver_app/infrastructure/theme/app_theme.dart';
import 'package:hino_driver_app/infrastructure/theme/master_color.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';
import 'package:iconsax/iconsax.dart';

import 'controllers/main_tab.controller.dart';

class MainTabScreen extends GetView<MainTabController> {
  const MainTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(()=> controller.activeScreen.value),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {},
        backgroundColor: BrandColor.color700,
        child: const Icon(Iconsax.scan),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        notchMargin: 10,
        shape: const CircularNotchedRectangle(),
        color: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 10,
        shadowColor: Color(0xFFD3D3D340),
        child: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.activeIndex.value,
            onTap: (value) {
              controller.onTapMenu(value);
            },
            type: BottomNavigationBarType.fixed,
            selectedItemColor: PrimaryColor.main,
            unselectedItemColor: TextColor.placeholder,
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedLabelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: PrimaryColor.main),
            unselectedLabelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: TextColor.placeholder),
            items: Constants.bottomMainMenu,
          ),
        ),
      ),
    );
  }
}
