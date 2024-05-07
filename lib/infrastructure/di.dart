import 'package:get_it/get_it.dart';
import 'package:hino_driver_app/data/locals/StorageService.dart';

GetIt inject = GetIt.instance;

Future setupInjection() async {
  final storageInstance = await StorageService.instance();
  inject.registerSingleton<StorageService>(storageInstance!);
}
