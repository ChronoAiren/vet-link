// matching various patterns for kinds of data
import 'package:get/get.dart';

class Validator {
  Validator();

  String? email(String? value) {
    const pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    final regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'This is not a valid email';
    } else {
      return null;
    }
  }

  String? number(String? value) {
    if (value == null) {
      return null;
    }
    bool isNum = double.tryParse(value) != null;
    if (!isNum) {
      return 'This is not a number';
    }
    return null;
  }

  String? notEmpty(String? value) {
    if (value == '') {
      return 'This is a required field';
    } else {
      return null;
    }
  }
}
