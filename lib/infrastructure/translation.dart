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
          'error_password_invalid': 'Password must between 6 and 12 characters',
          'face_scan_title':'Verify your face to keep continue using the application',
          'face_scan_subtitle':'We will compare your face with data in our server',
          'verification':'Verification',
          'face_scan_item_1':'Make sure you face forward and eyes showed clearly',
          'face_scan_item_2':'Clear your face from any accessories. Like glasses or mask',
          'face_scan_tips_info':'Face and background will be captured during this verification process',
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
          'face_scan_title':'Verifikasi wajah untuk melanjutkan menggunakan aplikasi',
          'face_scan_subtitle':'Kami akan membandingkan ini dengan data pada server kami',
          'verification':'Verifikasi',
          'face_scan_item_1':'Pastikan wajah menghadap kedepan dan mata terlihat dengan jelas',
          'face_scan_item_2':'Hapus apa pun yang menutupi wajah Anda. Seperti kacamata dan masker',
          'face_scan_tips_info':'Wajah dan latar belakang akan diambil fotonya saat proses verifikasi ini',
        }
      };
}
