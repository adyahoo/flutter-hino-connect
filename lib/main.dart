import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:get/get.dart';
import 'package:hino_driver_app/infrastructure/di.dart';
import 'package:hino_driver_app/infrastructure/theme/app_theme.dart';
import 'package:hino_driver_app/infrastructure/translation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'infrastructure/navigation/navigation.dart';
import 'infrastructure/navigation/routes.dart';
import 'package:timezone/data/latest_all.dart' as tz;

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

Future<void> setupNotification() async {
  channel = const AndroidNotificationChannel(
    "local_1",
    "Local 1",
    description: "This channel used for local notification",
    importance: Importance.high,
    playSound: true,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // if (Platform.isAndroid) {
  //   final androidInfor = await DeviceInfoPlugin().androidInfo;
  //   final sdkVersion = androidInfor.version.sdkInt;
  //
  //   if (sdkVersion >= 34) {
  //     await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestExactAlarmsPermission();
  //   }
  // }

  // await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
}

void registerNotification() async {
  await setupNotification();
}

Future<void> clearSecureStorageOnReinstall() async {
  const String key = 'hasRunBefore';
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final hasRunBefore = prefs.getBool(key) ?? false;
  debugPrint('Has run before: $hasRunBefore');

  if (!hasRunBefore) {
    debugPrint(
        'First run detected, clearing secure storage and shared preferences...');
    final FlutterSecureStorage storage = const FlutterSecureStorage();

    try {
      await storage.deleteAll();
      debugPrint('Secure storage cleared.');
    } catch (e) {
      debugPrint('Error clearing secure storage: $e');

      // Handling specific error by reinitializing storage
      if (e.toString().contains('Failed to unwrap key')) {
        await storage.deleteAll(); // Re-attempt to clear storage
        debugPrint(
            'Re-attempted to clear secure storage after key unwrap failure.');
      }
    }

    // Clear SharedPreferences
    await prefs.clear();
    debugPrint('Shared preferences cleared.');

    // Set flag to indicate the app has run before
    await prefs.setBool(key, true);
    debugPrint('Flag set.');
  } else {
    debugPrint(
        'App has run before, not clearing secure storage or shared preferences.');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await clearSecureStorageOnReinstall();
  var initialRoute = await Routes.initialRoute;

  tz.initializeTimeZones();
  registerNotification();
  await setupInjection();

  runApp(Main(initialRoute));
}

class Main extends StatelessWidget {
  final String initialRoute;

  Main(this.initialRoute);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      themeMode: ThemeMode.light,
      theme: AppTheme.getLightTheme(),
      translations: AppTranslations(),
      locale: Get.deviceLocale,
      supportedLocales: [
        Locale('en', 'US'),
        Locale('id', 'ID'),
      ],
      localizationsDelegates:
          FlutterLocalization.instance.localizationsDelegates,
      initialRoute: initialRoute,
      getPages: Nav.routes,
    );
  }
}
