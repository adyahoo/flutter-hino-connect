import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/trip.controller.dart';

class TripScreen extends GetView<TripController> {
  const TripScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TripScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TripScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
