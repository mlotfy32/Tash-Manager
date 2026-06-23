import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:task/core/utiles/services/api_services/failure.dart';

class ApiService {
  late final Dio _dio;

  ApiService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: "https://jsonplaceholder.typicode.com/",
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 60),
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

  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? query,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: query,
      );
      return response.data;
    } on DioException catch (e) {
      ServerFailure.fromDiorError(e);
    }
  }

  Future<dynamic> post(
    String path, {
    dynamic data,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
      );
      return response.data;
    } on DioException catch (e) {
      ServerFailure.fromDiorError(e);
    }
  }

  Future<dynamic> patch(
    String path, {
    dynamic data,
  }) async {
    try {
      final response = await _dio.patch(
        path,
        data: data,
      );
      return response.data;
    } on DioException catch (e) {
      ServerFailure.fromDiorError(e);
    }
  }

  Future<dynamic> delete(String path) async {
    try {
      final response = await _dio.delete(path);
      return response.data;
    } on DioException catch (e) {
      ServerFailure.fromDiorError(e);
    }
  }
}