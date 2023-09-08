class BookDetailsValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Custom inscription is a required field and cannot be empty.';
    }

    return null;
  }
}
