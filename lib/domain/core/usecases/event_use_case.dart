import 'package:hino_driver_app/data/data_sources/data_source.dart';
import 'package:hino_driver_app/data/dtos/base_response_dto.dart';
import 'package:hino_driver_app/data/dtos/events_dto.dart';
import 'package:hino_driver_app/domain/core/entities/model.dart';
import 'package:hino_driver_app/domain/core/interfaces/i_use_case.dart';
import 'package:hino_driver_app/infrastructure/constants.dart';

class EventUseCase implements IEventUseCase {
  const EventUseCase({required this.dataSource});

  final EventDataSource dataSource;

  @override
  Future<ListPaginationApiResponse<EventModel>> getEventlist() async {
    try {
      final response = await dataSource.getEventList();
      final data = response.data.map((e) {
        final type = Constants.eventTypeItems.firstWhere((element) => element.value == e.type);

        return EventModel(id: e.id, type: type, note: e.note, createdAt: e.createdAt);
      }).toList();

      return ListPaginationApiResponse(
        data: data,
        links: response.links,
        meta: response.meta,
      );
    } catch (e) {
      //call error handler dialog
      rethrow;
    }
  }

  @override
  Future<void> addEvent(EventModel newData) async {
    try {
      final dto = EventDto(
        id: newData.id,
        type: newData.type.value,
        note: newData.note,
        createdAt: newData.createdAt,
      );

      await dataSource.addEvent(dto);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteEvent(int id) async {
    try {
      await dataSource.deleteEvent(id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateEvent(EventModel newData) async {
    try {
      final dto = EventDto(
        id: newData.id,
        type: newData.type.value,
        note: newData.note,
        createdAt: newData.createdAt,
      );

      await dataSource.updateEvent(dto);
    } catch (e) {
      rethrow;
    }
  }
}
