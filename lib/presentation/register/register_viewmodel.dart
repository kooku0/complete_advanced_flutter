import 'dart:async';
import 'dart:io';

import 'package:complete_advanced_flutter/data/mapper/mapper.dart';
import 'package:complete_advanced_flutter/domain/usecase/forgot_password_usecase.dart';
import 'package:complete_advanced_flutter/domain/usecase/register_usecase.dart';
import 'package:complete_advanced_flutter/presentation/base/baseviewmodel.dart';
import 'package:complete_advanced_flutter/presentation/common/freezed_data_classes.dart';
import 'package:complete_advanced_flutter/presentation/common/state_renderer/state_render_impl.dart';
import 'package:complete_advanced_flutter/presentation/common/state_renderer/state_renderer.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInputs, RegisterViewModelOutputs {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _mobileNumberStreamController =
      StreamController<String>.broadcast();
  final StreamController _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _profilePictureStreamController =
      StreamController<File>.broadcast();

  final StreamController _isAllInputsValidStreamController =
      StreamController<void>.broadcast();

  StreamController isUserLoggedInSuccessfullyStreamController =
      StreamController<bool>();

  ForgotPasswordObject forgotPasswordObject =
      ForgotPasswordObject(email: EMPTY);

  final RegisterUseCase _registerUseCase;

  RegisterViewModel(this._registerUseCase);

  var registerViewObject = RegisterObject(
    countryMobileCode: EMPTY,
    mobileNumber: EMPTY,
    userName: EMPTY,
    email: EMPTY,
    password: EMPTY,
    profilePicture: EMPTY,
  );

  @override
  void start() {
    // view tells state renderer, please show the content of the screen
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    _userNameStreamController.close();
    _mobileNumberStreamController.close();
    _emailStreamController.close();
    _passwordStreamController.close();
    _profilePictureStreamController.close();

    _isAllInputsValidStreamController.close();

    isUserLoggedInSuccessfullyStreamController.close();
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputMobileNumber => _mobileNumberStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputProfilePicture => _profilePictureStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputIsAllInputsValid => _isAllInputsValidStreamController.sink;

  // outputs
  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  Stream<String?> get outputErrorUserName => outputIsUserNameValid.map(
        (isUserNameValid) => isUserNameValid ? null : 'Invalid username',
      );

  @override
  Stream<bool> get outputIsEmailValid =>
      _emailStreamController.stream.map((email) => _isEmailValid(email));

  @override
  Stream<String?> get outputErrorEmail => outputIsEmailValid.map(
        (isEmailValid) => isEmailValid ? null : 'Invalid email',
      );

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<String?> get outputErrorPassword => outputIsPasswordValid.map(
        (isPasswordValid) => isPasswordValid ? null : 'Invalid password',
      );

  @override
  Stream<bool> get outputIsMobileNumberValid =>
      _mobileNumberStreamController.stream
          .map((mobileNumber) => _isMobileNumberValid(mobileNumber));

  @override
  Stream<String?> get outputErrorMobileNumber => outputIsMobileNumberValid.map(
        (isMobileNumberValid) =>
            isMobileNumberValid ? null : 'Invalid mobile number',
      );

  @override
  Stream<File> get outputProfilePicture =>
      _profilePictureStreamController.stream.map((file) => file);

  @override
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputsValidStreamController.stream.map((_) => _isAllInputsValid());

  @override
  register() async {
    inputState.add(
      LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE),
    );
    (await _registerUseCase.execute(
      RegisterUseCaseInput(
        countryMobileCode: registerViewObject.countryMobileCode,
        mobileNumber: registerViewObject.mobileNumber,
        userName: registerViewObject.userName,
        email: registerViewObject.email,
        password: registerViewObject.password,
        profilePicture: registerViewObject.profilePicture,
      ),
    ))
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
          ContentState(),
        );

        isUserLoggedInSuccessfullyStreamController.add(true);
      },
    );
  }

  // private functions
  bool _isUserNameValid(String userName) {
    return userName.length >= 8;
  }

  bool _isEmailValid(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool _isPasswordValid(String password) {
    return password.length >= 8;
  }

  bool _isMobileNumberValid(String mobileNumber) {
    return mobileNumber.length >= 10;
  }

  bool _isAllInputsValid() {
    return registerViewObject.profilePicture.isNotEmpty &&
        registerViewObject.email.isNotEmpty &&
        registerViewObject.password.isNotEmpty &&
        registerViewObject.mobileNumber.isNotEmpty &&
        registerViewObject.userName.isNotEmpty &&
        registerViewObject.countryMobileCode.isNotEmpty;
  }

  _validate() {
    inputIsAllInputsValid.add(null);
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    if (_isUserNameValid(userName)) {
      // update register view object with username value
      registerViewObject = registerViewObject.copyWith(
        userName: userName,
      );
    } else {
      // reset username value in register view object
      registerViewObject = registerViewObject.copyWith(
        userName: EMPTY,
      );
    }
    _validate();
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    if (_isEmailValid(email)) {
      // update register view object with email value
      registerViewObject = registerViewObject.copyWith(
        email: email,
      );
    } else {
      // reset email value in register view object
      registerViewObject = registerViewObject.copyWith(
        email: EMPTY,
      );
    }
    _validate();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    if (_isPasswordValid(password)) {
      // update register view object with password value
      registerViewObject = registerViewObject.copyWith(
        password: password,
      );
    } else {
      // reset password value in register view object
      registerViewObject = registerViewObject.copyWith(
        password: EMPTY,
      );
    }
    _validate();
  }

  @override
  setCountryMobileCode(String countryMobileCode) {
    if (countryMobileCode.isNotEmpty) {
      // update register view object with countryMobileCode value
      registerViewObject = registerViewObject.copyWith(
          countryMobileCode: countryMobileCode); // using data class like kotlin
    } else {
      // reset countryMobileCode value in register view object
      registerViewObject = registerViewObject.copyWith(countryMobileCode: "");
    }
    _validate();
  }

  @override
  setMobileNumber(String mobileNumber) {
    inputMobileNumber.add(mobileNumber);
    if (_isMobileNumberValid(mobileNumber)) {
      // update register view object with mobile number value
      registerViewObject = registerViewObject.copyWith(
        mobileNumber: mobileNumber,
      );
    } else {
      // reset mobile number value in register view object
      registerViewObject = registerViewObject.copyWith(
        mobileNumber: EMPTY,
      );
    }
    _validate();
  }

  @override
  setProfilePicture(File profilePicture) {
    inputProfilePicture.add(profilePicture);
    if (profilePicture.path.isNotEmpty) {
      registerViewObject = registerViewObject.copyWith(
        profilePicture: profilePicture.path,
      );
    } else {
      registerViewObject = registerViewObject.copyWith(
        profilePicture: EMPTY,
      );
    }
    _validate();
  }
}

abstract mixin class RegisterViewModelInputs {
  register();

  setUserName(String userName);
  setEmail(String email);
  setPassword(String password);
  setCountryMobileCode(String countryMobileCode);
  setMobileNumber(String mobileNumber);
  setProfilePicture(File profilePicture);

  Sink get inputUserName;
  Sink get inputMobileNumber;
  Sink get inputEmail;
  Sink get inputPassword;
  Sink get inputProfilePicture;
  Sink get inputIsAllInputsValid;
}

abstract mixin class RegisterViewModelOutputs {
  Stream<bool> get outputIsUserNameValid;
  Stream<String?> get outputErrorUserName;

  Stream<bool> get outputIsMobileNumberValid;
  Stream<String?> get outputErrorMobileNumber;

  Stream<bool> get outputIsEmailValid;
  Stream<String?> get outputErrorEmail;

  Stream<bool> get outputIsPasswordValid;
  Stream<String?> get outputErrorPassword;

  Stream<File> get outputProfilePicture;

  Stream<bool> get outputIsAllInputsValid;
}
