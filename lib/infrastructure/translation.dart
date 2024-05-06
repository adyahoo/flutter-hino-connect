import 'package:get/get_navigation/src/root/internacionalization.dart';

// translation assets for Get but can't do nested key
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
          'error_required': '@label is required',
          'error_email_invalid': 'Email has invalid format',
          'error_password_invalid': 'Password must between 6 and 12 characters'
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
          'error_required': '@label wajib diisi',
          'error_email_invalid': 'Format email salah',
          'error_password_invalid': 'Kata sandi harus 6 sampai 12 karakter',
        }
      };
}
