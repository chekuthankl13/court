// core/service/dio_service.dart
import 'package:dio/dio.dart';

class DioService {
  DioService({required Dio dio, required String? Function() getToken})
    : _dio = dio {
    _dio.options.connectTimeout = const Duration(seconds: 15);
    _dio.options.receiveTimeout = const Duration(seconds: 15);

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = getToken()?.trim();

          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          handler.next(options);
        },
      ),
    );
  }

  final Dio _dio;

  Future<dynamic> get({
    required String url,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _dio.get<dynamic>(
      url,
      queryParameters: queryParameters,
    );

    return response.data;
  }

  void dispose() => _dio.close(force: true);
}
