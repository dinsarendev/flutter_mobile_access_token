class ConstantUri {
  ConstantUri._();

  static const String baseUri = "http://10.30.0.181:30033";
  static const String loginPath = "$baseUri/api/oauth/token";
  static const String refreshTokenPath = "$baseUri/api/oauth/refresh";
  static const String adminListPostPath  = "$baseUri/api/app/post";
  static const String adminListStudentPath = "$baseUri/api/app/student";
  static const String publicListStudentPath = "$baseUri/api/public/student";
  static const String viewImagePath = "$baseUri/api/public/view/image?filename=";
}