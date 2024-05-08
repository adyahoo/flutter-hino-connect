class Routes {
  static Future<String> get initialRoute async {
    return SPLASH;
  }

  static const FACE_RECOGNITION = '/face-recognition';
  static const FACE_SCAN_INFORMATION = '/face-scan-information';
  static const FEEDBACK = '/feedback';
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const MAIN_TAB = '/main-tab';
  static const PROFILE = '/profile';
  static const SCAN_QR = '/scan-qr';
  static const SPLASH = '/splash';
  static const TRIP = '/trip';
  static const ACTIVITY_LIST = '/activity-list';
}
