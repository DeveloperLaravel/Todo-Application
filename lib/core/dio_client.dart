import 'package:dio/dio.dart';

class DioClient {
  static Dio create(String? token) {
    return Dio(
      BaseOptions(
        baseUrl: 'http://10.77.121.56:8000',
        headers: {
          'Accept': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      ),
    );
  }
}
