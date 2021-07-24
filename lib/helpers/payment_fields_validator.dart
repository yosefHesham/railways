import 'package:credit_card_validator/credit_card_validator.dart';

class PaymentFieldValidator {
  static CreditCardValidator _creditCardValidator = CreditCardValidator();
  static var _creditCardType;

  static validateName(String value) {
    if (_isFieldEmpty(value)) {
      return "Required Field";
    } else if (value.length < 3) {
      return "Short name";
    }
    return null;
  }

  static validateCardNum(String value) {
    var validationResults = _creditCardValidator.validateCCNum(value);
    _creditCardType = validationResults.ccType;
    print("Cardtype2 $_creditCardType");
    if (_isFieldEmpty(value)) {
      return "Required Field";
    } else if (!validationResults.isValid) {
      return "Invalid card number";
    }
    return null;
  }

  static validateCVV(
    String cvv,
  ) {
    var validationResults =
        _creditCardValidator.validateCVV(cvv, _creditCardType);
    print('Card type :$_creditCardType');
    if (_isFieldEmpty(cvv)) {
      return "Required Field";
    } else if (validationResults.isPotentiallyValid) {
      return "Invalid CVV";
    }
    return null;
  }

  static validatePhoneNumber(String value) {
    if (_isFieldEmpty(value)) {
      return "Required Field";
    } else if (!value.startsWith("010") &&
            !value.startsWith("012") &&
            !value.startsWith("011") ||
        value.length < 11) {
      return "Invalid phone number";
    }
    return null;
  }

  static validateExpireDate(String value) {
    print("expie Date $value");
    var validationResults = _creditCardValidator.validateExpDate(value);
    if (_isFieldEmpty(value)) {
      return "Required Field";
    } else if (!validationResults.isValid) {
      return "Invalid expire date";
    }
    return null;
  }

  static bool _isFieldEmpty(String value) {
    if (value.trim().isEmpty || value == null) {
      return true;
    }
    return false;
  }
}
