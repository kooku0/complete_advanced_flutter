import 'package:complete_advanced_flutter/data/mapper/mapper.dart';
import 'package:complete_advanced_flutter/presentation/common/state_renderer/state_renderer.dart';
import 'package:complete_advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
}

// LOADING STATE (POPUP, FULL SCREEN)

class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  LoadingState({
    required this.stateRendererType,
    String? message,
  }) : message = message ?? AppStrings.loading;

  @override
  StateRendererType getStateRendererType() => stateRendererType;

  @override
  String getMessage() => message;
}

// ERROR STATE (POPUP, FULL LOADING)

class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  ErrorState({
    required this.stateRendererType,
    required this.message,
  });

  @override
  StateRendererType getStateRendererType() => stateRendererType;

  @override
  String getMessage() => message;
}

// SUCCESS STATE

class SuccessState extends FlowState {
  String message;

  SuccessState({
    required this.message,
  });

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.POPUP_SUCCESS_STATE;

  @override
  String getMessage() => message;
}

// CONTENT STATE

class ContentState extends FlowState {
  ContentState();

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.CONTENT_SCREEN_STATE;

  @override
  String getMessage() => EMPTY;
}

// EMPTY STATE

class EmptyState extends FlowState {
  String message;

  EmptyState({required this.message});

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.EMPTY_SCREEN_STATE;

  @override
  String getMessage() => EMPTY;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget({
    required BuildContext context,
    required Widget contentScreenWidget,
    required Function retryActionFunction,
    required Function initializeFlowState,
  }) {
    switch (runtimeType) {
      case LoadingState:
        {
          if (getStateRendererType() == StateRendererType.POPUP_LOADING_STATE) {
            showPopUp(
              context: context,
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              initializeFlowState: initializeFlowState,
            );
            return contentScreenWidget;
          } else {
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFunction: retryActionFunction,
              initializeFlowState: initializeFlowState,
            );
          }
        }
      case ErrorState:
        {
          dismissDialog(context);
          if (getStateRendererType() == StateRendererType.POPUP_ERROR_STATE) {
            showPopUp(
              context: context,
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              initializeFlowState: initializeFlowState,
            );
            return contentScreenWidget;
          } else {
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFunction: retryActionFunction,
              initializeFlowState: initializeFlowState,
            );
          }
        }
      case SuccessState:
        {
          dismissDialog(context);
          showPopUp(
            context: context,
            stateRendererType: StateRendererType.POPUP_SUCCESS_STATE,
            message: getMessage(),
            title: AppStrings.success,
            initializeFlowState: initializeFlowState,
          );
          return contentScreenWidget;
        }
      case ContentState:
        {
          dismissDialog(context);
          return contentScreenWidget;
        }
      case EmptyState:
        {
          return StateRenderer(
            stateRendererType: getStateRendererType(),
            message: getMessage(),
            retryActionFunction: retryActionFunction,
            initializeFlowState: initializeFlowState,
          );
        }
      default:
        {
          return contentScreenWidget;
        }
    }
  }

  dismissDialog(BuildContext context) {
    if (_isThereCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  _isThereCurrentDialogShowing(BuildContext context) {
    return ModalRoute.of(context)?.isCurrent != true;
  }

  showPopUp({
    required BuildContext context,
    required StateRendererType stateRendererType,
    required String message,
    required Function initializeFlowState,
    String title = EMPTY,
  }) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        showDialog(
          context: context,
          builder: (BuildContext context) => StateRenderer(
            stateRendererType: stateRendererType,
            title: title,
            message: message,
            retryActionFunction: () {},
            initializeFlowState: initializeFlowState,
          ),
        );
      },
    );
  }
}
