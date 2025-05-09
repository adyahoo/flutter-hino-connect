import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:hino_driver_app/infrastructure/constants.dart';
import 'package:hino_driver_app/infrastructure/theme/app_color.dart';
import 'package:hino_driver_app/presentation/screens/face_scan_information/widgets/information_item.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';
import 'package:iconsax/iconsax.dart';

import 'controllers/face_scan_information.controller.dart';

class FaceScanInformationScreen extends GetView<FaceScanInformationController> {
  const FaceScanInformationScreen({Key? key}) : super(key: key);

  Widget _renderInformationItem() {
    final data = Constants.faceScanInformationItems;

    return ListView.separated(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (context, index) => InformationItem(data[index]),
      separatorBuilder: (context, index) => const SizedBox(height: 24),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(forceMaterialTransparency: true),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding:
                  EdgeInsets.only(bottom: 80),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      "assets/images/face_scan_illust.svg",
                      height: 211,
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'face_scan_title'.tr,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'face_scan_subtitle'.tr,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: TextColor.secondary),
                          ),
                          const SizedBox(height: 16),
                          _renderInformationItem(),
                          const SizedBox(height: 32),
                          AppTips(
                            content: 'face_scan_tips_info'.tr,
                            variant: WidgetVariant.info,
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 32, left: 16, right: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppButton.icon(
                    label: 'verification'.tr,
                    onPress: controller.navigateFaceRecog,
                    type: AppButtonType.filled,
                    icon: Iconsax.scan,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
