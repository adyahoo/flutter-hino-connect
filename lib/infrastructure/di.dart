import 'package:get_it/get_it.dart';
import 'package:hino_driver_app/data/data_sources/data_source.dart';
import 'package:hino_driver_app/data/locals/StorageService.dart';
import 'package:hino_driver_app/domain/core/usecases/activity_use_case.dart';
import 'package:hino_driver_app/domain/core/usecases/feedback_use_case.dart';
import 'package:hino_driver_app/domain/core/usecases/user_use_case.dart';

GetIt inject = GetIt.instance;

Future setupInjection() async {
  final storageInstance = await StorageService.instance();
  inject.registerSingleton<StorageService>(storageInstance!);

  //activity
  inject.registerLazySingleton<ActivityDataSource>(() => ActivityDataSource());
  inject.registerLazySingleton<ActivityUseCase>(() => ActivityUseCase(dataSource: inject()));

  //feedback
  inject.registerLazySingleton<FeedbackDataSource>(() => FeedbackDataSource());
  inject.registerLazySingleton<FeedbackUseCase>(() => FeedbackUseCase(dataSource: inject()));

  //User
  inject.registerLazySingleton<UserDataSource>(() => UserDataSource());
  inject.registerLazySingleton<UserUseCase>(() => UserUseCase(dataSource: inject()));
}
