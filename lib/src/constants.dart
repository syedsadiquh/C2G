class Constants {
  static bool isEmailValid(String email) {
    return RegExp(r'^[a-zA-Z0-9_.±]+@[a-zA-Z0-9.-]+(.[a-zA-Z]{2,})+$')
        .hasMatch(email);
  }

  static bool isPwdValid(String pwd) {
    return RegExp(r'^([0-9A-Za-z#?!@$%^&*-]){6,18}$').hasMatch(pwd);
  }

  static bool isAadhaarValid(String aadhaar) {
    return RegExp(r'^[0-9]{12}$').hasMatch(aadhaar);
  }
}
