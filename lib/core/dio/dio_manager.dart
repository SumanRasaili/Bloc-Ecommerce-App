import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioManager {
  static final DioManager _instance = DioManager._internal();

  static final Dio _dio = Dio();
  Dio get dio => _dio;
  DioManager._internal() {
    initializeDio();
  }

  factory DioManager() {
    return _instance;
  }

  void initializeDio() {
    _dio.options = BaseOptions(
      baseUrl: dotenv.get("BASE_URL"),
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      contentType: "application/json",
      responseType: ResponseType.json,
    );
    _dio.interceptors.addAll(
      [
        LogInterceptor(
          request: true,
          responseBody: true,
          requestBody: true,
          error: true,
        ),
        InterceptorsWrapper(
          onRequest: (options, handler) {
            return handler.next(options);
          },
          onResponse: (response, handler) {
            return handler.next(response);
          },
          onError: (DioException e, handler) {
            return handler.next(e);
          },
        )
      ],
    );
  }
}
