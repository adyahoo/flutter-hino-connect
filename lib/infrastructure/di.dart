import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hino_driver_app/data/data_sources/data_source.dart';
import 'package:hino_driver_app/data/locals/StorageService.dart';
import 'package:hino_driver_app/data/services/user_services.dart';
import 'package:hino_driver_app/domain/core/usecases/activity_use_case.dart';
import 'package:hino_driver_app/domain/core/usecases/face_recognition_use_case.dart';
import 'package:hino_driver_app/domain/core/usecases/face_recognition_use_case.dart';
import 'package:hino_driver_app/domain/core/usecases/feedback_use_case.dart';
import 'package:hino_driver_app/domain/core/usecases/place_use_case.dart';
import 'package:hino_driver_app/domain/core/usecases/splash_use_case.dart';
import 'package:hino_driver_app/domain/core/usecases/trip_use_case.dart';
import 'package:hino_driver_app/domain/core/usecases/user_use_case.dart';
import 'package:hino_driver_app/domain/core/usecases/contact_use_case.dart';
import 'package:hino_driver_app/domain/core/usecases/event_use_case.dart';
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

  //user
  inject.registerLazySingleton<UserServices>(() => UserServices(inject()));
  inject.registerLazySingleton<UserDataSource>(() => UserDataSource(services: inject()));
  inject.registerLazySingleton<UserUseCase>(() => UserUseCase(dataSource: inject()));

  //event
  inject.registerLazySingleton<EventDataSource>(() => EventDataSource());
  inject.registerLazySingleton<EventUseCase>(() => EventUseCase(dataSource: inject()));

  //maps
  inject.registerLazySingleton<PlaceDataSource>(() => PlaceDataSource());
  inject.registerLazySingleton<PlaceUseCase>(() => PlaceUseCase(dataSource: inject()));

  //trip
  inject.registerLazySingleton<TripDataSource>(() => TripDataSource());
  inject.registerLazySingleton<TripUseCase>(() => TripUseCase(dataSource: inject()));

  //face recognition
  inject.registerLazySingleton<FaceRecognitionUseCase>(() => FaceRecognitionUseCase(dataSource: inject()));

  //bs sos
  inject.registerLazySingleton<ContactDataSource>(() => ContactDataSource());
  inject.registerLazySingleton<ContactUseCase>(() => ContactUseCase(dataSource: inject()));
}
