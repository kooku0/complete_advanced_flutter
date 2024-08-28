class LoginRequest {
  String email;
  String password;
  String imei;
  String deviceType;

  LoginRequest({
    required this.email,
    required this.password,
    required this.imei,
    required this.deviceType,
  });
}

class ForgotPasswordRequest {
  String email;

  ForgotPasswordRequest({
    required this.email,
  });
}
