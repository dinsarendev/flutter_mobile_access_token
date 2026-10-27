import 'package:flutter_mobile_access_token/cores/models/student/student_model.dart';

abstract class StudentRepository {
  Future<List<StudentModel>> getStudents({
    int page = 0,
    int size = 20,
    String status = "ACT",
    String? keyword,
  });

  Future<bool> createStudent({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    String? image,
  });

  Future<bool> updateStudent({
    required int id,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    String? image,
  });

  Future<bool> deleteStudent(int id);
}

