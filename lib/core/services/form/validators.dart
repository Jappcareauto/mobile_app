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


  static String? validateDateOfBirth(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    // Expected format: DD-MM-YYYY
    final dateParts = value.split('-');
    if (dateParts.length != 3) {
      return '$fieldName must be in the format DD-MM-YYYY';
    }
    final day = dateParts[0];
    final month = dateParts[1];
    final year = dateParts[2];

    // Check if day is a valid number
    if (day.isEmpty ||
        int.tryParse(day) == null ||
        int.parse(day) < 1 ||
        int.parse(day) > 31) {
      return '$fieldName must be a valid day (1-31)';
    }

    // Check if month is a valid number
    if (month.isEmpty ||
        int.tryParse(month) == null ||
        int.parse(month) < 1 ||
        int.parse(month) > 12) {
      return '$fieldName must be a valid month (1-12)';
    }

    // Check if year is a valid number
    if (year.isEmpty || int.tryParse(year) == null) {
      return '$fieldName must be a valid year';
    }

    // Check if year is in a valid range
    final currentDate = DateTime.now();
    final currentYear = currentDate.year;
    final minYear = currentYear - 120; // Assuming the minimum age is 120 years
    final maxYear = currentYear - 18; // Assuming the maximum age is 18 years
    if (int.parse(year) < minYear || int.parse(year) > maxYear) {
      return '$fieldName must be between $minYear and $maxYear';
    }

    return null;
  }

  // Add other validators if necessary
}
