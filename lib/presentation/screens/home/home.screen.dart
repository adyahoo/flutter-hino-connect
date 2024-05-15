import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hino_driver_app/infrastructure/navigation/routes.dart';

import 'controllers/home.controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeScreen'),
        centerTitle: true,
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            Get.toNamed(Routes.TRIP_DETAIL);
          },
          child: Text(
            'HomeScreen is working ${controller.count.value}',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
