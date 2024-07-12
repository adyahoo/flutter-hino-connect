import 'dart:io';

import 'package:camera/camera.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:hino_driver_app/data/dtos/base_response_dto.dart';
import 'package:hino_driver_app/domain/core/entities/model.dart';
import 'package:hino_driver_app/domain/core/entities/search_result_model.dart';
import 'package:hino_driver_app/domain/core/entities/place_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:hino_driver_app/domain/core/entities/trips_model.dart';
import 'package:hino_driver_app/domain/core/entities/user_model.dart';
import 'package:hino_driver_app/presentation/screens/trip_list/controllers/trip_list.controller.dart';

part 'i_activity_use_case.dart';
part 'i_vehicle_scan_use_case.dart';
part 'i_event_use_case.dart';
part 'i_contact_use_case.dart';
part 'i_trip_use_case.dart';
part 'i_recent_search_use_case.dart';
part 'i_place_use_case.dart';
part 'i_splash_use_case.dart';
part 'i_user_use_case.dart';
part 'i_face_recognition_use_case.dart';
part 'i_permission_use_case.dart';