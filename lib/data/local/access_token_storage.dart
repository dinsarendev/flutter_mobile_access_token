import 'package:get_storage/get_storage.dart';

class AccessTokenStorage {
  static final _storage = GetStorage();
  static final _accessToken = "ACCESS_TOKEN";
  static final _refreshToken = "REFRESH_TOKEN";

  static void saveToken({String? token, String? refreshToken}) {
    _storage.write(_accessToken, token);
    _storage.write(_refreshToken, refreshToken);
  }

  static String getAccess() => _storage.read(_accessToken) ?? "";
  static String getRefreshAccess() => _storage.read(_refreshToken) ?? "";
  static void removeToken() {
    _storage.remove(_accessToken);
    _storage.remove(_refreshToken);
  }
}
