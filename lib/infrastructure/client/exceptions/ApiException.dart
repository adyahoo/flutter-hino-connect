import 'package:dio/dio.dart';
import 'package:hino_driver_app/data/dtos/api_dto.dart';

class ApiException implements Exception {
  const ApiException({this.response, this.exception});

  final ErrorResponseDto? response;
  final DioException? exception;

  static DioException parseError(DioException e) {
    if (e.type == DioExceptionType.badResponse) {
      throw ApiException(response: ErrorResponseDto.fromJson(e.response?.data), exception: e);
    }

    throw ApiException(response: null, exception: e);
  }
}
