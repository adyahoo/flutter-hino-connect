part of 'i_use_case.dart';

abstract class IEventUseCase {
  Future<ListPaginationApiResponse<EventModel>> getEventlist();
}
