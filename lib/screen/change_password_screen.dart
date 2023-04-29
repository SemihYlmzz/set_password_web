import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:set_new_password/constants/reset_password_screen_result_enums.dart';
import 'package:set_new_password/constants/user_validator.dart';

import '../controller/change_password_screen_service_controller.dart';
import '../controller/change_password_screen_view_controller.dart';
import '../widgets/base_scaffold.dart';
import '../widgets/gradient_button.dart';
import '../widgets/gradient_text_field.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  final String oobCode;
  static String get routeName => 'changePassword';
  static String get routeLocation => '/$routeName';
  const ChangePasswordScreen({
    super.key,
    required this.oobCode,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  late ChangePasswordViewController _viewController;
  late ChangePasswordServiceController _serviceController;
  @override
  void initState() {
    _viewController = ref.read(changePasswordViewControllerProvider);
    _serviceController = ref.read(changePasswordServiceControllerProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      isLoading: _viewController.isLoading,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/background.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0, 0.85),
                  radius: 0.6,
                  colors: [
                    Colors.transparent,
                    Colors.black,
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 64.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        constraints: const BoxConstraints(
                          minWidth: 280,
                          maxWidth: 400,
                        ),
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white),
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.1),
                              Colors.black.withOpacity(0.25),
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _viewController.screeenResult ==
                                  ResultPasswordScreenResultEnums.waiting
                              ? Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Form(
                                      key: _viewController.formKey,
                                      child: Column(
                                        children: [
                                          GradientTextField(
                                            hintText: 'NEW PASSWORD',
                                            textEditingController: _viewController
                                                .passwordTextEditingController,
                                            obscureText: true,
                                            validator: (value) =>
                                                UserValidator()
                                                    .passwordValidator(
                                                        _viewController
                                                            .password),
                                          ),
                                          GradientTextField(
                                            hintText: 'CONFIRM PASSWORD',
                                            textEditingController: _viewController
                                                .confirmPasswordTextEditingController,
                                            obscureText: true,
                                            validator: (value) =>
                                                UserValidator()
                                                    .confirmPasswordValidator(
                                              _viewController.password,
                                              _viewController.confirmPassword,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16),
                                      child: GradientButton(
                                        text: 'SAVE',
                                        width: 175,
                                        onPressed: () async {
                                          if (_viewController.isFormsValid()) {
                                            var a = await _serviceController
                                                .setNewPassword(
                                                    passwordResetCode:
                                                        widget.oobCode,
                                                    newPassword: _viewController
                                                        .password);
                                            a.fold(
                                              (failure) {
                                                _viewController.changeScreenResult(
                                                    ResultPasswordScreenResultEnums
                                                        .error);
                                                _viewController
                                                    .setError(failure.message);
                                                setState(() {});
                                              },
                                              (result) {
                                                _viewController.changeScreenResult(
                                                    ResultPasswordScreenResultEnums
                                                        .changed);

                                                setState(() {});
                                              },
                                            );
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                )
                              : _viewController.screeenResult ==
                                      ResultPasswordScreenResultEnums.error
                                  ? Animate(
                                      effects: const [
                                        FlipEffect(),
                                      ],
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: Text(
                                              _viewController.error,
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Animate(
                                      effects: const [
                                        FlipEffect(),
                                      ],
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Center(
                                            child: Text(
                                              'Succeed.',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 30,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
