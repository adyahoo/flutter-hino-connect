import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/profile.controller.dart';
import 'package:hino_driver_app/infrastructure/theme/app_color.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({Key? key}) : super(key: key);
  @override

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
            padding: const EdgeInsets.all(16),
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
      boxShadow: [
        BoxShadow(
          color: BorderColor.primary.withOpacity(0),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
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
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium),
              Icon(Icons.arrow_forward_ios, size: 16, color: IconColor.secondary),
            ],
          ),
        ),
        SizedBox(height: 16),
        Container(
          height: 40,
          padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
          decoration: BoxDecoration(
            color: Color(0xffF0F6FE), //!REPLACE LATER
            borderRadius: BorderRadius.circular(20), //!CHECK LATER
            border: Border.all(
              color: Color(0xffDDEAFC), //!REPLACE LATER
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Nilai KPI',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium),
              Icon(Icons.arrow_forward_ios, size: 16, color: IconColor.secondary),
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
            Icon(icon, color: IconColor.primary),
            const SizedBox(width: 16),
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        Icon(Icons.arrow_forward_ios, size: 16, color: IconColor.secondary),
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
        Text('Akun', style: Theme.of(context).textTheme.bodyMedium),
        menuItem(context, 'Edit Profile', Icons.person),
        menuItem(context, 'Biometric Login', Icons.fingerprint),
        SizedBox(height: 20),
        Text('Pengaturan lainnya', style: Theme.of(context).textTheme.bodyMedium),
        menuItem(context, 'Bahasa', Icons.language),
        menuItem(context, 'Tentang Kami', Icons.info),
        menuItem(context, 'Kebijakan Privasi', Icons.privacy_tip),
        menuItem(context, 'Butuh Bantuan?', Icons.help),
        menuItem(context, 'Keluar dari akun', Icons.logout),
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
            icon: Icon(Icons.notifications),
            color: Colors.white,
            onPressed: () {
              // Handle the bell icon press here
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            profileHeader(context),
            listMenu(context),
          ],
        ),
      ),
    );
  }
}
