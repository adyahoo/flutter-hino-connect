import 'package:hino_driver_app/data/dtos/base_response_dto.dart';
import 'package:hino_driver_app/domain/core/entities/activities_model.dart';

abstract class IActivityUseCase {
  Future<ListApiResponse<ActivityModel>> getActivityList();
}