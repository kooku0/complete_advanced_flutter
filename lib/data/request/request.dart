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

class RegisterRequest {
  String countryMobileCode;
  String mobileNumber;
  String userName;
  String email;
  String password;
  String profilePicture;

  RegisterRequest({
    required this.countryMobileCode,
    required this.mobileNumber,
    required this.userName,
    required this.email,
    required this.password,
    required this.profilePicture,
  });
}
