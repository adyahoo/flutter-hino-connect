import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hino_driver_app/infrastructure/constants.dart';
import 'package:hino_driver_app/presentation/widgets/app_toggle.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';
import 'package:shimmer/shimmer.dart';

import 'controllers/profile.controller.dart';
import 'package:hino_driver_app/infrastructure/theme/app_color.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends GetView<ProfileController> {
  ProfileScreen({Key? key}) : super(key: key);
  @override
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
                  backgroundImage: NetworkImage(
                    user.profilePic,
                  ), //!PLEASE CHANGE LATER BASED ON THE IMAGE API
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.name,
                        style: Theme.of(context).textTheme.titleMedium),
                    Text(user.email,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: TextColor.tertiary)),
                    Text(user.role,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: TextColor.tertiary)),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Score Card',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: TextColor.secondary)),
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
          Text('Periode April 2024',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: TextColor.secondary)),
          SizedBox(height: 12),
          Container(
            height: 40,
            padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
            decoration: BoxDecoration(
              color: Color(0xFFF1F8F4), //!REPLACE LATER
              borderRadius: BorderRadius.circular(20), //!CHECK LATER
              border: Border.all(
                color: Color(0xFFBCDEC9), //!REPLACE LATER
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Skor Pengemudi',
                    style: Theme.of(context).textTheme.bodyMedium),
                Container(
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(
                              0xFF2D6E50), // Replace with your actual color
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          child: Text(
                            point + ' Poin',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(color: Colors.white),
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

  Widget renderMenuItem(BuildContext context, String title, IconData icon,
      {bool isLastItem = false, Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: isLastItem
              ? null
              : Border(
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
                                status: Get.find<ProfileController>()
                                        .isBiometricLogin
                                        .value
                                    ? AppToggleStatus.active
                                    : AppToggleStatus.inactive,
                                onChanged: (isActive) {
                                  Get.find<ProfileController>()
                                      .toggleSwitch(isActive);
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16),
                        Icon(Icons.arrow_forward_ios,
                            size: 16, color: IconColor.primary),
                      ],
                    ),
                  )
                : Icon(Icons.arrow_forward_ios,
                    size: 16, color: IconColor.primary),
          ],
        ),
      ),
    );
  }

  Widget content(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              // Navigate to "Feedback" screen
              print('Navigate to Feedback screen');
              controller.navigateToFeedback();
            },
            child: Container(
              height: 64,
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: BorderColor.primary,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/note-text.svg',
                        height: 40,
                        width: 40,
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Feedback dari admin',
                              style: Theme.of(context).textTheme.labelLarge),
                          Text(
                            'Ketuk disini untuk melihat',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: TextColor.tertiary),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios,
                      size: 16, color: IconColor.primary),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Text('Akun', style: Theme.of(context).textTheme.labelMedium),
          ListView.separated(
            itemCount: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => SizedBox(height: 0),
            itemBuilder: (context, index) {
              final item = Constants.profileMenuItems[index];
              return renderMenuItem(context, item.title, item.icon,
                  onTap: item.onTap);
            },
          ),
          SizedBox(height: 20),
          Text('Pengaturan lainnya',
              style: Theme.of(context).textTheme.labelMedium),
          ListView.separated(
            itemCount: Constants.profileMenuItems.length - 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => SizedBox(height: 0),
            itemBuilder: (context, index) {
              final item = Constants.profileMenuItems[index + 2];
              return renderMenuItem(context, item.title, item.icon,
                  onTap: item.onTap);
            },
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.0),
        child: AppBar(
          automaticallyImplyLeading: true,
          titleSpacing: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: IconColor.primary),
            onPressed: () => Get.back(),
          ),
          title: Text(
            'profile_title'.tr,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: TextColor.primary),
          ),
          backgroundColor: Color(0xffFFFFFF),
          elevation: 1,
          centerTitle: false,
        ),
      ),
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
                  Obx(() => controller.isFetching.value
                      ? _renderLoading()
                      : profileHeader(context)),
                  content(context),
                  SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
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
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    ShimmerContainer(
                      child: Container(
                        width: 150,
                        height: 20,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    ShimmerContainer(
                      child: Container(
                        width: 100,
                        height: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerContainer(
                  child: Container(
                    width: 100,
                    height: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                ShimmerContainer(
                  child: Container(
                    width: double.infinity,
                    height: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
