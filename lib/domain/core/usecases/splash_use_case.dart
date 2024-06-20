import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hino_driver_app/data/locals/StorageService.dart';
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
    await _setJsonData("trip_details_four", StorageService.TRIP_DETAILS_FOUR_JSON);
    await _setJsonData("trip_one", StorageService.TRIPS_ONE_JSON);
    await _setJsonData("trip_two", StorageService.TRIPS_TWO_JSON);
    await _setJsonData("trip_three", StorageService.TRIPS_THREE_JSON);
    await _setJsonData("trip_four", StorageService.TRIPS_FOUR_JSON);
    await _setJsonData("users", StorageService.USERS_JSON);

    final hinoDealerRes = await DefaultAssetBundle.of(rootScaffoldMessengerKey.currentContext!).loadString('assets/response_helpers/hino_dealers.json');
    final hinoDealerData = await json.decode(hinoDealerRes);
    try{
      print('hinoDealerData: $hinoDealerData');
      inject<StorageService>().setJsonData(StorageService.HINO_DEALERS_JSON, hinoDealerData);
      print('hinoDealerData: ${inject<StorageService>().getJsonData(StorageService.HINO_DEALERS_JSON)}');
    }
    catch(e){
      print(e);
    }
  }

  Future<void> _setJsonData(String assetName, String key) async {
    final res = await DefaultAssetBundle.of(rootScaffoldMessengerKey.currentContext!).loadString('assets/response_helpers/$assetName.json');
    final data = await json.decode(res);
    inject<StorageService>().setJsonData(key, data);
  }
}
