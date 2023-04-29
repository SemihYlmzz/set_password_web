import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:set_new_password/constants/reset_password_screen_result_enums.dart';

final changePasswordViewControllerProvider =
    Provider.autoDispose<ChangePasswordViewController>((ref) {
  return ChangePasswordViewController();
});

class ChangePasswordViewController {
  ChangePasswordViewController();

  /// Form Things
  final _formKey = GlobalKey<FormState>();
  get formKey => _formKey;

  bool isFormsValid() {
    return (_formKey.currentState != null && _formKey.currentState!.validate());
  }

  /// TextEditingControllers and Functions
  final passwordTextEditingController = TextEditingController();
  final confirmPasswordTextEditingController = TextEditingController();

  void _applyToAllTextEditingControllers(
      Function(TextEditingController) action) {
    [
      passwordTextEditingController,
      confirmPasswordTextEditingController,
    ].forEach(action);
  }

  void disposeTextFormFields() {
    _applyToAllTextEditingControllers(
      (textFormFields) => textFormFields.dispose(),
    );
  }

  // Getter and Setter for TextEditingControllers
  String get password => passwordTextEditingController.text;
  String get confirmPassword => confirmPasswordTextEditingController.text;

  // Focus Nodes and Functions
  final passwordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();

  void _applyToAllFocusNodes(Function(FocusNode) action) {
    [
      passwordFocusNode,
      confirmPasswordFocusNode,
    ].forEach(action);
  }

  void unFocusFocusNodes() {
    _applyToAllFocusNodes((node) => node.unfocus());
  }

  void disposeFocusNodes() {
    _applyToAllFocusNodes(
      (node) => node.dispose(),
    );
  }

  // UI Changes.

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void loadingOn() {
    _isLoading = true;
  }

  void loadingOff() {
    _isLoading = false;
  }

  String _error = ' ';
  String get error => _error;
  void setError(String newError) {
    _error = newError;
  }

  ResultPasswordScreenResultEnums _screenResult =
      ResultPasswordScreenResultEnums.waiting;

  ResultPasswordScreenResultEnums get screeenResult => _screenResult;
  void changeScreenResult(ResultPasswordScreenResultEnums newResult) {
    _screenResult = newResult;
  }
}
