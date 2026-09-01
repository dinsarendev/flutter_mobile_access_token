import 'dart:convert';

import 'package:flutter_mobile_access_token/constants/constant_uri.dart';
import 'package:flutter_mobile_access_token/cores/api/api_service.dart';
import 'package:flutter_mobile_access_token/cores/models/post/Content.dart';
import 'package:flutter_mobile_access_token/cores/models/post/PostResponse.dart';
import 'package:flutter_mobile_access_token/feature/admin/dashboard/repository/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final ApiService apiService;
  DashboardRepositoryImpl({required this.apiService});
  @override
  Future<List<Content>> getAllPosts({
    String? page,
    String? size,
    String? status,
  }) async {
    var response = await apiService.get(
      "${ConstantUri.adminListPostPath}?page=${page ?? 0}&size=${size ?? 10}&status=${status ?? "ACT"}",
    );
    if (response != null) {
      PostResponse postResponse = PostResponse.fromJson(jsonDecode(response));
      if (postResponse.data != null && postResponse.data!.content != null) {
        return postResponse.data!.content ?? [];
      }
    }
    return [];
  }
}
