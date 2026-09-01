import 'package:flutter_mobile_access_token/data/local/access_token_storage.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  var loading = false.obs;

  _checkLogin() async {
    loading.value = true;
    await Future.delayed(Duration(seconds: 3));
    loading.value = false;
    if (AccessTokenStorage.getAccess() != "") {
      Get.offNamed("/home");
    } else {
      Get.offNamed("/login");
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    _checkLogin();
    super.onInit();
  }
}
