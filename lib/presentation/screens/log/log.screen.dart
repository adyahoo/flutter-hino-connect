import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hino_driver_app/infrastructure/theme/app_color.dart';
import 'package:hino_driver_app/presentation/screens.dart';

import 'controllers/log.controller.dart';

class LogScreen extends GetView<LogController> {
  const LogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'log_activity_event'.tr,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
        ),
        backgroundColor: PrimaryColor.main,
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              indicator: UnderlineTabIndicator(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                borderSide: BorderSide(width: 4, color: PrimaryColor.main),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(
                  text: "activity".tr,
                ),
                Tab(
                  text: "event".tr,
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ActivityListScreen(),
                  FeedbackScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
