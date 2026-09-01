import 'package:flutter_mobile_access_token/feature/admin/dashboard/models/menu.dart';
import 'package:flutter_mobile_access_token/feature/admin/dashboard/repository/dashboard_repository.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController{
  final menuList = <Menu>[].obs;
  final DashboardRepository dashboardRepository;
  DashboardController({required this.dashboardRepository});


  @override
  void onInit() {
    // TODO: implement onInit
    menuList.value = Menu.getAllMenus();
    super.onInit();
  }
}