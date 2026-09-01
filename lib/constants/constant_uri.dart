class ConstantUri {
  ConstantUri._();

  static const String baseUri = "http://10.30.1.93:30033";
  static const String loginPath = "$baseUri/api/oauth/token";
  static const String refreshTokenPath = "$baseUri/api/oauth/refresh";
  static const String adminListPostPath  = "$baseUri/api/app/post";
}