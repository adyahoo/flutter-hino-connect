import 'package:hino_driver_app/data/data_sources/data_source.dart';
import 'package:hino_driver_app/data/dtos/base_response_dto.dart';
import 'package:hino_driver_app/domain/core/entities/activities_model.dart';
import 'package:hino_driver_app/domain/core/interfaces/i_activity_use_case.dart';
import 'package:hino_driver_app/infrastructure/constants.dart';

class ActivityUseCase implements IActivityUseCase {
  const ActivityUseCase({required this.dataSource});

  final ActivityDataSource dataSource;

  @override
  Future<ListApiResponse<ActivityModel>> getActivityList() async {
    try {
      final response = await dataSource.getActivityList();
      final data = response.data.map((e) {
        final type = Constants.activityTypeItems.firstWhere((element) => element.value == e.type);

        return ActivityModel(id: e.id, type: type, createdAt: e.createdAt);
      }).toList();

      return ListApiResponse(
        data: data,
        links: response.links,
        meta: response.meta,
      );
    } catch (e) {
      //call error handler dialog
      rethrow;
    }
  }
}
