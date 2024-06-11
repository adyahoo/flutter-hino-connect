import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hino_driver_app/domain/core/entities/feedback_model.dart';
import 'package:hino_driver_app/domain/core/entities/map_filter_model.dart';
import 'package:hino_driver_app/domain/core/entities/model.dart';

import 'package:hino_driver_app/infrastructure/constants.dart';

import 'package:hino_driver_app/infrastructure/di.dart';
import 'package:hino_driver_app/infrastructure/navigation/routes.dart';

import 'package:hino_driver_app/infrastructure/theme/app_color.dart';
import 'package:hino_driver_app/infrastructure/utils.dart';
import 'package:hino_driver_app/infrastructure/validation/app_validator.dart';
import 'package:hino_driver_app/presentation/screens/maps/controllers/maps.controller.dart';
import 'package:hino_driver_app/presentation/search/controllers/search.controller.dart';
import 'package:hino_driver_app/presentation/widgets/bottom_sheets/activity/controllers/bs_activity_form.controller.dart';
import 'package:hino_driver_app/presentation/widgets/bottom_sheets/emergency_contact/controllers/bs_emergency_contact_form.controller.dart';
import 'package:hino_driver_app/presentation/widgets/bottom_sheets/event/controllers/bs_event_form.controller.dart';
import 'package:hino_driver_app/presentation/widgets/bottom_sheets/image_picker/controllers/bs_image_picker.controller.dart';
import 'package:hino_driver_app/presentation/widgets/bottom_sheets/single_picker/controllers/bs_single_picker.controller.dart';
import 'package:hino_driver_app/presentation/widgets/chips/controllers/app_chip.controller.dart';
import 'package:hino_driver_app/presentation/widgets/bottom_sheets/sos/controllers/bs_sos.controller.dart';
import 'package:hino_driver_app/presentation/widgets/filter/controllers/app_filter.controller.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_svg/svg.dart';

part 'app_text_field.dart';

part 'app_button.dart';

part 'app_tips.dart';

part 'app_divider.dart';

part 'app_shimmer_container.dart';

part 'app_radio_button.dart';

part 'app_search_bar.dart';

part 'app_fab.dart';

part 'app_card_action.dart';

part 'app_appbar.dart';

part 'chips/app_chip.dart';
part 'filter/app_filter.dart';

part 'bottom_sheets/bs_confirmation.dart';

part 'bottom_sheets/bs_success.dart';

part 'bottom_sheets/activity/bs_activity_form.dart';

part 'bottom_sheets/event/bs_event_form.dart';

part 'bottom_sheets/single_picker/bs_single_picker.dart';

part 'bottom_sheets/bs_notch.dart';

part 'bottom_sheets/sos/bs_sos.dart';

part 'bottom_sheets/trip/bs_trip_detail_note.dart';

part 'bottom_sheets/emergency_contact/bs_emergency_contact_form.dart';

part 'bottom_sheets/image_picker/bs_image_picker.dart';

part 'empty/empty_log.dart';

enum WidgetVariant { primary, danger, warning, success, info, yellow }
