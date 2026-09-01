import 'package:flutter_mobile_access_token/cores/models/post/Content.dart';

abstract class DashboardRepository {
  Future<List<Content>> getAllPosts({String? page, String? size, String? status});
}