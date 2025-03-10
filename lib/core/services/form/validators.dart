import 'package:get/get.dart';

class Validators {
  static String? requiredField(String? value,
      {String fieldName = 'This field'}) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? maxEntrySize(String? value,
      {required int maxEntrySize, String fieldName = 'This field'}) {
    if (value == null || value.isEmpty || value.length > maxEntrySize) {
      return '$fieldName must not exceed $maxEntrySize characters';
    }
    return null;
  }

  static String? minEntrySize(String? value,
      {required int minEntrySize, String fieldName = 'This field'}) {
    if (value == null || value.isEmpty || value.length < minEntrySize) {
      return '$fieldName must be at least $minEntrySize characters long';
    }
    return null;
  }

  static String? exactEntrySize(String? value,
      {required int exactEntrySize, String fieldName = 'This field'}) {
    if (value == null || value.isEmpty || value.length != exactEntrySize) {
      return '$fieldName must be exactly $exactEntrySize characters long';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be more than 8 characters';
    }
    return null;
  }

  static String? confirmPassword(String? value, String? originalPassword) {
    if (value != originalPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your telephone number';
    }
    if (!GetUtils.isPhoneNumber(value)) {
      return 'Enter a valid telephone number';
    }
    return null;
  }

  static String? number(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    if (!GetUtils.isNumericOnly(value)) {
      return '$fieldName must be numbers only';
    }
    return null;
  }

  // Add other validators if necessary
}
