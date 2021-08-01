String? formFieldValidator(String? value, String title, int length) {
  if (value == '' || value == null) {
    return '$title must not be empty!';
  } else if (value.length <= length) {
    return '$title must be over $length charaters long!';
  }

  return null;
}
