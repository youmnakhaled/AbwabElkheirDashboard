import 'package:abwab_elkheir_dashboard/Constants/ConstantColors.dart';
import 'package:flutter/material.dart';

class UtilityFunctions {
  static List<String> parseString(stringJson) {
    List<String> stringList = new List<String>.from(stringJson);
    return stringList;
  }

  static void showErrorDialog(
      String title, String message, BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
                primary: ConstantColors.purple,
                textStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                )),
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }
}
