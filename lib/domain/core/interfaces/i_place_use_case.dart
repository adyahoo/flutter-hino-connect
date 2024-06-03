part of 'i_use_case.dart';

abstract class IPlaceUseCase {
  Future<ListApiResponse<PlaceModel>> fetchNearbyPlaces();
}