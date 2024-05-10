import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hino_driver_app/data/locals/StorageService.dart';
import 'package:hino_driver_app/infrastructure/di.dart';
import 'package:hino_driver_app/infrastructure/theme/app_theme.dart';
import 'package:hino_driver_app/infrastructure/translation.dart';

import 'infrastructure/navigation/navigation.dart';
import 'infrastructure/navigation/routes.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var initialRoute = await Routes.initialRoute;


  await setupInjection();

  runApp(Main(initialRoute));
}

class Main extends StatelessWidget {
  final String initialRoute;

  Main(this.initialRoute);

  @override
  // Widget build(BuildContext context) {
  //   return GetMaterialApp(
  //     scaffoldMessengerKey: rootScaffoldMessengerKey,
  //     themeMode: ThemeMode.light,
  //     theme: AppTheme.getLightTheme(),
  //     translations: AppTranslations(),
  //     locale: Get.deviceLocale,
  //     initialRoute: initialRoute,
  //     getPages: Nav.routes,
  //   );
  // }

  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: Future<int>.value(inject<StorageService>().getSelectedLanguage()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show a loading spinner while waiting
        } else {
          Locale locale;
          switch (snapshot.data) {
            case 1:
              locale = Locale('id', 'ID'); // Indonesian
              break;
            case 2:
              locale = Locale('en', 'US'); // English
              break;
            default:
              locale = Get.deviceLocale!;
              break;
          }

          return GetMaterialApp(
            scaffoldMessengerKey: rootScaffoldMessengerKey,
            themeMode: ThemeMode.light,
            theme: AppTheme.getLightTheme(),
            translations: AppTranslations(),
            locale: locale,
            initialRoute: initialRoute,
            getPages: Nav.routes,
          );
        }
      },
    );
  }
}
