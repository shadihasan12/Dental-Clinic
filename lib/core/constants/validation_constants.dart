/// Validation constants and utilities for form validation
class ValidationConstants {
  ValidationConstants._();

  // Regex patterns
  static const String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const String phonePattern = r'^\+?[\d\s\-\(\)]+$';

  // Length constraints
  static const int minPasswordLength = 6;
  static const int maxPasswordLength = 128;
  static const int minNameLength = 2;
  static const int maxNameLength = 100;
  static const int minPhoneLength = 10;
  static const int maxPhoneLength = 15;

  // Validation messages
  static const String emailRequired = 'Please enter your email';
  static const String emailInvalid = 'Please enter a valid email';
  static const String passwordRequired = 'Please enter your password';
  static const String passwordTooShort =
      'Password must be at least $minPasswordLength characters';
  static const String passwordsDoNotMatch = 'Passwords do not match';
  static const String nameRequired = 'Please enter your name';
  static const String nameTooShort = 'Name must be at least $minNameLength characters';
  static const String phoneInvalid = 'Please enter a valid phone number';

  /// Validates email format
  static bool isValidEmail(String email) {
    return RegExp(emailPattern).hasMatch(email);
  }

  /// Validates password length
  static bool isValidPassword(String password) {
    return password.length >= minPasswordLength &&
        password.length <= maxPasswordLength;
  }

  /// Validates name length
  static bool isValidName(String name) {
    return name.length >= minNameLength && name.length <= maxNameLength;
  }

  /// Validates phone number format
  static bool isValidPhone(String phone) {
    return phone.length >= minPhoneLength &&
        phone.length <= maxPhoneLength &&
        RegExp(phonePattern).hasMatch(phone);
  }
}
