import 'package:complete_advanced_flutter/data/network/failure.dart';
import 'package:complete_advanced_flutter/data/request/request.dart';
import 'package:complete_advanced_flutter/domain/model/model.dart';
import 'package:complete_advanced_flutter/domain/repository/repository.dart';
import 'package:complete_advanced_flutter/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class RegisterUseCase
    implements BaseUseCase<RegisterUseCaseInput, Authentication> {
  final Repository _repository;
  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(
      RegisterUseCaseInput input) async {
    return await _repository.register(
      RegisterRequest(
        countryMobileCode: input.countryMobileCode,
        userName: input.userName,
        email: input.email,
        password: input.password,
        profilePicture: input.profilePicture,
      ),
    );
  }
}

class RegisterUseCaseInput {
  String countryMobileCode;
  String mobileNumber;
  String userName;
  String email;
  String password;
  String profilePicture;

  RegisterUseCaseInput({
    required this.countryMobileCode,
    required this.mobileNumber,
    required this.userName,
    required this.email,
    required this.password,
    required this.profilePicture,
  });
}
