import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  late final Dio _dio;

  ApiService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: "https://jsonplaceholder.typicode.com/",
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );

    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        compact: true,
      ),
    );
  }

  static final ApiService instance = ApiService._internal();

  Dio get dio => _dio;

  // =========================
  // 🔹 GET
  // =========================
  Future<Response> get(
    String path, {
    Map<String, dynamic>? query,
  }) async {
    return await _dio.get(
      path,
      queryParameters: query,
    );
  }

  // =========================
  // 🔹 POST
  // =========================
  Future<Response> post(
    String path, {
    dynamic data,
  }) async {
    return await _dio.post(
      path,
      data: data,
    );
  }

  // =========================
  // 🔥 ADD (alias for POST - cleaner naming for tasks)
  // =========================
  Future<Response> add(
    String path, {
    dynamic data,
  }) async {
    return await post(path, data: data);
  }
}