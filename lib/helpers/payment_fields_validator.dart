class PaymentFieldValidator {
  static validateName(String value) {
    if (_isFieldEmpty(value)) {
      return "Required Field";
    } else if (value.length < 3) {
      return "Short name";
    }
    return null;
  }

  static validateCardNum(String value) {
    if (_isFieldEmpty(value)) {
      return "Required Field";
    }
  }

  static validateCVV(String value) {
    if (_isFieldEmpty(value)) {
      return "Required Field";
    }
  }

  static validatePhoneNumber(String value) {
    if (_isFieldEmpty(value)) {
      return "Required Field";
    }
  }

  static validateExpireDate(String value) {
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
