import 'package:get_it/get_it.dart';
import 'package:hino_driver_app/data/data_sources/data_source.dart';
import 'package:hino_driver_app/data/locals/StorageService.dart';
import 'package:hino_driver_app/domain/core/usecases/activity_use_case.dart';
import 'package:hino_driver_app/domain/core/usecases/contact_use_case.dart';
import 'package:hino_driver_app/domain/core/usecases/event_use_case.dart';

GetIt inject = GetIt.instance;

Future setupInjection() async {
  final storageInstance = await StorageService.instance();
  inject.registerSingleton<StorageService>(storageInstance!);

  //activity
  inject.registerLazySingleton<ActivityDataSource>(() => ActivityDataSource());
  inject.registerLazySingleton<ActivityUseCase>(() => ActivityUseCase(dataSource: inject()));

  //event
  inject.registerLazySingleton<EventDataSource>(() => EventDataSource());
  inject.registerLazySingleton<EventUseCase>(() => EventUseCase(dataSource: inject()));

  //bs sos
  inject.registerLazySingleton<ContactDataSource>(() => ContactDataSource());
  inject.registerLazySingleton<ContactUseCase>(() => ContactUseCase(dataSource: inject()));

}
