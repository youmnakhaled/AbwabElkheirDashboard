import 'package:flutter/material.dart';

class ConstantColors {
  static Color purple = Color.fromRGBO(110, 64, 153, 1);
  static Color lightBlue = Color.fromRGBO(42, 192, 200, 1);
}

enum Status {
  loading,
  success,
  failed,
  empty,
}
