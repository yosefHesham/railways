class PaymentFieldValidator {
  static String validateName(String value) {
    if (_isFieldEmpty(value)) {
      return "Required Field";
    } else if (value.length < 3) {
      return "Short name";
    }
    return null;
  }

  static String validateCardNum(String value) {
    if (_isFieldEmpty(value)) {
      return "Required Field";
    }
  }

  static String validateCVV(String value) {
    if (_isFieldEmpty(value)) {
      return "Required Field";
    }
  }

  static String validatePhoneNumber(String value) {
    if (_isFieldEmpty(value)) {
      return "Required Field";
    }
  }

  static String validateExpireDate(String value) {
    if (_isFieldEmpty(value)) {
      return "Required Field";
    }
  }

  static bool _isFieldEmpty(String value) {
    if (value.trim().isEmpty || value == null) {
      return true;
    }
    return false;
  }
}
