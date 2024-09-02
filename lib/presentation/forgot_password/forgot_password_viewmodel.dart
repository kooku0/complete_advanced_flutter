import 'dart:async';

import 'package:complete_advanced_flutter/data/mapper/mapper.dart';
import 'package:complete_advanced_flutter/domain/usecase/forgot_password_usecase.dart';
import 'package:complete_advanced_flutter/presentation/base/baseviewmodel.dart';
import 'package:complete_advanced_flutter/presentation/common/freezed_data_classes.dart';
import 'package:complete_advanced_flutter/presentation/common/state_renderer/state_render_impl.dart';
import 'package:complete_advanced_flutter/presentation/common/state_renderer/state_renderer.dart';

class ForgotPasswordViewModel extends BaseViewModel
    with ForgotPasswordViewModelInputs, ForgotPasswordViewModelOutputs {
  final StreamController _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController _isAllInputsValidStreamController =
      StreamController<void>.broadcast();

  ForgotPasswordObject forgotPasswordObject =
      ForgotPasswordObject(email: EMPTY);

  final ForgotPasswordUseCase _forgotPasswordUseCase;
  ForgotPasswordViewModel(this._forgotPasswordUseCase);

  // inputs
  @override
  void dispose() {
    _emailStreamController.close();
    _isAllInputsValidStreamController.close();
  }

  @override
  void start() {
    // view tells state renderer, please show the content of the screen
    inputState.add(ContentState());
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputIsAllInputsValid => _isAllInputsValidStreamController.sink;

  @override
  forgotPassword() async {
    inputState.add(
      LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE),
    );
    (await _forgotPasswordUseCase.execute(ForgotPasswordUseCaseInput(
      email: forgotPasswordObject.email,
    )))
        .fold(
      (failure) {
        // left -> failure
        inputState.add(
          ErrorState(
            stateRendererType: StateRendererType.POPUP_ERROR_STATE,
            message: failure.message,
          ),
        );
      },
      (data) {
        // right -> success (data)
        inputState.add(
          SuccessState(
            message: data.support,
          ),
        );
      },
    );
  }

  // outputs
  @override
  Stream<bool> get outputIsEmailValid =>
      _emailStreamController.stream.map((email) => _isEmailValid(email));

  @override
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputsValidStreamController.stream.map((_) => _isAllInputsValid());

  @override
  setEmail(String email) {
    inputEmail.add(email);
    forgotPasswordObject = forgotPasswordObject.copyWith(email: email);
    _validate();
  }

  // private functions
  _validate() {
    inputIsAllInputsValid.add(null);
  }

  bool _isEmailValid(String email) {
    return email.isNotEmpty;
  }

  bool _isAllInputsValid() {
    return _isEmailValid(forgotPasswordObject.email);
  }
}

abstract mixin class ForgotPasswordViewModelInputs {
  // three functions for actions
  setEmail(String email);
  forgotPassword();

  // two sinks for streams
  Sink get inputEmail;
  Sink get inputIsAllInputsValid;
}

abstract mixin class ForgotPasswordViewModelOutputs {
  Stream<bool> get outputIsEmailValid;
  Stream<bool> get outputIsAllInputsValid;
}
