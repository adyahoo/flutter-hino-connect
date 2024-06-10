import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:hino_driver_app/infrastructure/theme/app_color.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'controllers/vehicle_scan.controller.dart';

class VehicleScanScreen extends GetView<VehicleScanController> {
  const VehicleScanScreen({Key? key}) : super(key: key);

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

      return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
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
            (controller.result.value != null) ? _renderTimer(context) : const SizedBox(),
          ],
        ),
      );
    });
  }

  Widget _renderTimer(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: BackgroundColor.secondary,
          ),
          alignment: Alignment.center,
          child: Obx(
            () => Text(
              "redirect_home".trParams(
                {
                  "counter": controller.counter.value.inSeconds.toString(),
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          QRView(
            key: controller.qrKey,
            onQRViewCreated: (controller) {
              this.controller.setController(controller);
            },
          ),
          Positioned(
            top: MediaQuery.of(context).viewPadding.top + 16,
            left: 16,
            child: InkWell(
              child: Container(
                width: 40,
                height: 40,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Positioned.fill(
            right: 48,
            left: 48,
            child: SvgPicture.asset(
              "assets/icons/ic_barcode_scan_frame.svg",
            ),
          ),
          Positioned(
            bottom: 0,
            child: _renderContent(context),
          )
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:hino_driver_app/infrastructure/theme/app_color.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// import 'controllers/vehicle_scan.controller.dart';

// class VehicleScanScreen extends GetView<VehicleScanController> {
//   const VehicleScanScreen({Key? key}) : super(key: key);

//   Widget _renderContent(BuildContext context) {
//     return Obx(() {
//       String icon = "ic_warning_circle";
//       String title = "scan_qr_code".tr;
//       String description = "scan_qr_code_desc".tr;

//       if (controller.result.value != null) {
//         icon = "ic_success_circle";
//         title = "scan_code_success".tr;
//         description = "scan_code_success_desc".trParams({
//           "vehicle": controller.result.value?.rawValue ?? "",
//           "plate": controller.result.value?.rawValue ?? "",
//         });
//       }

//       return Container(
//         width: MediaQuery.of(context).size.width,
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(24),
//             topRight: Radius.circular(24),
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SvgPicture.asset(
//               "assets/icons/$icon.svg",
//               height: 40,
//               width: 40,
//             ),
//             const SizedBox(height: 16),
//             Text(
//               title,
//               style: Theme.of(context).textTheme.titleMedium,
//             ),
//             const SizedBox(height: 8),
//             Text(
//               description,
//               style: Theme.of(context)
//                   .textTheme
//                   .bodyMedium
//                   ?.copyWith(color: TextColor.tertiary),
//               textAlign: TextAlign.center,
//             ),
//             if (controller.result.value != null) _renderTimer(context),
//           ],
//         ),
//       );
//     });
//   }

//   Widget _renderTimer(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         const SizedBox(height: 16),
//         Container(
//           width: double.infinity,
//           padding: const EdgeInsets.symmetric(vertical: 4),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(24),
//             color: BackgroundColor.secondary,
//           ),
//           alignment: Alignment.center,
//           child: Obx(
//             () => Text(
//               "redirect_home".trParams(
//                 {"counter": controller.counter.value.inSeconds.toString()},
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           MobileScanner(
//             controller: controller.controller,
//             fit: BoxFit.contain,
//             onDetect: (result) {
//               controller.result.value = result as Barcode?;
//               controller.startRedirectTimer();
//             },
//           ),
//           Positioned(
//             top: MediaQuery.of(context).viewPadding.top + 16,
//             left: 16,
//             child: InkWell(
//               child: Container(
//                 width: 40,
//                 height: 40,
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(100),
//                 ),
//                 child: Icon(
//                   Icons.arrow_back,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//           ),
//           Positioned.fill(
//             right: 48,
//             left: 48,
//             child: SvgPicture.asset(
//               "assets/icons/ic_barcode_scan_frame.svg",
//             ),
//           ),
//           Positioned(
//             bottom: 0,
//             child: _renderContent(context),
//           )
//         ],
//       ),
//     );
//   }
// }

