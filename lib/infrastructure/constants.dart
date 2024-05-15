import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hino_driver_app/domain/core/entities/model.dart';
import 'package:hino_driver_app/domain/core/entities/trips_model.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';
import 'package:iconsax/iconsax.dart';

class ButtonShapeValue {
  final double radius;

  const ButtonShapeValue({
    required this.radius,
  });
}

class Constants {
  static final MAP_API_KEY = "AIzaSyAzc3CqLAKvVzyciztdOcADxafOs1iYHbs";
  static final DATE_FORMAT_TZ = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
  static final DATE_FORMAT_PENALTY = "dd MMM yyyy, HH:mm";

  static final bottomMainMenu = [
    BottomNavigationBarItem(
      label: 'home'.tr,
      icon: const Icon(Iconsax.home),
    ),
    BottomNavigationBarItem(
      label: 'map'.tr,
      icon: const Icon(Iconsax.map_1),
    ),
    BottomNavigationBarItem(
      label: 'scan'.tr,
      icon: const SizedBox(height: 24),
    ),
    BottomNavigationBarItem(
      label: 'log'.tr,
      icon: const Icon(Iconsax.note_text),
    ),
    BottomNavigationBarItem(
      label: 'sos'.tr,
      icon: const Icon(Iconsax.call_calling),
    ),
  ];

  static final buttonShapeValue = {
    AppButtonShape.rounded: ButtonShapeValue(
      radius: 320,
    ),
    AppButtonShape.rect: ButtonShapeValue(
      radius: 12,
    ),
  };

  static final faceScanInformationItems = [
    {
      'icon': Iconsax.user_search,
      'content': 'face_scan_item_1'.tr,
    },
    {
      'icon': Iconsax.glass_1,
      'content': 'face_scan_item_2'.tr,
    },
  ];

  static final activityTypeItems = [
    PickerModel(id: 1, title: 'Refuel', value: 'refuel'),
    PickerModel(id: 2, title: 'Load', value: 'load'),
    PickerModel(id: 3, title: 'Unload', value: 'unload'),
    PickerModel(id: 4, title: 'Workshop', value: 'workshop'),
  ];

  static final eventTypeItems = [
    PickerModel(id: 1, title: 'Malfunction', value: 'malfunction'),
    PickerModel(id: 2, title: 'Accident', value: 'accident'),
    PickerModel(id: 3, title: 'External Event', value: 'external_event'),
  ];

  static final tripDetailData = TripModel(
    origin: LatLng(-8.681547132266411, 115.24069589508952),
    destination: LatLng(-8.677846354619318, 115.23787020063237),
    penalties: [
      PenaltyModel(
        id: 1,
        coordinate: LatLng(-8.680087825062431, 115.24217508151388),
        type: PenaltyType.brake,
        datetime: "2023-07-20T01:09:49.000000Z",
      ),
      PenaltyModel(
        id: 2,
        coordinate: LatLng(-8.677138607855436, 115.2396055095573),
        type: PenaltyType.over_speed,
        datetime: "2023-07-20T01:09:49.000000Z",
      ),
      PenaltyModel(
        id: 3,
        coordinate: LatLng(-8.677677058199146, 115.24235824877428),
        type: PenaltyType.acceleration,
        datetime: "2023-07-20T01:09:49.000000Z",
      ),
      PenaltyModel(
        id: 4,
        coordinate: LatLng(-8.67707191777169, 115.24227885415357),
        type: PenaltyType.lateral_accel,
        datetime: "2023-07-20T01:09:49.000000Z",
      ),
    ],
  );
}
