import 'dart:convert';

import 'package:hino_driver_app/domain/core/entities/search_result_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static StorageService? _instance;
  static SharedPreferences? _preferences;

  final String IS_FIRST_TIME_LOGIN = "is_first_time_login";
  final String TOKEN = "token";
  final String IS_BIOMETRIC_LOGIN = "is_biometric_login";
  final String SELECTED_LANGUAGE = "selected_language";

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

  bool? getIsBiometricLogin() => _preferences!.getBool(IS_BIOMETRIC_LOGIN);

  void setIsBiometricLogin(bool value) async {
    await _preferences!.setBool(IS_BIOMETRIC_LOGIN, value);
  }

  int getSelectedLanguage() => _preferences!.getInt(SELECTED_LANGUAGE) ?? 0;

  void setSelectedLanguage(int value) async {
    await _preferences!.setInt(SELECTED_LANGUAGE, value);
  }

  void clearToken() async {
    await _preferences!.remove(TOKEN);
  }

  Future<void> saveRecentSearches(List<SearchResult> searchResults) async {
    final searchesJson =
        jsonEncode(searchResults.map((e) => e.toJson()).toList());
    await _preferences!.setString('recent_searches', searchesJson);
  }

  Future<List<SearchResult>> loadRecentSearches() async {
    final searchesJson = _preferences!.getString('recent_searches');

    if (searchesJson != null) {
      final List<dynamic> searchesList = jsonDecode(searchesJson);
      return searchesList.map((json) => SearchResult.fromJson(json)).toList();
    }

    return [];
  }
}
