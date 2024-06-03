import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hino_driver_app/infrastructure/theme/app_color.dart';
import 'package:hino_driver_app/presentation/screens/vehicle_scan/controllers/vehicle_scan.controller.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class VehicleScanSlidePanel extends GetView<VehicleScanController> {
  const VehicleScanSlidePanel({super.key, required this.body});

  final Widget body;

  Widget _renderContent(BuildContext context) {
    return Obx(() {
      String icon = "ic_warning_circle";
      String title = "scan_qr_code".tr;
      String description = "scan_qr_code_desc".tr;

      if (controller.result.value != null) {
        icon = "ic_success_circle";
        title = "scan_code_success".tr;
        description = "scan_code_success_desc".trParams({
          "vehicle": controller.result.value?.code ?? "",
          "plate": controller.result.value?.code ?? "",
        });
      }

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/icons/$icon.svg",
            height: 40,
            width: 40,
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.tertiary),
            textAlign: TextAlign.center,
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      controller: controller.panelController,
      maxHeight: 235,
      minHeight: 0,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      isDraggable: false,
      defaultPanelState: PanelState.OPEN,
      panel: Column(
        children: [
          const BsNotch(),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _renderContent(context),
          ),
        ],
      ),
      body: body,
    );
  }
}
