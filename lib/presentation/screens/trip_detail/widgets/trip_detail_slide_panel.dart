part of '../trip_detail.screen.dart';

enum TripPanel { detail, penalty }

class TripDetailSlidePanel extends GetView<TripDetailController> {
  const TripDetailSlidePanel({super.key, required this.body});

  final Widget body;

  Widget get content {
    switch (controller.currentPanel.value) {
      case TripPanel.detail:
        return DetailPanel(
          onBack: onBack,
          point: controller.data.value?.totalPoint ?? 0,
        );
      case TripPanel.penalty:
        return DetailPenaltyPanel(
          penalty: controller.selectedPenalty.value!,
          onBack: onBack,
          onUpdateNote: (note) {
            controller.updateCurrentPenalty(note);
          },
        );
    }
  }

  void onBack() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    Get.find<TripDetailController>();

    return Obx(
      () {
        return SlidingUpPanel(
          controller: controller.panelController,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: Colors.white,
          isDraggable: false,
          defaultPanelState: PanelState.CLOSED,
          maxHeight: controller.panelMaxHeight.value,
          minHeight: 0,
          panelBuilder: (sc) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(right: 16, bottom: 24, left: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const BsNotch(),
                    Obx(
                      () => content,
                    ),
                  ],
                ),
              ),
            );
          },
          body: body,
        );
      },
    );
  }
}
