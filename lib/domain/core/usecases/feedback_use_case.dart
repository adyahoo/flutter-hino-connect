import 'package:hino_driver_app/data/data_sources/data_source.dart';
import 'package:hino_driver_app/data/dtos/base_response_dto.dart';
import 'package:hino_driver_app/domain/core/entities/feedback_model.dart';
import 'package:hino_driver_app/domain/core/interfaces/i_feedback_use_case.dart';

class FeedbackUseCase implements IFeedbackUseCase {
  const FeedbackUseCase({required this.dataSource});

  final FeedbackDataSource dataSource;

  @override
  Future<ListApiResponse<FeedbackModel>> getFeedbackList() async {
    try {
      final response = await dataSource.getFeedbackList();
      final data = response.data
          .map(
            (e) => FeedbackModel(
              id: e.id,
              title: e.title,
              description: e.description,
              createdAt: e.createdAt,
              createdBy: e.createdBy,
            ),
          )
          .toList();

      return ListApiResponse(
        data: data,
      );
    } catch (e) {
      //call error handler dialog
      rethrow;
    }
  }
}
