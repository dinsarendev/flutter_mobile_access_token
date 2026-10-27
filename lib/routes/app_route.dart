import 'package:flutter_mobile_access_token/feature/admin/dashboard/dashboard_binding.dart';
import 'package:flutter_mobile_access_token/feature/admin/dashboard/dashboard_view.dart';
import 'package:flutter_mobile_access_token/feature/admin/post/post_binding.dart';
import 'package:flutter_mobile_access_token/feature/admin/post/post_view.dart';
import 'package:flutter_mobile_access_token/feature/admin/student/student_binding.dart';
import 'package:flutter_mobile_access_token/feature/admin/student/student_view.dart';
import 'package:flutter_mobile_access_token/routes/app_route_name.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../feature/auth/login/login_binding.dart';
import '../feature/auth/login/login_view.dart';
import '../feature/home/home_binding.dart';
import '../feature/home/home_view.dart';
import '../feature/splash/splash_binding.dart';
import '../feature/splash/splash_view.dart';

class AppRoute {
  AppRoute._();

  static List<GetPage> getAllRoutes() {
    return [
      GetPage(
        name: AppRouteName.splash,
        page: () => SplashView(),
        binding: SplashBinding(),
        transition: Transition.fadeIn,
      ),
      GetPage(
        name: AppRouteName.home,
        page: () => HomeView(),
        binding: HomeBinding(),
        transition: Transition.fadeIn,
      ),
      GetPage(
        name: AppRouteName.login,
        page: () => LoginView(),
        binding: LoginBinding(),
        transition: Transition.fadeIn,
      ),
      GetPage(
        name: AppRouteName.adminDashboard,
        page: () => DashboardView(),
        binding: DashboardBinding(),
        transition: Transition.cupertino,
      ),
      GetPage(
        name: AppRouteName.adminPosts,
        page: () => PostView(),
        binding: PostBinding(),
        transition: Transition.cupertino,
      ),
      GetPage(
        name: AppRouteName.adminStudents,
        page: () => const StudentView(),
        binding: StudentBinding(),
        transition: Transition.cupertino,
      ),
    ];
  }
}
