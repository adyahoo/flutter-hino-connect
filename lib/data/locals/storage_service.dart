import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static StorageService? _instance;
  static SharedPreferences? _preferences;

  final String IS_FIRST_TIME_LOGIN = "is_first_time_login";
  final String TOKEN = "token";
  final String IS_BIOMETRIC_LOGIN = "is_biometric_login";
  final String SELECTED_LANGUAGE = "selected_language";
  final String LOGIN_ATTEMPT = "login_attempt";
  final String SCHEDULE_NOTIF_FIRED = "schedule_notif_fired"; //flag untuk hide 1 data trip sebelum notif ke trigger (keperluan demo)
  final String SCANNED_VEHICLE_DATE = "scanned_vehicle_date";
  final String IS_VEHICLE_VERIFIED = "is_vehicle_verified"; //flag untuk ngasi tau user udh verif mobil atau belum (keperluan demo, nnti ini dari api flagnya)

  static final String ACTIVITIES_JSON = "activities_json";
  static final String CONTACTS_JSON = "contacts_json";
  static final String PERSONAL_CONTACTS_JSON = "personal_contacts_json";
  static final String EVENTS_JSON = "events_json";
  static final String FEEDBACKS_JSON = "feedbacks_json";
  static final String TRIP_DETAILS_ONE_JSON = "trip_details_one_json";
  static final String TRIPS_ONE_JSON = "trip_one_json";
  static final String TRIP_DETAILS_TWO_JSON = "trip_details_two_json";
  static final String TRIPS_TWO_JSON = "trip_two_json";
  static final String TRIP_DETAILS_THREE_JSON = "trip_details_three_json";
  static final String TRIPS_THREE_JSON = "trip_three_json";
  static final String USERS_JSON = "users_json";
  static final String RECENT_SEARCHES_JSON = "recent_searches_json";
  static final String HINO_DEALERS_JSON = "hino_dealers_json";
  static final String PLACE_NEAR_VENUE_JSON = "place_near_venue_json";
  static final String TRUCKS_JSON = "trucks_json";
  static final String COUNTRIES_JSON = "countries_json";

  //hino dummy json key
  static final String TRIP_DETAIL_HINO_1_JSON = "trip_detail_hino_1_json";
  static final String TRIP_HINO_1_JSON = "trip_hino_1_json";
  static final String TRIP_DETAIL_HINO_2_JSON = "trip_detail_hino_2_json";
  static final String TRIP_HINO_2_JSON = "trip_hino_2_json";
  static final String TRIP_DETAIL_HINO_3_JSON = "trip_detail_hino_3_json";
  static final String TRIP_HINO_3_JSON = "trip_hino_3_json";
  static final String TRIP_DETAIL_HINO_4_JSON = "trip_detail_hino_4_json";
  static final String TRIP_HINO_4_JSON = "trip_hino_4_json";

  static Future<StorageService?> instance() async {
    _instance ??= StorageService();

    _preferences ??= await SharedPreferences.getInstance();

    return _instance;
  }

  bool isFirstTimeLogin() {
    return getIsFirstTimeLogin() != null && getIsFirstTimeLogin() == true;
  }

  bool? getIsFirstTimeLogin() => _preferences!.getBool(IS_FIRST_TIME_LOGIN);

  void setIsFirstTimeLogin(bool value) async {
    await _preferences!.setBool(IS_FIRST_TIME_LOGIN, value);
  }

  String? getToken() => _preferences!.getString(TOKEN);

  void setToken(String token) async {
    await _preferences!.setString(TOKEN, token);
  }

  int? getLoginAttempt() => _preferences!.getInt(LOGIN_ATTEMPT);

  void setLoginAttempt(int counter) async {
    await _preferences!.setInt(LOGIN_ATTEMPT, counter);
  }

  bool? getScheduleNotifFired() => _preferences!.getBool(SCHEDULE_NOTIF_FIRED);

  void setScheduleNotifFired({bool status = true}) async {
    await _preferences!.setBool(SCHEDULE_NOTIF_FIRED, status);
  }

  bool? getIsBiometricLogin() => _preferences!.getBool(IS_BIOMETRIC_LOGIN);

  void setIsBiometricLogin(bool value) async {
    await _preferences!.setBool(IS_BIOMETRIC_LOGIN, value);
  }

  bool? getIsVehicleVerified() => _preferences!.getBool(IS_VEHICLE_VERIFIED);

  void setIsVehicleVerified(bool value) async {
    await _preferences!.setBool(IS_VEHICLE_VERIFIED, value);
  }

  int getSelectedLanguage() => _preferences!.getInt(SELECTED_LANGUAGE) ?? 2;

  void setSelectedLanguage(int value) async {
    await _preferences!.setInt(SELECTED_LANGUAGE, value);
  }

  Future<Map<String, dynamic>?> getJsonData(String key) async {
    final stringJson = await _preferences!.getString(key);

    if (stringJson != null) {
      return json.decode(stringJson);
    }

    return null;
  }

  void setJsonData(String key, Map<String, dynamic> contents) async {
    final jsonEncoded = json.encode(contents);

    await _preferences!.setString(key, jsonEncoded);
  }

  void setJsonDataList(String key, List<dynamic> contents) async {
    final jsonEncoded = json.encode(contents);

    await _preferences!.setString(key, jsonEncoded);
  }

  void clearByKey(String key) async {
    await _preferences!.remove(key);
  }

  void clearById(String key, int id) async {}

  void clearToken() async {
    await _preferences!.remove(TOKEN);
  }

  Future<void> setScannedDate(DateTime date) async {
    await _preferences!.setString(SCANNED_VEHICLE_DATE, date.toIso8601String());
  }

  DateTime? getScannedDate() {
    final dateString = _preferences!.getString(SCANNED_VEHICLE_DATE);
    return dateString != null ? DateTime.parse(dateString) : null;
  }
}
