String? formFieldValidator(String? value, String title, int length) {
  if (value == '' || value == null) {
    return '$title must not be empty!';
  } else if (value.trim().length <= length) {
    return '$title must be over $length characters long!';
  }

  return null;
}

String? seatNumberValidator(String? value) {
  if (value == '' || value == null) {
    return 'Seat Number must not be empty!';
  } else if (int.parse(value) < 1 || int.parse(value) > 5) {
    return 'Max Seat number is 3 and Min Seat number is 1!';
  }

  return null;
}

String? pinValidator(String? value) {
  if (value == '' || value == null) {
    return 'Wallet Pin must not be empty!';
  } else if (value.trim().length < 4) {
    return 'Wallet Pin Must be minimum of 4 characters long!';
  }

  return null;
}
