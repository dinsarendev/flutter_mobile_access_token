import 'dart:convert';
import 'package:flutter_mobile_access_token/constants/constant_uri.dart';
import 'package:flutter_mobile_access_token/cores/api/api_service.dart';
import 'package:flutter_mobile_access_token/cores/models/student/student_model.dart';
import 'package:flutter_mobile_access_token/data/local/access_token_storage.dart';
import 'package:flutter_mobile_access_token/feature/admin/student/repository/student_repository.dart';
import 'package:http/http.dart' as httpClient;

class StudentRepositoryImpl implements StudentRepository {
  final ApiService apiService;

  StudentRepositoryImpl({required this.apiService});

  @override
  Future<List<StudentModel>> getStudents({
    int page = 0,
    int size = 20,
    String status = "ACT",
    String? keyword,
  }) async {
    String query = "?page=$page&size=$size&status=$status";
    if (keyword != null && keyword.trim().isNotEmpty) {
      query += "&keyword=${Uri.encodeComponent(keyword.trim())}";
    }

    String? response;
    final token = AccessTokenStorage.getAccess();

    if (token != null && token.isNotEmpty) {
      response = await apiService.get("${ConstantUri.adminListStudentPath}$query");
    }

    // Fallback to public endpoint if protected route fails or not logged in
    if (response == null) {
      try {
        final res = await httpClient.get(Uri.parse("${ConstantUri.publicListStudentPath}$query"));
        if (res.statusCode == 200) {
          response = res.body;
        }
      } catch (e) {
        // network or server down
      }
    }

    if (response != null) {
      try {
        final decoded = jsonDecode(response);
        final pageRes = StudentPageResponse.fromJson(decoded);
        return pageRes.content ?? [];
      } catch (e) {
        return [];
      }
    }
    return [];
  }

  @override
  Future<bool> createStudent({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    String? image,
  }) async {
    final body = jsonEncode({
      "firstName": firstName.trim(),
      "lastName": lastName.trim(),
      "phoneNumber": phoneNumber.trim(),
      "image": image ?? "",
    });

    var response = await apiService.post(ConstantUri.adminListStudentPath, body: body);
    return response != null;
  }

  @override
  Future<bool> updateStudent({
    required int id,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    String? image,
  }) async {
    final body = jsonEncode({
      "firstName": firstName.trim(),
      "lastName": lastName.trim(),
      "phoneNumber": phoneNumber.trim(),
      "image": image ?? "",
    });

    var response = await apiService.put("${ConstantUri.adminListStudentPath}/$id", body: body);
    return response != null;
  }

  @override
  Future<bool> deleteStudent(int id) async {
    var response = await apiService.delete("${ConstantUri.adminListStudentPath}/$id");
    return response != null;
  }
}

