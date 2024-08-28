import 'package:complete_advanced_flutter/data/network/failure.dart';
import 'package:complete_advanced_flutter/data/request/request.dart';
import 'package:complete_advanced_flutter/domain/model/model.dart';
import 'package:complete_advanced_flutter/domain/repository/repository.dart';
import 'package:complete_advanced_flutter/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class ForgotPasswordUseCase
    implements BaseUseCase<ForgotPasswordUseCaseInput, ForgotPassword> {
  final Repository _repository;
  ForgotPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, ForgotPassword>> execute(
      ForgotPasswordUseCaseInput input) async {
    return await _repository.forgotPassword(
      ForgotPasswordRequest(
        email: input.email,
      ),
    );
  }
}

class ForgotPasswordUseCaseInput {
  String email;

  ForgotPasswordUseCaseInput({required this.email});
}
