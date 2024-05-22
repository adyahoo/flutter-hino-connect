import 'package:hino_driver_app/data/data_sources/data_source.dart';
import 'package:hino_driver_app/data/dtos/activities_dto.dart';
import 'package:hino_driver_app/data/dtos/base_response_dto.dart';
import 'package:hino_driver_app/domain/core/entities/model.dart';
import 'package:hino_driver_app/domain/core/interfaces/i_use_case.dart';
import 'package:hino_driver_app/infrastructure/constants.dart';

class ActivityUseCase implements IActivityUseCase {
  const ActivityUseCase({required this.dataSource});

  final ActivityDataSource dataSource;

  @override
  Future<ListPaginationApiResponse<ActivityModel>> getActivityList() async {
    try {
      final response = await dataSource.getActivityList();
      final data = response.data.map((e) {
        final type = Constants.activityTypeItems.firstWhere((element) => element.value == e.type);

        return ActivityModel(id: e.id, type: type, createdAt: e.createdAt);
      }).toList();

      return ListPaginationApiResponse(
        data: data,
        links: response.links,
        meta: response.meta,
      );
    } catch (e) {
      //call error handler dialog
      rethrow;
    }
  }

  @override
  Future<void> addActivity(ActivityModel newData) async {
    try {
      final dto = ActivityDto(
        id: newData.id,
        type: newData.type.value,
        createdAt: newData.createdAt,
      );

      await dataSource.addActivity(dto);
    } catch (e) {
      //call error handler dialog
      rethrow;
    }
  }

  @override
  Future<void> deleteActivity(int id) async {
    try {
      await dataSource.deleteActivity(id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateActivity(ActivityModel newData) async {
    try {
      final dto = ActivityDto(
        id: newData.id,
        type: newData.type.value,
        createdAt: newData.createdAt,
      );

      await dataSource.updateActivity(dto);
    } catch (e) {
      rethrow;
    }
  }
}
