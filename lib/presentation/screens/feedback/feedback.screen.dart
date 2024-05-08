import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:hino_driver_app/infrastructure/theme/app_color.dart';

import 'controllers/feedback.controller.dart';

class Feedback {
  final String title;
  final String subtitle;

  Feedback({required this.title, required this.subtitle});
}

class FeedbackScreen extends GetView<FeedbackController> {
  FeedbackScreen({Key? key}) : super(key: key);
  @override
  final List<Feedback> feedbackList = [
    Feedback(
      title: 'I have a suggestion',
      subtitle: 'Share your thoughts with us',
    ),
    Feedback(
      title: 'I have a complaint',
      subtitle: 'Share your thoughts with us',
    ),
    Feedback(
      title: 'I have a question',
      subtitle: 'Share your thoughts with us',
    ),
  ];

  Widget feedbackCard(String title, String subtitle, BuildContext context) {
    return Container(
      width: double.infinity,
      height: 124,
      padding: const EdgeInsets.all(16),
      // margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Color(0xffFFFFFF),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Color(0xff000000).withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: TextColor.primary),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: TextColor.secondary),
                  ),
                ],
              ),
              SvgPicture.asset('assets/icons/note-text.svg'),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '24 Aug 2024'.tr,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: TextColor.primary),
              ),
              Text(
                'Lihat Detail'.tr,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: PrimaryColor.main),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.0),
        child: AppBar(
          automaticallyImplyLeading: true,
          titleSpacing: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: IconColor.primary),
            onPressed: () => Get.back(),
          ),
          title: Text(
            'Feedback'.tr,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: TextColor.primary),
          ),
          backgroundColor: Color(0xffFFFFFF),
          elevation: 1,
          centerTitle: false,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: feedbackList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                return feedbackCard(
                  feedbackList[index].title,
                  feedbackList[index].subtitle,
                  context,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
