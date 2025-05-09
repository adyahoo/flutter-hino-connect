class Routes {
  static Future<String> get initialRoute async {
    return SPLASH;
  }

  static const ACTIVITY_LIST = '/activity-list';
  static const EDIT_PROFILE = '/edit-profile';
  static const EMERGENCY_CONTACT_LIST = '/emergency-contact-list';
  static const EVENT_LIST = '/event-list';
  static const FACE_RECOGNITION = '/face-recognition';
  static const FACE_SCAN_INFORMATION = '/face-scan-information';
  static const FEEDBACK = '/feedback';
  static const HOME = '/home';
  static const LOG = '/log';
  static const LOGIN = '/login';
  static const MAIN_TAB = '/main-tab';
  static const MAPS = '/maps';
  static const PROFILE = '/profile';
  static const SCAN_QR = '/scan-qr';
  static const SEARCH = '/search';
  static const SPLASH = '/splash';
  static const TRIP = '/trip';
  static const TRIP_DETAIL = '/trip-detail/:id';
  static const TRIP_LIST = '/trip-list';
  static const VEHICLE_SCAN = '/vehicle-scan';
}
