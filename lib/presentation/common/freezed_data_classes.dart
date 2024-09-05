import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed_data_classes.freezed.dart';

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject({required String userName, required String password}) =
      _LoginObject;
}

@freezed
class ForgotPasswordObject with _$ForgotPasswordObject {
  factory ForgotPasswordObject({required String email}) = _ForgotPasswordObject;
}

@freezed
class RegisterObject with _$RegisterObject {
  factory RegisterObject({
    required String countryMobileCode,
    required String mobileNumber,
    required String userName,
    required String email,
    required String password,
    required String profilePicture,
  }) = _RegisterObject;
}
