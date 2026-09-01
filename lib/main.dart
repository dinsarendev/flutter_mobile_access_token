import 'package:flutter/material.dart';
import 'package:flutter_mobile_access_token/binding/initial_binding.dart';
import 'package:flutter_mobile_access_token/feature/auth/login/login_binding.dart';
import 'package:flutter_mobile_access_token/feature/auth/login/login_view.dart';
import 'package:flutter_mobile_access_token/feature/home/home_binding.dart';
import 'package:flutter_mobile_access_token/feature/home/home_view.dart';
import 'package:flutter_mobile_access_token/feature/splash/splash_binding.dart';
import 'package:flutter_mobile_access_token/feature/splash/splash_view.dart';
import 'package:flutter_mobile_access_token/routes/app_route.dart';
import 'package:flutter_mobile_access_token/routes/app_route_name.dart';
import 'package:flutter_mobile_access_token/translations/messages.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

import 'constants/language_constants.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Messages(),
      locale: Locale(LanguageConstants.km, LanguageConstants.kh),
      fallbackLocale: Locale(LanguageConstants.en, LanguageConstants.uk),
      initialBinding: InitialBinding(),
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: AppRouteName.splash,
      getPages: AppRoute.getAllRoutes(),
    );
  }
}
