import 'package:flutter/material.dart';
import 'package:hino_driver_app/infrastructure/theme/app_color.dart';
import 'package:hino_driver_app/presentation/screens/profile/controllers/profile.controller.dart';
import 'package:get/get.dart';

enum AppToggleStatus { active, inactive }

class AppToggle extends StatelessWidget {
  AppToggle({
    Key? key,
    required this.status,
    this.onChanged,
  }) : super(key: key);

  final AppToggleStatus status;
  final Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find<ProfileController>();

    Color activeColor = PrimaryColor.main; // Change as needed
    Color inactiveColor = BorderColor.disabled;
    Color circleColor = Colors.white;
    double width = 44;
    double height = 24;
    EdgeInsets padding = EdgeInsets.only(top: 2);
    BorderRadius borderRadius = BorderRadius.circular(24 / 2);
    double opacity = 0;

    switch (status) {
      case AppToggleStatus.active:
        activeColor = PrimaryColor.main;
        circleColor = Colors.white;
        break;
      case AppToggleStatus.inactive:
        activeColor = TextColor.disabled;
        circleColor = Colors.white;
        break;
    }

    return GestureDetector(
      onTap: () {
        profileController.toggleSwitch(status != AppToggleStatus.active);
        if (onChanged != null) {
          onChanged!(status != AppToggleStatus.active);
        }
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: width,
        height: height,
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: activeColor,
          borderRadius: borderRadius,
        ),
        child: Stack(
          children: [
            Align(
              alignment: status == AppToggleStatus.active
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Container(
                width: height - 4, // Adjust the size of the circle here
                height: height - 4, // Adjust the size of the circle here
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: circleColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
