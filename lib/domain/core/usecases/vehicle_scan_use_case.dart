import 'package:hino_driver_app/data/locals/storage_service.dart';
import 'package:hino_driver_app/domain/core/interfaces/i_use_case.dart';
import 'package:hino_driver_app/infrastructure/di.dart';

class VehicleScanUseCase implements IVehicleScanUseCase {
  @override
  Future<void> verifyVehicle() async {
    final now = DateTime.now();

    inject<StorageService>().setScannedDate(now);
    inject<StorageService>().setIsVehicleVerified(true);
  }
}
