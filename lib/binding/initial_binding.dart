import 'package:flutter_mobile_access_token/cores/api/api_serivce_impl.dart';
import 'package:flutter_mobile_access_token/cores/api/api_service.dart';
import 'package:flutter_mobile_access_token/feature/auth/repository/auth_repository.dart';
import 'package:flutter_mobile_access_token/feature/auth/repository/auth_repository_impl.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiServiceImpl(), fenix: true);
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(), fenix: true);
  }
}
