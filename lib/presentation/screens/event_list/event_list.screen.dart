import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/event_list.controller.dart';

class EventListScreen extends GetView<EventListController> {
  const EventListScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EventListScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'EventListScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
