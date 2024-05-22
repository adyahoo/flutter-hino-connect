import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hino_driver_app/data/locals/StorageService.dart';
import 'package:hino_driver_app/infrastructure/di.dart';
import 'package:hino_driver_app/infrastructure/navigation/routes.dart';
import 'package:hino_driver_app/main.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashController extends GetxController {
  final isLoading = true.obs;

  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    _checkPermission();
    _checkLocalJson();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> _checkPermission() async {
    final permissions = [Permission.location];

    final result = await permissions.request();

    result.forEach((key, value) {
      switch (value) {
        case PermissionStatus.denied:
          navigateLogin();
          break;
        case PermissionStatus.granted:
          navigateLogin();
          break;
        case PermissionStatus.restricted:
          navigateLogin();
          break;
        case PermissionStatus.permanentlyDenied:
          navigateLogin();
          break;
        default:
          navigateLogin();
          break;
      }
    });
  }

  void _openAppSetting() {}

  void navigateLogin() {
    Future.delayed(const Duration(seconds: 3), () {
      if (inject<StorageService>().getToken() != null)
        Get.offNamed(Routes.MAIN_TAB);
      else
        Get.offNamed(Routes.LOGIN);
    });
  }

  void _checkLocalJson() async {
    final jsonData = await inject<StorageService>().getJsonData(StorageService.USERS_JSON);

    if (jsonData != null) {
      return;
    }

    _writeLocalJson();
  }

  void _writeLocalJson() async {
    final activityRes = await DefaultAssetBundle.of(rootScaffoldMessengerKey.currentContext!).loadString('assets/response_helpers/activities.json');
    final activityData = await json.decode(activityRes);
    inject<StorageService>().setJsonData(StorageService.ACTIVITIES_JSON, activityData);

    final contactRes = await DefaultAssetBundle.of(rootScaffoldMessengerKey.currentContext!).loadString('assets/response_helpers/contacts.json');
    final contactData = await json.decode(contactRes);
    inject<StorageService>().setJsonData(StorageService.CONTACTS_JSON, contactData);

    final eventRes = await DefaultAssetBundle.of(rootScaffoldMessengerKey.currentContext!).loadString('assets/response_helpers/events.json');
    final eventData = await json.decode(eventRes);
    inject<StorageService>().setJsonData(StorageService.EVENTS_JSON, eventData);

    final tripDetailRes = await DefaultAssetBundle.of(rootScaffoldMessengerKey.currentContext!).loadString('assets/response_helpers/trip_details.json');
    final tripDetailData = await json.decode(tripDetailRes);
    inject<StorageService>().setJsonData(StorageService.TRIP_DETAILS_JSON, tripDetailData);

    final tripRes = await DefaultAssetBundle.of(rootScaffoldMessengerKey.currentContext!).loadString('assets/response_helpers/trips.json');
    final tripData = await json.decode(tripRes);
    inject<StorageService>().setJsonData(StorageService.TRIPS_JSON, tripData);

    final userRes = await DefaultAssetBundle.of(rootScaffoldMessengerKey.currentContext!).loadString('assets/response_helpers/users.json');
    final userData = await json.decode(userRes);
    inject<StorageService>().setJsonData(StorageService.USERS_JSON, userData);
  }
}
