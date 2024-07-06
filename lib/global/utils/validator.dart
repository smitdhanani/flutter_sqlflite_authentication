import 'package:get/get.dart';

class Validator {
  static String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Please Enter Your Email';
    } else if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid Email';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Please Enter Your Passowrd';
    } else if (value.length < 8) {
      return 'Password must be 8 Charcter';
    }
    return null;
  }
}
