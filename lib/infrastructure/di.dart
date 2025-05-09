import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hino_driver_app/data/data_sources/data_source.dart';
import 'package:hino_driver_app/data/locals/storage_service.dart';
import 'package:hino_driver_app/data/services/user_services.dart';
import 'package:hino_driver_app/domain/core/usecases/activity_use_case.dart';
import 'package:hino_driver_app/domain/core/usecases/country_use_case.dart';
import 'package:hino_driver_app/domain/core/usecases/face_recognition_use_case.dart';
import 'package:hino_driver_app/domain/core/usecases/feedback_use_case.dart';
import 'package:hino_driver_app/domain/core/usecases/permission_use_case.dart';
import 'package:hino_driver_app/domain/core/usecases/place_use_case.dart';
import 'package:hino_driver_app/domain/core/usecases/recent_search_use_case.dart';
import 'package:hino_driver_app/domain/core/usecases/splash_use_case.dart';
import 'package:hino_driver_app/domain/core/usecases/trip_use_case.dart';
import 'package:hino_driver_app/domain/core/usecases/user_use_case.dart';
import 'package:hino_driver_app/domain/core/usecases/contact_use_case.dart';
import 'package:hino_driver_app/domain/core/usecases/event_use_case.dart';
import 'package:hino_driver_app/domain/core/usecases/vehicle_scan_use_case.dart';
import 'package:hino_driver_app/domain/core/usecases/vehicle_scan_use_case.dart';
import 'package:hino_driver_app/infrastructure/client/client.dart';

GetIt inject = GetIt.instance;

Future setupInjection() async {
  final clientInstance = await ApiClient.instance();
  inject.registerSingleton<Dio>(clientInstance);
  final storageInstance = await StorageService.instance();
  inject.registerSingleton<StorageService>(storageInstance!);

  //splash
  inject.registerLazySingleton<SplashUseCase>(() => SplashUseCase());

  //activity
  inject.registerLazySingleton<ActivityDataSource>(() => ActivityDataSource());
  inject.registerLazySingleton<ActivityUseCase>(() => ActivityUseCase(dataSource: inject()));

  //feedback
  inject.registerLazySingleton<FeedbackDataSource>(() => FeedbackDataSource());
  inject.registerLazySingleton<FeedbackUseCase>(() => FeedbackUseCase(dataSource: inject()));

  //trip
  inject.registerLazySingleton<TripDataSource>(() => TripDataSource());
  inject.registerLazySingleton<TripUseCase>(() => TripUseCase(dataSource: inject()));

  //user
  inject.registerLazySingleton<UserServices>(() => UserServices(inject()));
  inject.registerLazySingleton<UserDataSource>(() => UserDataSource(services: inject()));
  inject.registerLazySingleton<UserUseCase>(() => UserUseCase(dataSource: inject(), tripDataSource: inject()));

  //event
  inject.registerLazySingleton<EventDataSource>(() => EventDataSource());
  inject.registerLazySingleton<EventUseCase>(() => EventUseCase(dataSource: inject()));

  //maps
  inject.registerLazySingleton<PlaceDataSource>(() => PlaceDataSource());
  inject.registerLazySingleton<PlaceUseCase>(() => PlaceUseCase(dataSource: inject(), hinoDataSource: inject()));

  //face recognition
  inject.registerLazySingleton<FaceRecognitionUseCase>(() => FaceRecognitionUseCase(dataSource: inject()));

  //vehicle scan
  inject.registerLazySingleton<VehicleScanUseCase>(() => VehicleScanUseCase());

  //bs sos
  inject.registerLazySingleton<ContactDataSource>(() => ContactDataSource());
  inject.registerLazySingleton<ContactUseCase>(() => ContactUseCase(dataSource: inject()));

  //bs country picker
  inject.registerLazySingleton<CountryDataSource>(() => CountryDataSource());
  inject.registerLazySingleton<CountryUseCase>(() => CountryUseCase(dataSource: inject()));

  //recent search
  inject.registerLazySingleton<RecentSearchDataSource>(() => RecentSearchDataSource());
  inject.registerLazySingleton<RecentSearchUseCase>(() => RecentSearchUseCase(dataSource: inject()));

  //hino dealer
  inject.registerLazySingleton<HinoDealerDataSource>(() => HinoDealerDataSource());

  //permission
  inject.registerLazySingleton<PermissionUseCase>(() => PermissionUseCase());
}
