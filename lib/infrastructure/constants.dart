import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hino_driver_app/data/locals/StorageService.dart';
import 'package:hino_driver_app/domain/core/entities/map_filter_model.dart';
import 'package:hino_driver_app/domain/core/entities/model.dart';
import 'package:hino_driver_app/infrastructure/di.dart';
import 'package:hino_driver_app/infrastructure/navigation/routes.dart';
import 'package:hino_driver_app/infrastructure/utils.dart';
import 'package:hino_driver_app/presentation/screens/profile/controllers/profile.controller.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';
import 'package:iconsax/iconsax.dart';

class ButtonShapeValue {
  final double radius;

  const ButtonShapeValue({
    required this.radius,
  });
}

class MenuItem {
  final String title;
  final IconData icon;
  final Function() onTap;

  const MenuItem({
    required this.title,
    required this.icon,
    required this.onTap,
  });
}

class Constants {
  static final MAP_API_KEY = "AIzaSyDZKwVj-h7dPFpdgBRNZ4WhkFtd0Mkv128";
  static const DATE_FORMAT_TZ = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
  static final DATE_FORMAT_PENALTY = "dd MMM yyyy, HH:mm";
  static final DATE_FORMAT_TRIP = "EEEE, dd MMMM yyyy";
  static final BASE_URL = "https://dev-weeo.timedoor-host.web.id/api/mobile/v1/";

  static final venueLocation = LatLng(-6.3003589142707925, 106.63645869332062);

  //hino dealer facility
  static final String FACILITY_1S = '1S';
  static final String FACILITY_2S = '2S';
  static final String FACILITY_HMSI_2S = 'HMSI 2S';
  static final String FACILITY_3S = '3S';
  static final String FACILITY_SERPO = 'SERPO';

  //type of marker
  static const String TYPE_CAR_DEALER = 'car_dealer';
  static const String TYPE_SERVICE_CENTER = 'service_center';
  static const String TYPE_GAS_STATION = 'gas_station';
  static const String TYPE_RESTAURANT = 'restaurant';

  //label type of marker
  static const String LABEL_CAR_DEALER = 'Dealers';
  static const String LABEL_SERVICE_CENTER = 'Service Center';
  static const String LABEL_GAS_STATION = 'Gas Station';
  static const String LABEL_RESTAURANT = 'Restaurant';

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
      'icon': "ic_user_search.svg",
      'content': 'face_scan_item_1',
    },
    {
      'icon': "ic_glass.svg",
      'content': 'face_scan_item_2',
    },
  ];

  static List<MenuItem> get profileMenuItems => [
        MenuItem(
            title: 'edit_profile'.tr,
            icon: Iconsax.edit_24,
            onTap: () {
              Get.toNamed(Routes.EDIT_PROFILE);
            }),
        MenuItem(title: 'biometric_login'.tr, icon: Iconsax.scan4, onTap: () {}),
      ];

  static List<MenuItem> get settingMenuItems => [
        MenuItem(
          title: 'language'.tr,
          icon: Iconsax.language_circle4,
          onTap: () {
            Get.bottomSheet(
              BsSinglePicker(
                options: languageOptions,
                title: 'language'.tr,
                selectedId: inject<StorageService>().getSelectedLanguage(),
                onSubmit: (value) {
                  Get.find<ProfileController>().changeLanguage(value.id);
                },
              ),
              isScrollControlled: false,
            );
          },
        ),
        MenuItem(title: 'about_us'.tr, icon: Iconsax.note_21, onTap: () {}),
        MenuItem(title: 'privacy_policy'.tr, icon: Iconsax.shield_tick4, onTap: () {}),
        MenuItem(
            title: 'emergency_contact'.tr,
            icon: Iconsax.call_calling,
            onTap: () {
              Get.toNamed(Routes.EMERGENCY_CONTACT_LIST);
            }),
        MenuItem(
          title: 'logout_title'.tr,
          icon: Iconsax.logout_1,
          onTap: () {
            Get.bottomSheet(
              BsConfirmation(
                type: BsConfirmationType.danger,
                title: 'quit_account'.tr,
                description: 'are_you_sure_logout'.tr,
                positiveButtonOnClick: () async {
                  Get.back();

                  await Future.delayed(const Duration(milliseconds: 500));
                  showLoadingOverlay();

                  Get.find<ProfileController>().logout();
                },
                positiveTitle: 'quit'.tr,
              ),
            );
          },
        )
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

  static final languageOptions = [
    PickerModel(id: 0, title: 'device_setting'.tr, value: 'default'),
    PickerModel(id: 1, title: 'Indonesia', value: 'id'),
    PickerModel(id: 2, title: 'english'.tr, value: 'en'),
  ];

  static final countryCodes = [
    PickerModel(id: 0, title: '+62 (Indonesia)', value: '+62'),
    PickerModel(id: 1, title: '+61 (Malaysia)', value: '+61'),
    PickerModel(id: 2, title: '+63 (Thailand)', value: '+63'),
  ];

  static final searchFilterItems = [
    AppChip(
      id: 'filter_gas_station',
      label: 'Gas Station',
      icon: Icon(Iconsax.gas_station4),
      onSelected: (p0) {
        Get.back();
      },
    ),
    AppChip(
      id: 'filter_dealers',
      label: 'Dealers',
      icon: SvgPicture.asset(
        "assets/icons/ic_filter_car_dealer.svg",
        width: 16,
        height: 16,
      ),
      onSelected: (p0) {
        Get.back();
      },
    ),
    AppChip(
      id: 'filter_restaurant',
      label: 'Restaurant',
      icon: Icon(Icons.coffee),
      onSelected: (p0) {
        Get.back();
      },
    ),
  ];

  static final mapScreenFilterItems = [
    MapFilterItem(
      id: 'filter_gas_station',
      label: "filter_gas_station".tr,
      icon: Icon(Iconsax.gas_station4),
    ),
    MapFilterItem(
      id: 'filter_dealers',
      label: "filter_car_dealer".tr,
      icon: SvgPicture.asset(
        "assets/icons/ic_filter_car_dealer.svg",
        width: 16,
        height: 16,
      ),
    ),
    MapFilterItem(
      id: 'filter_restaurant',
      label: "filter_restaurant".tr,
      icon: Icon(Icons.coffee),
    ),
    MapFilterItem(
      id: 'filter_service_center',
      label: "filter_service_center".tr,
      // icon: Icon(Iconsax.setting_25),
      icon: SvgPicture.asset(
        "assets/icons/ic_filter_service_center.svg",
        width: 16,
        height: 16,
      ),
    ),
    MapFilterItem(
      id: 'filter_drive_to',
      label: "filter_drive_to".tr,
      icon: Icon(Iconsax.direct_up5),
    ),
  ];
}
