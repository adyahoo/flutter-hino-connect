import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localization/flutter_localization.dart';

import 'package:get/get.dart';
import 'package:hino_driver_app/infrastructure/di.dart';
import 'package:hino_driver_app/infrastructure/theme/app_theme.dart';
import 'package:hino_driver_app/infrastructure/translation.dart';

import 'infrastructure/navigation/navigation.dart';
import 'infrastructure/navigation/routes.dart';
import 'package:timezone/data/latest_all.dart' as tz;

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

Future<void> setupNotification() async {
  channel = const AndroidNotificationChannel(
    "local_1",
    "Local 1",
    description: "This channel used for local notification",
    importance: Importance.high,
    playSound: true,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  if (Platform.isAndroid) {
    final androidInfor = await DeviceInfoPlugin().androidInfo;
    final sdkVersion = androidInfor.version.sdkInt;

    if (sdkVersion >= 34) {
      await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestExactAlarmsPermission();
    }
  }

  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
}

void registerNotification() async {
  await setupNotification();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      localizationsDelegates: FlutterLocalization.instance.localizationsDelegates,
      initialRoute: initialRoute,
      getPages: Nav.routes,
    );
  }
}
