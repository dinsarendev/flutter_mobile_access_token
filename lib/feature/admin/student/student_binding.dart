import 'package:flutter_mobile_access_token/cores/api/api_service.dart';
import 'package:flutter_mobile_access_token/feature/admin/student/repository/student_repository.dart';
import 'package:flutter_mobile_access_token/feature/admin/student/repository/student_repository_impl.dart';
import 'package:flutter_mobile_access_token/feature/admin/student/student_controller.dart';
import 'package:get/get.dart';

class StudentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentRepository>(
      () => StudentRepositoryImpl(apiService: Get.find<ApiService>()),
    );
    Get.lazyPut(
      () => StudentController(
        studentRepository: Get.find<StudentRepository>(),
      ),
    );
  }
}

