import 'package:task/core/utiles/validation/field_type.dart';

class AppValidator {
  static String? validate({
    required String? value,
    required FieldType type,
  }) {
    final text = value?.trim() ?? "";

    // required check
    if (text.isEmpty) {
      return "This field is required";
    }

    switch (type) {
      case FieldType.email:
        return _validateEmail(text);

      case FieldType.password:
        return _validatePassword(text);

      case FieldType.normal:
        return null;
    }
  }

  static String? _validateEmail(String value) {
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );

    if (!emailRegex.hasMatch(value)) {
      return "Please enter a valid email address";
    }

    return null;
  }

  static String? _validatePassword(String value) {
    if (value.length < 8) {
      return "Password must be at least 8 characters";
    }

    final hasLetter = RegExp(r'[A-Za-z]').hasMatch(value);
    final hasNumber = RegExp(r'\d').hasMatch(value);

    if (!hasLetter || !hasNumber) {
      return "Password must contain letters and numbers";
    }

    return null;
  }
}