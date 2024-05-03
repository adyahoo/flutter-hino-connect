import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hino_driver_app/infrastructure/navigation/routes.dart';
import 'package:hino_driver_app/infrastructure/theme/app_color.dart';

import 'controllers/splash.controller.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.isLoading.listen((isLoading) {
      if (!isLoading) {
        Get.offNamed(Routes.LOGIN);
      }
    });

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SvgPicture.asset("assets/images/logo.svg"),
              ),
            ),
            Text(
              'V.1.1',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: TextColor.secondary),
            ),
          ],
        ),
      ),
    );
  }
}
