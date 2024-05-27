import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hino_driver_app/data/locals/StorageService.dart';
import 'package:hino_driver_app/infrastructure/client/exceptions/ApiException.dart';
import 'package:hino_driver_app/infrastructure/constants.dart';
import 'package:hino_driver_app/infrastructure/di.dart';

class ApiClient {
  static Dio instance() {
    final client = Dio();
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    client.options = BaseOptions(
      baseUrl: Constants.BASE_URL,
      headers: headers,
      connectTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 30000),
    );

    if (kDebugMode) {
      client.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true, requestHeader: true),
      );
    }
    client.interceptors.add(ApiInterceptors());

    return client;
  }
}

class ApiInterceptors extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = inject<StorageService>().getToken();

    if (token != null) {
      options.headers.addAll({
        'Authorization': 'Bearer $token',
      });
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print("sapi response: ${response.data}");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print("sapi response err: ${err.message}");
    super.onError(err, handler);
  }
}

typedef ClientReturn<T> = T Function();

Future<T> clientExecutor<T>({required ClientReturn<Future<T>> execute}) async {
  try {
    return await execute();
  } on DioException catch (e) {
    throw ApiException.parseError(e);
  } catch (e) {
    throw Exception(e);
  }
}
