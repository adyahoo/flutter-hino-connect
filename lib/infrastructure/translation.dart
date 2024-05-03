import 'package:get/get_navigation/src/root/internacionalization.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'home': 'Home',
      'trip': 'Trip',
      'scan': 'Scan',
      'feedback': 'Feedback',
      'profile': 'Profile',
    },
    'id_ID': {
      'home': 'Home',
      'trip': 'Perjalanan',
      'scan': 'Scan',
      'feedback': 'Feedback',
      'profile': 'Profil',
    }
  };
}