import 'package:hino_driver_app/data/data_sources/data_source.dart';
import 'package:hino_driver_app/data/dtos/base_response_dto.dart';
import 'package:hino_driver_app/domain/core/entities/model.dart';
import 'package:hino_driver_app/domain/core/interfaces/i_use_case.dart';
import 'package:hino_driver_app/infrastructure/constants.dart';

class EventUseCase implements IEventUseCase {
  const EventUseCase({required this.dataSource});

  final EventDataSource dataSource;

  @override
  Future<ListApiResponse<EventModel>> getEventlist() async {
    try {
      final response = await dataSource.getEventList();
      final data = response.data.map((e) {
        final type = Constants.eventTypeItems.firstWhere((element) => element.value == e.type);

        return EventModel(id: e.id, type: type, note: e.note, createdAt: e.createdAt);
      }).toList();

      return ListApiResponse(
        data: data,
        links: response.links,
        meta: response.meta,
      );
    } catch (e) {
      //call error handler dialog
      rethrow;
    }
  }
}
