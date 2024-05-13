part of 'i_use_case.dart';

abstract class IActivityUseCase {
  Future<ListApiResponse<ActivityModel>> getActivityList();
}