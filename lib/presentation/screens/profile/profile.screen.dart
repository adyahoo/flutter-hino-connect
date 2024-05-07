import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hino_driver_app/presentation/widgets/app_toggle.dart';

import 'controllers/profile.controller.dart';
import 'package:hino_driver_app/infrastructure/theme/app_color.dart';
import 'package:iconsax/iconsax.dart';


class ProfileScreen extends GetView<ProfileController> {
  // const ProfileScreen({Key? key}) : super(key: key);
  @override
  final ProfileController profileController = Get.put(ProfileController());

  Widget profileHeader(BuildContext context) {
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
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Arya Utama',
                        style: Theme.of(context).textTheme.titleMedium),
                    Text('aryautama123@gmail.com',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: TextColor.tertiary)),
                    Text('Driver',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: TextColor.tertiary)),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
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
                  scoreCard(context),
                ],
              )),
        ],
      ),
    );
  }

  Widget scoreCard(BuildContext context) {
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
                Text('Nilai Kompetensi',
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
                              horizontal: 8.0, vertical: 4),
                          child: Text(
                            '4.5 / 5.0',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_ios,
                          size: 16, color: IconColor.secondary),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Container(
            height: 40,
            padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
            decoration: BoxDecoration(
              color: Color(0xffDDEAFC), //!REPLACE LATER
              borderRadius: BorderRadius.circular(20), //!CHECK LATER
              border: Border.all(
                color: Color(0xffF0F6FE), //!REPLACE LATER
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Nilai KPI',
                    style: Theme.of(context).textTheme.bodyMedium),
                Container(
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(
                              0xff3267E3), // Replace with your actual color
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4),
                          child: Text(
                            '4.2 / 5.0',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_ios,
                          size: 16, color: IconColor.secondary),
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

  Widget menuItem(BuildContext context, String title, IconData icon) {
    return Container(
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
              Icon(icon, color: IconColor.secondary),
              const SizedBox(width: 16),
              Text(title, style: Theme.of(context).textTheme.labelLarge),
            ],
          ),
          title == 'Biometric Login'
              ? Container(
                  child: Row(
                    children: [
                      GetBuilder<ProfileController>(
                        builder: (controller) => Column(
                          children: [
                            CustomSwitch(
                              status: controller.isBiometricLogin.value
                                  ? CustomSwitchStatus.active
                                  : CustomSwitchStatus.inactive,
                              onChanged: (isActive) {
                                controller.toggleSwitch(isActive);
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_ios,
                          size: 16, color: IconColor.primary),
                    ],
                  ),
                )
              : Icon(Icons.arrow_forward_ios,
                  size: 16, color: IconColor.primary),
        ],
      ),
    );
  }

  Widget listMenu(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Akun', style: Theme.of(context).textTheme.labelMedium),
          menuItem(context, 'Edit Profile', Iconsax.edit_25),
          menuItem(context, 'Biometric Login', Iconsax.scan5),
          SizedBox(height: 20),
          Text('Pengaturan lainnya',
              style: Theme.of(context).textTheme.bodyMedium),
          menuItem(context, 'Bahasa', Iconsax.language_circle5),
          menuItem(context, 'Tentang Kami', Iconsax.note_21),
          menuItem(context, 'Kebijakan Privasi', Iconsax.check5),
          menuItem(context, 'Butuh Bantuan?', Iconsax.chart),
          menuItem(context, 'Keluar dari akun', Iconsax.logout_15),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('profile_title'.tr),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [0.1135, 0.8965],
              colors: [
                Color(0xffD9565B),
                Color(0xffD44042),
              ],
            ),
          ),
        ),
        titleTextStyle: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: Colors.white),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Iconsax.notification),
            color: Colors.white,
            //add border
            onPressed: () {
              print('check clicked');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            profileHeader(context),
            listMenu(context),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
