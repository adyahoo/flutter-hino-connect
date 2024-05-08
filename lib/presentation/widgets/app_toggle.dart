import 'package:flutter/material.dart';
import 'package:hino_driver_app/infrastructure/theme/app_color.dart';
import 'package:hino_driver_app/presentation/screens/profile/controllers/profile.controller.dart';
import 'package:get/get.dart';

enum CustomSwitchStatus { active, inactive }

class CustomSwitch extends StatelessWidget {
  CustomSwitch({
    Key? key,
    required this.status,
    this.onChanged,
  }) : super(key: key);

  final CustomSwitchStatus status;
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
      case CustomSwitchStatus.active:
        activeColor = PrimaryColor.main;
        circleColor = Colors.white;
        break;
      case CustomSwitchStatus.inactive:
        activeColor = TextColor.disabled;
        circleColor = Colors.white;
        break;
    }

    return GestureDetector(
      onTap: () {
        profileController.toggleSwitch(status != CustomSwitchStatus.active);
        if (onChanged != null) {
          onChanged!(status != CustomSwitchStatus.active);
        }
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: width,
        height: height,
        padding: EdgeInsets.all(2), // Adjust the padding here
        decoration: BoxDecoration(
          color: activeColor,
          borderRadius: borderRadius,
        ),
        child: Stack(
          children: [
            Align(
              alignment: status == CustomSwitchStatus.active
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


// class CustomSwitch extends StatefulWidget {
//   CustomSwitch({
//     Key? key,
//     required this.status,
//     this.onChanged,
//   }) : super(key: key);

//   final CustomSwitchStatus status;
//   final Function(bool)? onChanged;

//   @override
//   _CustomSwitchState createState() => _CustomSwitchState();
// }

// class _CustomSwitchState extends State<CustomSwitch> {
//   bool isActive = false;

//   @override
//   void initState() {
//     super.initState();
//     isActive = widget.status == CustomSwitchStatus.active;
//   }

//   @override
//   Widget build(BuildContext context) {
//     Color activeColor = PrimaryColor.main; // Change as needed
//     Color inactiveColor = BorderColor.disabled;
//     Color circleColor = Colors.white;
//     double width = 44;
//     double height = 24;
//     EdgeInsets padding = EdgeInsets.only(top: 2);
//     BorderRadius borderRadius = BorderRadius.circular(24 / 2);
//     double opacity = 0;

//     switch (widget.status) {
//       case CustomSwitchStatus.active:
//         activeColor = PrimaryColor.main;
//         circleColor = Colors.white;
//         break;
//       // case CustomSwitchStatus.activeDisabled:
//       //   activeColor = PrimaryColor.main.withOpacity(0.5);
//       //   circleColor = Colors.white;
//       //   break;
//       case CustomSwitchStatus.inactive:
//         activeColor = TextColor.tertiary;
//         circleColor = Colors.white;
//         break;
//       // case CustomSwitchStatus.disabled:
//       //   activeColor = BorderColor.disabled;
//       //   circleColor = TextColor.tertiary;
//       //   break;
//     }

//     return GestureDetector(
//       onTap: () {
//         if (widget.onChanged != null) {
//           setState(() {
//             isActive = !isActive;
//           });
//           widget.onChanged!(isActive);
//         }
//       },
//       child: AnimatedContainer(
//         duration: Duration(milliseconds: 300),
//         width: width,
//         height: height,
//         padding: EdgeInsets.all(2), // Adjust the padding here
//         decoration: BoxDecoration(
//           color: activeColor,
//           borderRadius: borderRadius,
//         ),
//         child: Stack(
//           children: [
//             Align(
//               alignment:
//                   isActive ? Alignment.centerRight : Alignment.centerLeft,
//               child: Container(
//                 width: height - 4, // Adjust the size of the circle here
//                 height: height - 4, // Adjust the size of the circle here
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: circleColor,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
