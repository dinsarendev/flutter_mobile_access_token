import 'package:flutter_mobile_access_token/cores/models/auth/login/LoginRequest.dart';
import 'package:flutter_mobile_access_token/cores/models/auth/login/LoginResponse.dart';

abstract class ApiService {
  Future<LoginResponse> login(LoginRequest request);
  Future<bool> refresh();
  Future<dynamic> get(String url);
}