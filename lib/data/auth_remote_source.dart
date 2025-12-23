import 'package:dio/dio.dart';
import '../models/auth_user.dart';

class AuthRemoteSource {
  final Dio dio;
  AuthRemoteSource(this.dio);

  Future<AuthUser> login(String email, String password) async {
    final response = await dio.post(
      '/api/login',
      data: {'email': email, 'password': password},
    );

    return AuthUser.fromJson(response.data);
  }
}
