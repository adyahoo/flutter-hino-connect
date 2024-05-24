import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hino_driver_app/data/locals/StorageService.dart';
import 'package:hino_driver_app/domain/core/interfaces/i_splash_use_case.dart';
import 'package:hino_driver_app/infrastructure/di.dart';
import 'package:hino_driver_app/main.dart';

class SplashUseCase implements ISplashUseCase {
  @override
  void writeLocalJson() async {
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
