import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/feedback.controller.dart';

class FeedbackScreen extends GetView<FeedbackController> {
  const FeedbackScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FeedbackScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'FeedbackScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
