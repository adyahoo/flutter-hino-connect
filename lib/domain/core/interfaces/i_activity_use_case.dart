part of 'i_use_case.dart';

abstract class IActivityUseCase {
  Future<ListPaginationApiResponse<ActivityModel>> getActivityList();
  Future<void> addActivity(ActivityModel newData);
  Future<void> updateActivity(ActivityModel newData);
  Future<void> deleteActivity(int id);
}