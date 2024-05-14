import 'package:hino_driver_app/data/dtos/base_response_dto.dart';
import 'package:hino_driver_app/domain/core/entities/place_model.dart';

abstract class IPlaceUseCase {
  Future<ListApiResponse<PlaceModel>> fetchNearbyPlaces();
}