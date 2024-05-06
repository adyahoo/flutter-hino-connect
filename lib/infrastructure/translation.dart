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
          'login_title': 'Welcome to Hino Connect',
          'login_subtitle': 'Login using email and password created by admin previously.',
          'email_placeholder': 'Ex: jack@hino.com',
          'password': 'Password',
          'password_placeholder': 'Enter password',
          'login': 'Login',
          'profile_title': 'My Account',
        },
        'id_ID': {
          'home': 'Home',
          'trip': 'Perjalanan',
          'scan': 'Scan',
          'feedback': 'Feedback',
          'profile': 'Profil',
          'login_title': 'Selamat datang di Hino Connect',
          'login_subtitle': 'Masuk menggunakan email dan kata sandi yang sudah dibuat dari admin sebelumnya.',
          'email_placeholder': 'Cth: jack@hino.com',
          'password': 'Kata sandi',
          'password_placeholder': 'Masukan kata sandi',
          'login': 'Masuk',
          'profile_title': 'Akun saya',
        },
      };
}
