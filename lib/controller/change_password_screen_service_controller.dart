import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:set_new_password/constants/either.dart';
import 'package:set_new_password/constants/failure.dart';

final changePasswordServiceControllerProvider =
    Provider.autoDispose<ChangePasswordServiceController>((ref) {
  return ChangePasswordServiceController();
});

class ChangePasswordServiceController {
  ChangePasswordServiceController();

  FutureUnit setNewPassword({
    required String passwordResetCode,
    required String newPassword,
  }) async {
    Either<Failure, Unit> checkResetCodeResult = await _setNewPassword(
      passwordResetCode: passwordResetCode,
      newPassword: newPassword,
    );
    return checkResetCodeResult.fold(
      (failure) => Left(failure),
      (unit) => Right(unit),
    );
  }

// AUTH - Set new password
  FutureUnit _setNewPassword({
    required String passwordResetCode,
    required String newPassword,
  }) async {
    try {
      await FirebaseAuth.instance.confirmPasswordReset(
        code: passwordResetCode,
        newPassword: newPassword,
      );
      return const Right(unit);
    } on FirebaseAuthException catch (exception) {
      if (exception.code == 'expired-action-code') {
        return Left(Failure('Link is expired. Please request a new one.'));
      } else if (exception.code == 'invalid-action-code') {
        return Left(Failure(
            'Invalid link. Please double-check your email or request a new one.'));
      } else if (exception.code == 'user-disabled') {
        return Left(
            Failure('User account is disabled. Please contact support.'));
      } else if (exception.code == 'user-not-found') {
        return Left(Failure(
            'User not found. Please check your email or create an account.'));
      } else {
        return Left(Failure(exception.toString()));
      }
    } catch (exception) {
      return Left(Failure(exception.toString()));
    }
  }
}
