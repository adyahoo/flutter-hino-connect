import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hino_driver_app/infrastructure/constants.dart';
import 'package:hino_driver_app/presentation/widgets/app_toggle.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';

import 'controllers/profile.controller.dart';
import 'package:hino_driver_app/infrastructure/theme/app_color.dart';

class ProfileScreen extends GetView<ProfileController> {
  ProfileScreen({Key? key}) : super(key: key);

  Widget profileHeader(BuildContext context) {
    final user = controller.data.value;

    return Container(
      color: Color(0xffFAFAFA),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundImage: MemoryImage(
                    base64Decode(user.profilePic),
                  ), //!PLEASE CHANGE LATER BASED ON THE IMAGE API
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.name, style: Theme.of(context).textTheme.titleMedium),
                    Text(user.email, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.tertiary)),
                    Text(user.role, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.tertiary)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('score_title'.tr, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: TextColor.secondary)),
                  const SizedBox(height: 8),
                  scoreCard(user.score, context),
                ],
              )),
        ],
      ),
    );
  }

  Widget scoreCard(String point, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: BorderColor.primary, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('periode_placeholder'.tr, style: Theme.of(context).textTheme.labelMedium?.copyWith(color: TextColor.secondary)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
            decoration: BoxDecoration(
              color: SuccessNewColor().surface, //!REPLACE LATER
              borderRadius: BorderRadius.circular(100), //!CHECK LATER
              border: Border.all(
                color: SuccessNewColor().border, //!REPLACE LATER
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('driver_score_title'.tr, style: Theme.of(context).textTheme.bodyMedium),
                Container(
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: SuccessNewColor().main, // Replace with your actual color
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          child: Text(
                            'point'.trParams({
                              'poin': point,
                            }),
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget renderMenuItem(
    BuildContext context,
    String title,
    IconData icon,
    Function() onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: BorderColor.primary, width: 1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: IconColor.secondary, size: 24),
                const SizedBox(width: 16),
                Text(title, style: Theme.of(context).textTheme.labelLarge),
              ],
            ),
            title == 'biometric_login'.tr
                ? Container(
                    child: Row(
                      children: [
                        Obx(
                          () => Column(
                            children: [
                              AppToggle(
                                status: controller.isBiometricLogin.value ? AppToggleStatus.active : AppToggleStatus.inactive,
                                onChanged: (isActive) {
                                  controller.toggleSwitch(isActive);
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Icon(Icons.arrow_forward_ios, size: 16, color: IconColor.primary),
                      ],
                    ),
                  )
                : Icon(Icons.arrow_forward_ios, size: 16, color: IconColor.primary),
          ],
        ),
      ),
    );
  }

  Widget content(BuildContext context) {
    final profileMenuItems = Constants.profileMenuItems;
    final settingMenuItems = Constants.settingMenuItems;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('account'.tr, style: Theme.of(context).textTheme.labelMedium),
          ListView.builder(
            itemCount: profileMenuItems.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final item = profileMenuItems[index];

              return renderMenuItem(
                context,
                item.title,
                item.icon,
                item.onTap,
              );
            },
          ),
          const SizedBox(height: 20),
          Text('other_setting'.tr, style: Theme.of(context).textTheme.labelMedium),
          ListView.builder(
            itemCount: settingMenuItems.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final item = settingMenuItems[index];

              return renderMenuItem(
                context,
                item.title,
                item.icon,
                item.onTap,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _renderLoading() {
    return Container(
      color: Color(0xffFAFAFA),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                ShimmerContainer(
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerContainer(
                      child: Container(
                        width: 100,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ShimmerContainer(
                      child: Container(
                        width: 150,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ShimmerContainer(
                      child: Container(
                        width: 100,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerContainer(
                  child: Container(
                    width: 100,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                ShimmerContainer(
                  child: Container(
                    width: double.infinity,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'profile_title'.tr),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Obx(() => controller.isFetching.value ? _renderLoading() : profileHeader(context)),
                  content(context),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
