import 'package:flutter_mobile_access_token/feature/auth/repository/auth_repository.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../cores/api/api_service.dart';
import '../../../cores/models/auth/login/LoginRequest.dart';
import '../../../data/local/access_token_storage.dart';

class AuthRepositoryImpl implements AuthRepository {
  var apiService = Get.find<ApiService>();
  @override
  Future<String> login(String username, String password) async {
    LoginRequest loginRequest = LoginRequest(
      phoneNumber: username,
      password: password,
    );
    var response = await apiService.login(loginRequest);
    if (response.accessToken != null) {
      // Save Token to local Storage
      AccessTokenStorage.saveToken(
        token: response.accessToken,
        refreshToken: response.refreshToken,
      );
      Get.offNamed("/home");
      return "Login Success";
    } else {
      return "Your username and password incorrect";
    }
  }
}
