part of 'i_use_case.dart';

abstract class ITripUseCase {
  Future<ListPaginationApiResponse<TripModel>> getTodayTripList();
  Future<ListPaginationApiResponse<TripModel>> getTripList();
  Future<TripDetailModel> getTripDetail(int id);
  Future<void> updateTripDetail(int id, PenaltyModel penalty);
}