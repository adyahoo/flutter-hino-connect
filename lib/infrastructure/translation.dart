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
          'or': 'or',
          'biometric_login_title': 'Login with biometric',
          'error_required': '@label is required',
          'error_email_invalid': 'Email has invalid format',
          'error_password_invalid': 'Password must between 6 and 12 characters',
          'error_phone_invalid': 'Invalid phone number',
          'error_biometric_title': 'Error Authenticating Biometric',
          'error_biometric_not_found': 'Biometric feature is not available on your device',
          'error_validation': 'Validation Error',
          'profile_title': 'My Account',
          "score_title": "Score Card",
          "driver_score_title": "Driver Score",
          "point": "@poin Point",
          "periode_placeholder": "Period April 2024",
          "feedback_profile_title": "Feedback from admin",
          "feedback_profile_subtitle": "Tap here to see",
          "account": "Account",
          "other_setting": "Other Setting",
          "edit_profile": "Edit Profile",
          "biometric_login": "Biometric Login",
          "language": "Language",
          "about_us": "About Us",
          "privacy_policy": "Privacy Policy",
          "logout_title": "Logout from your account?",
          "feedback_subtitle": "Created by",
          "detail_feedback_button_title": "See Detail",
          'face_scan_title': 'Verify your face to keep continue using the application',
          'face_scan_subtitle': 'We will compare your face with data in our server',
          'verification': 'Verification',
          'face_scan_item_1': 'Make sure you face forward and eyes showed clearly',
          'face_scan_item_2': 'Remove anything that cover your face, such as glasses and mask',
          'face_scan_tips_info': 'Face and background will be captured during this verification process',
          'edit': 'Edit',
          'delete': 'Delete',
          'map': 'Maps',
          'log': 'Log',
          'sos': 'SOS',
          'activity': 'Activity',
          'event': 'Event',
          'log_activity_event': "Activities and events log",
          'add_activity': "Add Activity",
          'edit_activity': "Edit Activity",
          'fill_activity_form': 'Fill form below to add new activity.',
          'activity_type': 'Activity type',
          'choose_activity': 'Choose activity',
          'date': 'Date',
          'choose_date': 'Choose date',
          'time': 'Time',
          'choose_time': 'Choose time',
          'cancel': 'Cancel',
          'save': 'Save',
          'save_change': 'Save Changes',
          'confirm': 'Confirm',
          'delete_activity_title': 'Delete activity',
          'delete_activity_subtitle': 'Are you sure want to delete this activity?',
          'add_event': "Add Event",
          'edit_event': "Edit Event",
          'fill_event_form': 'Fill form below to add new event.',
          'delete_event_title': 'Delete event',
          'delete_event_subtitle': 'Are you sure want to delete this event?',
          'note': 'Note',
          'note_placeholder': 'Write your note here...',
          'need_help': 'Need help?',
          'contact_us': 'Contact us using these numbers below',
          'call_us': 'Call',
          'total_penalty_point': 'Total penalty point',
          'tap_penalty_icon': 'Tap penalty icon on map to see information detail',
          'back': 'Back',
          'detail_penalty': 'Penalty Detail',
          'device_setting': 'Device default setting',
          'english': 'English',
          'quit_account': 'Quit Account?',
          'are_you_sure_logout': 'Are you sure want to quit from this account?',
          "quit": 'Quit',
          "vehicle_information": "Vehicle Information",
          "trip_list": "Trip List",
          "do_verification_title": "Do vehicle assignment",
          "do_verification_subtitle": "Driver identification is needed before vehicle scan.",
          "no_trip_title": "No trip list yet",
          "no_trip_subtitle": "Trip list will be shown after vehicle verification.",
          "see_all_trip": "See all trips",
          "your_trip_list": "Your Trip List",
          "filter_by_date": "Filter by date",
          "see_vehicle_detail": "See Vehicle Detail",
          "vehicle_detail": "Vehicle Detail",
          "plat_number": "Plate Number",
          "scanned": "Scanned",
          "today_trip": "Today trips",
          "started_at": "Started at",
          "ended_at": "Ended at",
          "trip_duration": "Trip duration",
          "penalty_point": "@poin Penalty Point",
          "no_note": "No note yet",
          "edit_note": "Edit Note",
          "add_note": "Add Note",
          "note_trip_placeholder": "Write your note here...",
          "emergency_contact": "Emergency Contact",
          "add_emergency_contact": "Add Emergency Contact",
          "emergency_tips_content": "You can add one emergency contact to be contacted when emergency situation happens. The emergency contact will be displayed in SOS Dialog.",
          "delete_emergency_contact": "Delete emergency contact?",
          "are_you_sure_delete_emergency": "Are you sure wanna delete this emergency contact?",
          "name": "Name",
          "name_placeholder": "Ex: Jack Putra",
          "phone": "Phone number",
          "phone_placeholder": "ex: 89123123123",
          "edit_emergency_contact": "Edit Emergency Contact",
          "empty_contact_title": "No emergency contact yet",
          "empty_contact_subtitle": "You can add 1 emergency contact to be called through SOS menu.",
          "searchbar_placeholder": "Search place...",
          "recent_search": "Recent Search",
          "location_not_found_title": "Location not found",
          "location_not_found_subtitle": "Try to use another keyword to find the location",
          "photo_profile": "Photo Profile",
          "full_name": "Full Name",
          'country_code': 'Country Code',
          'searchbar_phonecode_placeholder': 'Search country code...',
          "image_picker_gallery": "Choose Photo",
          "image_picker_camera": "Take from Camera",
          "scan_qr_code": "Scan QR Code",
          "scan_qr_code_desc": "Application will scan the QR code automatically",
          "scan_code_success": "Code scanned successfully",
          "scan_code_success_desc": "Scan proccess success for @vehicle vehicle with @plate",
          "redirect_home": "Redirecting to home in...@counter",
          "welcome": "Welcome",
          "welcome_subtitle": "Scan your vehicle to get your task and trip route",
          "face_scan_success": "Face ID recognized successfully",
          "biometric_warning_title": "The biometric feature is not yet active",
          "biometric_warning_description":
              "You have not enabled biometrics in the Hino Driver application on your device. Please login first, then activate the \"Biometric Login\" feature in the profile menu.",
          "no_today_trip_title": "No Trip list for today yet",
          "no_today_trip_subtitle": "You dont have list of today trips to view yet.",
          "face_recognition_subtitle": "Make sure your face is within the oval frame",
          "trip_not_found_title": "Trip not found",
          "trip_not_found_subtitle": "Try using different dates or remove the filter to find your trips.",
          "remove_filter": "Remove Filter",
          "empty_trip_title": "No trip list yet",
          "empty_trip_subtitle": "Trip list will display after you complete your tasks and will be add by the Hino Driver Admin.",
          "empty_activity_title": "Activities not exist",
          "empty_activity_desc": "You dont have any activities to show. Please add activity to record your activities on duty",
          "empty_event_title": "Events not exist",
          "empty_event_desc": "You dont have any events to show. You can add event or the Admin will add the event for you",
          "scanning_face": "Scanning face...",
          "scan_face_completed": "Scanning face complete...",
          "face_detected_successfully": "Driver successfully identified",
          "filter_gas_station": "Gas Station",
          "filter_service_center": "Service Center",
          "filter_restaurant": "Restaurant",
          "filter_car_dealer": "Dealer",
          "filter_drive_to": "Drive To",
          "see_route": "See Route",
          "permission_denied_title": "Permission Denied",
          "permission_denied_desc": "Please give permission to access this feature.",
          "permission_permanent_denied_title": "Permission Denied",
          "permission_permanent_denied_desc": "Please give permission through the device's setting to access this feature.",
          "go_to_setting": "Open Setting",
          "schedule_notif_title": "Check your recent completed trip",
          "schedule_notif_desc": "Trip data for @origin to @destination now available to be seen.",
          "error_connection": "Connection Error",
          "error_connection_desc": "Cannot connect to server. Please check your internet connection.",
          "error_time_picker": "Time cannot be in the future",
          "assign": "Assign",
          "event_type": "Event type",
          "choose_event": "Choose event",
          "face_detected_failed": "Driver's face identification failed",
          "try_again": "Try Again",
          "debug_option": "Debug option",
          "force_vehicle_title": 'Force vehicle assignment',
          "force_vehicle_description": "You can skip this step to access your vehicle and trip data.",
          "force_vehicle_confirmation_desc": "Are you sure to skip this face verification process? You will be navigated to main screen directly with your vehicle and trip data.",
          "manual_capture_desc":"Our system can't detect your face. Please send picture manually with button below to do manual verification.",
          "capture_send":"Capture and send",
          "face_detecting":"Recognizing your photo with data in our system..."
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
          'or': 'atau',
          'biometric_login_title': 'Masuk dengan biometrik',
          'error_required': '@label wajib diisi',
          'error_email_invalid': 'Format email salah',
          'error_password_invalid': 'Kata sandi harus 6 sampai 12 karakter',
          'error_phone_invalid': 'Nomor telepon tidak valid',
          'error_biometric_title': 'Autentikasi Biometrik Gagal',
          'error_biometric_not_found': 'Fitur biometrik tidak tersedia pada perangkat anda',
          'error_validation': 'Error Validasi',
          'profile_title': 'Akun Saya',
          "score_title": "Kartu Skor",
          "driver_score_title": "Skor Driver",
          "point": "@poin Poin",
          "periode_placeholder": "Periode April 2024",
          "feedback_profile_title": "Feedback dari admin",
          "feedback_profile_subtitle": "Ketuk disini untuk melihat",
          "account": "Akun",
          "other_setting": "Pengaturan Lainnya",
          "edit_profile": "Edit Profil",
          "biometric_login": "Login Biometrik",
          "language": "Bahasa",
          "about_us": "Tentang Kami",
          "privacy_policy": "Kebijakan Privasi",
          "logout_title": "Keluar dari akun?",
          "feedback_subtitle": "Dibuat oleh",
          "detail_feedback_button_title": "Lihat Detail",
          'face_scan_title': 'Verifikasi wajah untuk melanjutkan menggunakan aplikasi',
          'face_scan_subtitle': 'Kami akan membandingkan wajah anda dengan data pada server kami',
          'verification': 'Verifikasi',
          'face_scan_item_1': 'Pastikan wajah menghadap kedepan dan mata terlihat dengan jelas',
          'face_scan_item_2': 'Lepas apa pun yang menutupi wajah Anda, seperti kacamata dan masker',
          'face_scan_tips_info': 'Wajah dan latar belakang akan diambil fotonya saat proses verifikasi ini',
          'edit': 'Ubah',
          'delete': 'Hapus',
          'map': 'Peta',
          'log': 'Log',
          'sos': 'SOS',
          'activity': 'Aktivitas',
          'event': 'Event',
          'log_activity_event': "Log aktivitas dan event",
          'add_activity': "Tambah Aktivitas",
          'edit_activity': "Ubah Aktivitas",
          'fill_activity_form': 'Lengkapi formulir dibawah untuk menambahkan aktivitas.',
          'activity_type': 'Tipe aktivitas',
          'choose_activity': 'Pilih aktivitas',
          'date': 'Tanggal',
          'choose_date': 'Pilih tanggal',
          'time': 'Jam',
          'choose_time': 'Pilih jam',
          'cancel': 'Batalkan',
          'save': 'Simpan',
          'save_change': 'Simpan Perubahan',
          'confirm': 'Konfirmasi',
          'delete_activity_title': 'Hapus aktivitas',
          'delete_activity_subtitle': 'Apakah Anda yakin ingin menghapus aktivitas ini?',
          'add_event': "Tambah Event",
          'edit_event': "Ubah Event",
          'fill_event_form': 'Lengkapi formulir dibawah untuk menambahkan event.',
          'delete_event_title': 'Hapus event',
          'delete_event_subtitle': 'Apakah Anda yakin ingin menghapus event ini?',
          'note': 'Catatan',
          'note_placeholder': 'Tulis catatan disini...',
          'need_help': 'Perlu bantuan?',
          'contact_us': 'Hubungi kami lewat kontak dibawah ini',
          'call_us': 'Hubungi',
          'total_penalty_point': 'Jumlah poin penalti',
          'tap_penalty_icon': 'Ketuk pada ikon penalti di map untuk menampilkan detail informasi',
          'back': 'Kembali',
          'detail_penalty': 'Detail Penalti',
          'device_setting': 'Sesuai pengaturan perangkat',
          'english': 'Inggris',
          'quit_account': 'Keluar akun?',
          'are_you_sure_logout': 'Apakah Anda yakin ingin keluar dari akun ini?',
          "quit": 'Keluar',
          "vehicle_information": "Informasi kendaraan",
          "trip_list": "Daftar Perjalanan",
          "do_verification_title": "Lakukan penugasan kendaraan",
          "do_verification_subtitle": "Identifikasi supir diperlukan sebelum melakukan pemindaian kendaraan.",
          "no_trip_title": "Belum ada daftar perjalanan",
          "no_trip_subtitle": "Daftar perjalanan akan ditampilkan setelah kendaraan berhasil discan.",
          "see_all_trip": "Lihat semua perjalanan",
          "your_trip_list": "Daftar perjalanan Anda",
          "filter_by_date": "Filter berdasarkan tanggal",
          "see_vehicle_detail": "Lihat Detail Kendaraan",
          "vehicle_detail": "Detail Kendaraan",
          "plat_number": "Pelat Nomor",
          "scanned": "Discan",
          "today_trip": "Perjalanan hari ini",
          "started_at": "Dimulai pada",
          "ended_at": "Selesai pada",
          "trip_duration": "Durasi perjalanan",
          "penalty_point": "@poin Poin Penalti",
          "no_note": "Belum ada catatan",
          "edit_note": "Ubah Catatan",
          "add_note": "Tambah Catatan",
          "note_trip_placeholder": "Tulis catatan disini...",
          "emergency_contact": "Kontak Darurat",
          "add_emergency_contact": "Tambah Kontak Darurat",
          "emergency_tips_content": "Anda dapat menambah satu kontak darurat yang ingin Anda hubungi ketika situasi darurat. Kontak darurat akan ditampilkan pada dialog SOS.",
          "delete_emergency_contact": "Hapus kontak darurat?",
          "are_you_sure_delete_emergency": "Apakah Anda yakin ingin menghapus kontak darurat ini?",
          "name": "Nama",
          "name_placeholder": "Cth: Jack Putra",
          "phone": "Nomor telepon",
          "phone_placeholder": "Cth: 089123123123",
          "edit_emergency_contact": "Ubah Kontak Darurat",
          "empty_contact_title": "Belum ada kontak darurat",
          "empty_contact_subtitle": "Anda dapat menambahkan 1 kontak darurat untuk dihubungi dengan cepat lewat menu SOS.",
          "searchbar_placeholder": "Cari tempat...",
          "recent_search": "Pencarian terakhir",
          "location_not_found_title": "Lokasi tidak ditemukan",
          "location_not_found_subtitle": "Coba menggunakan kata kunci lain untuk menemukan lokasi.",
          "photo_profile": "Foto Profil",
          "full_name": "Nama Lengkap",
          'country_code': 'Kode Negara',
          'searchbar_phonecode_placeholder': 'Cari kode negara...',
          "image_picker_gallery": "Pilih Foto",
          "image_picker_camera": "Ambil dari Kamera",
          "scan_qr_code": "Scan Kode QR",
          "scan_qr_code_desc": "Aplikasi akan otomatis melakukan scan pada kode QR kendaraan.",
          "scan_code_success": "Kode berhasil dibaca",
          "scan_code_success_desc": "Scan berhasil untuk mobil @vehicle dengan @plate",
          "redirect_home": "Mengarahkan ke beranda dalam...@counter",
          "welcome": "Selamat Datang",
          "welcome_subtitle": "Scan kendaraan untuk mendapatkan tugas dan rute perjalanan Anda",
          "face_scan_success": "ID wajah sukses dikenali",
          "biometric_warning_title": "Fitur biometrik belum aktif",
          "biometric_warning_description":
              "Anda belum mengaktifkan biometrik di aplikasi Hino Driver di perangkat Anda. Silakan login terlebih dahulu, kemudian aktifkan fitur \"Login Biometrik\" pada menu profil.",
          "no_today_trip_title": "Daftar perjalanan hari ini belum ada",
          "no_today_trip_subtitle": "Anda belum mempunyai daftar perjalanan hari ini untuk dilihat.",
          "face_recognition_subtitle": "Pastikan wajah anda berada di frame oval",
          "trip_not_found_title": "Perjalanan tidak ditemukan",
          "trip_not_found_subtitle": "Coba menggunakan tanggal lain atau hapus filter tanggal untuk menemukan perjalanan yang Anda.",
          "remove_filter": "Hapus Filter",
          "empty_trip_title": "Daftar perjalanan belum ada",
          "empty_trip_subtitle": "Daftar perjalanan akan ditampilkan setelah Anda menyelesaikan tugas Anda dan akan diinputkan oleh Admin Hino Driver.",
          "empty_activity_title": "Aktivitas belum ada",
          "empty_activity_desc": "Anda belum punya aktivitas untuk ditampilkan. Tambah aktivitas untuk mempermudah pencatatan aktivitas saat bertugas.",
          "empty_event_title": "Event belum ada",
          "empty_event_desc": "Anda belum punya event untuk ditampilkan. Anda dapat menambahkan event atau Admin akan menambahkan event untuk Anda.",
          "scanning_face": "Sedang memindai wajah...",
          "scan_face_completed": "Berhasil memindai wajah...",
          "face_detected_successfully": "Driver sukses untuk diidentifikasi",
          "filter_gas_station": "Pom Bensin",
          "filter_service_center": "Pusat Servis",
          "filter_restaurant": "Restoran",
          "filter_car_dealer": "Dealer",
          "see_route": "Lihat Rute",
          "filter_drive_to": "Menuju ke",
          "permission_denied_title": "Izin Akses Ditolak",
          "permission_denied_desc": "Silahkan berikan akses untuk menggunakan fitur ini.",
          "permission_permanent_denied_title": "Izin Akses Ditolak",
          "permission_permanent_denied_desc": "Silahkan menuju pengaturan perangkat untuk memberikan akses fitur ini.",
          "go_to_setting": "Buka Pengaturan",
          "schedule_notif_title": "Silahkan cek trip anda yang baru saja selesai",
          "schedule_notif_desc": "Data Trip anda untuk @origin menuju @destination sekarang sudah dapat dilihat.",
          "error_connection": "Error pada Koneksi",
          "error_connection_desc": "Tidak dapat terhubung ke server. Periksa koneksi internet Anda.",
          "error_time_picker": "Waktu tidak boleh melebihi waktu sekarang",
          "assign": "Penugasan",
          "event_type": "Tipe event",
          "choose_event": "Pilih event",
          "face_detected_failed": "Wajah driver gagal diidentifikasi",
          "try_again": "Coba Lagi",
          "debug_option": "Opsi debug",
          "force_vehicle_title": 'Force vehicle assignment',
          "force_vehicle_description": 'Anda bisa lewati tahap ini untuk mengakses data kendaraan dan perjalanan Anda.',
          "force_vehicle_confirmation_desc": "Apakah Anda yakin untuk melewati tahap verifikasi wajah ini? Anda akan langsung diarahkan ke halaman utama dengan data kendaraan dan perjalanan Anda.",
          "manual_capture_desc":"Sistem kami tidak dapat mendeteksi wajah Anda. Silakan mengirim foto secara manual dengan tekan tombol dibawah untuk melakukan verifikasi manual.",
          "capture_send":"Ambil foto dan kirim",
          "face_detecting":"Mencocokan foto wajah pada sistem kami..."
        }
      };
}
