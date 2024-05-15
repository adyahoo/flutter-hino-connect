part of 'i_use_case.dart';

abstract class IActivityUseCase {
  Future<ListPaginationApiResponse<ActivityModel>> getActivityList();
}