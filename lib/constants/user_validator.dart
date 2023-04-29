import 'package:set_new_password/constants/user_validator_constants.dart';

class UserValidator {
  UserValidator();

  ///PASSWORD
  String? passwordValidator(String password) {
    final hasUpperCase = RegExp(r'[A-Z]').hasMatch(password);
    final hasLowerCase = RegExp(r'[a-z]').hasMatch(password);
    final hasDigits = RegExp(r'\d').hasMatch(password);

    if (password.isEmpty) {
      return 'Password field cannot be empty';
    }

    if (password.length < ValidationConstants.minPasswordLength) {
      return 'Password must be at least'
          ' ${ValidationConstants.minPasswordLength} characters long';
    }
    if (password.length > ValidationConstants.maxPasswordLength) {
      return 'Password must be maximum'
          ' ${ValidationConstants.maxPasswordLength} characters long';
    }
    if (!hasUpperCase) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!hasLowerCase) {
      return 'Password must contain at least one lowercase letter';
    }

    if (!hasDigits) {
      return 'Password must contain at least one digit';
    }

    return null;
  }

  String? confirmPasswordValidator(String password, String confirmPassword) {
    if (passwordValidator(password) != null) {
      return null;
    }
    if (confirmPassword.isEmpty) {
      return 'Confirm password field cannot be empty';
    }

    if (password != confirmPassword) {
      return 'Passwords do not match';
    }

    return null;
  }
}
