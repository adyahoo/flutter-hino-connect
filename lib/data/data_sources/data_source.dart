import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hino_driver_app/data/dtos/activities_dto.dart';
import 'package:hino_driver_app/data/dtos/base_response_dto.dart';

import 'package:hino_driver_app/data/dtos/feedbacks_dto.dart';
import 'package:hino_driver_app/data/dtos/place_api_response_dto.dart';
import 'package:hino_driver_app/data/dtos/recent_search_dto.dart';
import 'package:hino_driver_app/data/dtos/single_base_response_dto.dart';
import 'package:hino_driver_app/data/dtos/trips_dto.dart';
import 'package:hino_driver_app/data/dtos/user_dto.dart';
import 'package:hino_driver_app/data/services/user_services.dart';
import 'package:hino_driver_app/infrastructure/constants.dart';
import 'package:hino_driver_app/data/locals/StorageService.dart';
import 'package:hino_driver_app/domain/core/entities/model.dart';
import 'package:hino_driver_app/infrastructure/di.dart';
import 'package:hino_driver_app/main.dart';
import 'package:hino_driver_app/presentation/screens/trip_list/controllers/trip_list.controller.dart';
import 'package:http/http.dart' as http;


import 'package:hino_driver_app/data/dtos/events_dto.dart';

import 'package:hino_driver_app/data/dtos/contacts_dto.dart';

part 'activity_data_source.dart';

part 'feedback_data_source.dart';
part 'user_data_source.dart';
part 'event_data_source.dart';
part 'place_data_source.dart';
part 'contact_data_source.dart';
part 'trip_data_source.dart';
part 'recent_search_data_source.dart';
