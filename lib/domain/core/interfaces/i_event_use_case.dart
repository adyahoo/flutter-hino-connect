part of 'i_use_case.dart';

abstract class IEventUseCase {
  Future<ListPaginationApiResponse<EventModel>> getEventlist();
  Future<void> addEvent(EventModel newData);
  Future<void> updateEvent(EventModel newData);
  Future<void> deleteEvent(int id);
}
