import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hino_driver_app/data/locals/storage_service.dart';
import 'package:hino_driver_app/domain/core/interfaces/i_use_case.dart';
import 'package:hino_driver_app/infrastructure/di.dart';
import 'package:hino_driver_app/main.dart';

class SplashUseCase implements ISplashUseCase {
  @override
  void writeLocalJson() async {
    await _setJsonData("activities", StorageService.ACTIVITIES_JSON);
    await _setJsonData("contacts", StorageService.CONTACTS_JSON);
    await _setJsonData("events", StorageService.EVENTS_JSON);
    await _setJsonData("trip_details_one", StorageService.TRIP_DETAILS_ONE_JSON);
    await _setJsonData("trip_details_two", StorageService.TRIP_DETAILS_TWO_JSON);
    await _setJsonData("trip_details_three", StorageService.TRIP_DETAILS_THREE_JSON);
    await _setJsonData("trip_one", StorageService.TRIPS_ONE_JSON);
    await _setJsonData("trip_two", StorageService.TRIPS_TWO_JSON);
    await _setJsonData("trip_three", StorageService.TRIPS_THREE_JSON);
    await _setJsonData("users", StorageService.USERS_JSON);
    await _setJsonData("trucks", StorageService.TRUCKS_JSON);
    await _setJsonData("countries", StorageService.COUNTRIES_JSON);

    //dummy trips from hino
    await _setJsonData("trip_detail_hino_1", StorageService.TRIP_DETAIL_HINO_1_JSON);
    await _setJsonData("trip_hino_1", StorageService.TRIP_HINO_1_JSON);
    await _setJsonData("trip_detail_hino_2", StorageService.TRIP_DETAIL_HINO_2_JSON);
    await _setJsonData("trip_hino_2", StorageService.TRIP_HINO_2_JSON);
    await _setJsonData("trip_detail_hino_3", StorageService.TRIP_DETAIL_HINO_3_JSON);
    await _setJsonData("trip_hino_3", StorageService.TRIP_HINO_3_JSON);
    await _setJsonData("trip_detail_hino_4", StorageService.TRIP_DETAIL_HINO_4_JSON);
    await _setJsonData("trip_hino_4", StorageService.TRIP_HINO_4_JSON);

    await _setJsonData("hino_dealers", StorageService.HINO_DEALERS_JSON);
  }

  Future<void> _setJsonData(String assetName, String key) async {
    final res = await DefaultAssetBundle.of(rootScaffoldMessengerKey.currentContext!).loadString('assets/response_helpers/$assetName.json');
    final data = await json.decode(res);
    inject<StorageService>().setJsonData(key, data);
  }
}
