import 'package:equatable/equatable.dart';

class SingleApiResponse<T> extends Equatable {
  final T data;
  final String message;
  final bool success;

  const SingleApiResponse({
    required this.data,
    required this.message,
    required this.success,
  });

  factory SingleApiResponse.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic> json) create) {
    // Check if 'data' is a list
    if (json['data'] is List) {
      // If 'data' is a list, take the first element and pass it to the 'create' function
      return SingleApiResponse(
        data: create((json['data'] as List).first as Map<String, dynamic>),
        message: json['message'],
        success: json['success'],
      );
    } else {
      // If 'data' is not a list, pass it directly to the 'create' function
      return SingleApiResponse(
        data: create(json['data'] as Map<String, dynamic>),
        message: json['message'],
        success: json['success'],
      );
    }
  }

  @override
  List<Object?> get props => [data, message, success];
}
