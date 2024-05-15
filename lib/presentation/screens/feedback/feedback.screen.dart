import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:hino_driver_app/domain/core/entities/feedback_model.dart';
import 'package:hino_driver_app/infrastructure/theme/app_color.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';

import 'controllers/feedback.controller.dart';

class FeedbackScreen extends GetView<FeedbackController> {
  FeedbackScreen({Key? key}) : super(key: key);

  @override
  Widget feedbackCard(FeedbackModel feedback, BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    feedback.title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(color: TextColor.primary),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'feedback_subtitle'.tr + ' ${feedback.createdBy}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TextColor.secondary),
                  ),
                ],
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SvgPicture.asset('assets/icons/note-text.svg'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const AppStrippedDivider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                feedback.createdAt,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TextColor.primary),
              ),
              TextButton(
                onPressed: () {
                  Get.bottomSheet(SuccessBottomSheet(feedback: feedback, onButtonPressed: () => Get.back()));
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(0),
                ),
                child: Text(
                  'detail_feedback_button_title'.tr,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(color: PrimaryColor.main),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _renderLoading() {
    return ShimmerContainer(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          itemCount: 4,
          itemBuilder: (context, index) => Container(
            height: 120,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          separatorBuilder: (context, index) => const SizedBox(height: 16),
        ),
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
            'feedback'.tr,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: TextColor.primary),
          ),
          backgroundColor: Color(0xffFFFFFF),
          elevation: 1,
          centerTitle: false,
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Obx(
            () {
              if (controller.isFetching.value) {
                return _renderLoading();
              }

              final data = controller.data.value;

              return ListView.separated(
                itemCount: data.length,
                itemBuilder: (context, index) => feedbackCard(data[index], context),
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                padding: const EdgeInsets.symmetric(vertical: 16),
              );
            },
          )),
    );
  }
}
