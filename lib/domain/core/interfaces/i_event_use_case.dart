part of 'i_use_case.dart';

abstract class IEventUseCase {
  Future<ListApiResponse<EventModel>> getEventlist();
}
