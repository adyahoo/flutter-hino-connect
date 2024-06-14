import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hino_driver_app/data/locals/StorageService.dart';
import 'package:hino_driver_app/domain/core/interfaces/i_use_case.dart';
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

    final tripDetailOneRes = await DefaultAssetBundle.of(rootScaffoldMessengerKey.currentContext!).loadString('assets/response_helpers/trip_details_one.json');
    final tripDetailOneData = await json.decode(tripDetailOneRes);
    inject<StorageService>().setJsonData(StorageService.TRIP_DETAILS_ONE_JSON, tripDetailOneData);

    final tripOneRes = await DefaultAssetBundle.of(rootScaffoldMessengerKey.currentContext!).loadString('assets/response_helpers/trip_one.json');
    final tripOneData = await json.decode(tripOneRes);
    inject<StorageService>().setJsonData(StorageService.TRIPS_ONE_JSON, tripOneData);

    final tripDetailTwoRes = await DefaultAssetBundle.of(rootScaffoldMessengerKey.currentContext!).loadString('assets/response_helpers/trip_details_two.json');
    final tripDetailTwoData = await json.decode(tripDetailTwoRes);
    inject<StorageService>().setJsonData(StorageService.TRIP_DETAILS_ONE_JSON, tripDetailTwoData);

    final tripTwoRes = await DefaultAssetBundle.of(rootScaffoldMessengerKey.currentContext!).loadString('assets/response_helpers/trip_two.json');
    final tripTwoData = await json.decode(tripTwoRes);
    inject<StorageService>().setJsonData(StorageService.TRIPS_ONE_JSON, tripTwoData);

    final tripDetailThreeRes = await DefaultAssetBundle.of(rootScaffoldMessengerKey.currentContext!).loadString('assets/response_helpers/trip_details_three.json');
    final tripDetailThreeData = await json.decode(tripDetailThreeRes);
    inject<StorageService>().setJsonData(StorageService.TRIP_DETAILS_ONE_JSON, tripDetailThreeData);

    final tripThreeRes = await DefaultAssetBundle.of(rootScaffoldMessengerKey.currentContext!).loadString('assets/response_helpers/trip_three.json');
    final tripThreeData = await json.decode(tripThreeRes);
    inject<StorageService>().setJsonData(StorageService.TRIPS_ONE_JSON, tripThreeData);

    final userRes = await DefaultAssetBundle.of(rootScaffoldMessengerKey.currentContext!).loadString('assets/response_helpers/users.json');
    final userData = await json.decode(userRes);
    inject<StorageService>().setJsonData(StorageService.USERS_JSON, userData);

    final hinoDealerRes = await DefaultAssetBundle.of(rootScaffoldMessengerKey.currentContext!).loadString('assets/response_helpers/hino_dealers.json');
    final hinoDealerData = await json.decode(hinoDealerRes);
    inject<StorageService>().setJsonData(StorageService.HINO_DEALERS_JSON, hinoDealerData);
  }
}
