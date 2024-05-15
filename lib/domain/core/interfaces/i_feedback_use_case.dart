
import 'package:hino_driver_app/data/dtos/base_response_dto.dart';
import 'package:hino_driver_app/domain/core/entities/feedback_model.dart';

abstract class IFeedbackUseCase {
  Future<ListPaginationApiResponse<FeedbackModel>> getFeedbackList();
}