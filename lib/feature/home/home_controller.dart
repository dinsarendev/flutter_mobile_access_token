import 'package:flutter/cupertino.dart';
import 'package:flutter_mobile_access_token/constants/language_constants.dart';
import 'package:flutter_mobile_access_token/data/local/access_token_storage.dart';
import 'package:flutter_mobile_access_token/routes/app_route_name.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  onLogout() {
    AccessTokenStorage.removeToken();
    Get.offNamed(AppRouteName.splash);
  }

  onChangeLanguage() {
    if (Get.locale?.languageCode == LanguageConstants.km) {
      var locale = Locale(LanguageConstants.en, LanguageConstants.us);
      Get.updateLocale(locale);
    } else {
      var locale = Locale(LanguageConstants.km, LanguageConstants.kh);
      Get.updateLocale(locale);
    }
  }
}
