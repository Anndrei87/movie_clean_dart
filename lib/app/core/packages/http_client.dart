import 'package:dart_clean_movies/app/core/packages/http_response.dart';
import 'package:dio/dio.dart';

abstract class RequestClient {
  Future<HttpResponse> get(String url);
}

class RequestClientImplementation implements RequestClient {
  final Dio _dio;
  final Options _options = Options(
    validateStatus: (status) => true,
  );

  RequestClientImplementation(this._dio);

  @override
  Future<HttpResponse> get(String url) async {
    try {
      final response = await _dio.get(url, options: _options);
      return HttpResponse(
          data: response.data, statusCode: response.statusCode!);
    } catch (e) {
      return const HttpResponse(data: '', statusCode: 500);
    }
  }
}
