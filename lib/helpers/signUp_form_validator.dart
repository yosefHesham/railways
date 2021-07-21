class SignUpFormValidator {
  static String validateMail(v) {
    if (v.isEmpty || v.trim().isEmpty) {
      return "Mail Cannot Be Empty !";
    }
    if (!v.contains("@") || !v.endsWith(".com")) {
      return "Invalid mail !";
    }
    return null;
  }

  static String validateName(v) {
    if (v.isEmpty || v.trim().isEmpty) {
      return "User name Cannot be empty !";
    }
    if (v.length < 5) {
      return "Short user name !";
    }
    return null;
  }

  static String validatePassword(v) {
    if (v.isEmpty || v.trim().isEmpty) {
      return "Password Cannot Be Empty !";
    }
    if (v.length < 8) {
      return "Short Pasword !";
    }
    return null;
  }
}
