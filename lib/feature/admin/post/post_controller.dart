import 'package:flutter_mobile_access_token/cores/models/post/Content.dart';
import 'package:flutter_mobile_access_token/feature/admin/dashboard/models/menu.dart';
import 'package:flutter_mobile_access_token/feature/admin/dashboard/repository/dashboard_repository.dart';
import 'package:get/get.dart';

class PostController extends GetxController{
  final postList = <Content>[].obs;
  final DashboardRepository dashboardRepository;
  PostController({required this.dashboardRepository});
  final loading = false.obs;


  @override
  void onInit() {
    onGetAllPost();
    super.onInit();
  }
  onGetAllPost() async {
    loading.value = true;
    var response = await dashboardRepository.getAllPosts();
    loading.value = false;
    if(response.isNotEmpty){
      postList.value = response;
    }
  }
}