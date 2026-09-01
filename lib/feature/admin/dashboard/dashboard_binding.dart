import 'package:flutter_mobile_access_token/cores/api/api_service.dart';
import 'package:flutter_mobile_access_token/feature/admin/dashboard/dashboard_controller.dart';
import 'package:flutter_mobile_access_token/feature/admin/dashboard/repository/dashboard_repository.dart';
import 'package:flutter_mobile_access_token/feature/admin/dashboard/repository/dashboard_repository_impl.dart';
import 'package:get/get.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardRepository>(
      () => DashboardRepositoryImpl(apiService: Get.find<ApiService>()),
    );
    Get.lazyPut(
      () => DashboardController(
        dashboardRepository: Get.find<DashboardRepository>(),
      ),
    );
  }
}
