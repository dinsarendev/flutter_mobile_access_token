import 'package:flutter_mobile_access_token/data/local/access_token_storage.dart';
import 'package:flutter_mobile_access_token/routes/app_route_name.dart';
import 'package:get/get.dart';

class HomeController  extends GetxController{

  onLogout(){
    AccessTokenStorage.removeToken();
    Get.offNamed(AppRouteName.splash);
  }
}