import 'dart:convert';

import 'package:flutter_mobile_access_token/constants/constant_uri.dart';
import 'package:flutter_mobile_access_token/cores/api/api_service.dart';
import 'package:flutter_mobile_access_token/cores/models/auth/RefreshTokenRequest.dart';
import 'package:flutter_mobile_access_token/cores/models/auth/login/LoginRequest.dart';
import 'package:flutter_mobile_access_token/cores/models/auth/login/LoginResponse.dart';
import 'package:flutter_mobile_access_token/data/local/access_token_storage.dart';
import 'package:http/http.dart' as httpClient;

class ApiServiceImpl implements ApiService {
  var header = {"Content-Type": "application/json"};
  @override
  Future<LoginResponse> login(LoginRequest request) async {
    // TODO: implement login
    var loginResponse = LoginResponse();
    // Uri
    var url = Uri.parse(ConstantUri.loginPath);
    // Http Request
    var response = await httpClient.post(
      url,
      body: jsonEncode(request.toJson()),
      headers: header,
    );
    // Check Status
    if (response.statusCode == 200) {
      // Mapping Object Json to Dara
      return LoginResponse.fromJson(jsonDecode(response.body));
    }
    return loginResponse;
  }

  @override
  Future<bool> refresh() async {
    // TODO: implement login
    var refreshTokenRequest = RefreshTokenRequest(
      refreshToken: AccessTokenStorage.getRefreshAccess(),
    );
    // Uri
    var url = Uri.parse(ConstantUri.refreshTokenPath);
    // Http Request
    var response = await httpClient.post(
      url,
      body: jsonEncode(refreshTokenRequest.toJson()),
      headers: header,
    );
    // Check Status
    if (response.statusCode == 200) {
      // Mapping Object Json to Dara
      var responseToken = LoginResponse.fromJson(jsonDecode(response.body));
      AccessTokenStorage.saveToken(
        token: responseToken.accessToken,
        refreshToken: responseToken.refreshToken,
      );
      return true;
    }
    return false;
  }

  @override
  Future get(String url) async {
    header["Authorization"] = "Bearer ${AccessTokenStorage.getAccess()}";
    var response = await httpClient.get(Uri.parse(url), headers: header);
    if (response.statusCode == 200) {
      return response.body;
    }
    if (response.statusCode == 401) {
      // call to refresh token
      if (await refresh() == true) {
        // call
        return retryGet(url);
      }
    }
    return null;
  }

  Future retryGet(String url) async {
    header["Authorization"] = "Bearer ${AccessTokenStorage.getAccess()}";
    var response = await httpClient.get(Uri.parse(url), headers: header);
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  Future retryPost(String url, dynamic body) async {
    header["Authorization"] = "Bearer ${AccessTokenStorage.getAccess()}";
    var response = await httpClient.post(
      Uri.parse(url),
      headers: header,
      body: body,
    );
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  Future retryPut(String url, dynamic body) async {
    header["Authorization"] = "Bearer ${AccessTokenStorage.getAccess()}";
    var response = await httpClient.put(
      Uri.parse(url),
      headers: header,
      body: body,
    );
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  Future retryDelete(String url) async {
    header["Authorization"] = "Bearer ${AccessTokenStorage.getAccess()}";
    var response = await httpClient.delete(Uri.parse(url), headers: header);
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  @override
  Future post(String url, {body}) async {
    header["Authorization"] = "Bearer ${AccessTokenStorage.getAccess()}";
    var response = await httpClient.post(
      Uri.parse(url),
      headers: header,
      body: body,
    );
    if (response.statusCode == 200) {
      return response.body;
    }
    if (response.statusCode == 401) {
      // call to refresh token
      if (await refresh() == true) {
        // call
        return retryPost(url, body);
      }
    }
    return null;
  }

  @override
  Future delete(String url, {String? id}) async {
    header["Authorization"] = "Bearer ${AccessTokenStorage.getAccess()}";
    var response = await httpClient.delete(Uri.parse(url), headers: header);
    if (response.statusCode == 200) {
      return response.body;
    }
    if (response.statusCode == 401) {
      // call to refresh token
      if (await refresh() == true) {
        // call
        return retryDelete(url);
      }
    }
    return null;
  }

  @override
  Future put(String url, {body}) async {
    header["Authorization"] = "Bearer ${AccessTokenStorage.getAccess()}";
    var response = await httpClient.post(
      Uri.parse(url),
      headers: header,
      body: body,
    );
    if (response.statusCode == 200) {
      return response.body;
    }
    if (response.statusCode == 401) {
      // call to refresh token
      if (await refresh() == true) {
        // call
        return retryPut(url, body);
      }
    }
    return null;
  }
}
