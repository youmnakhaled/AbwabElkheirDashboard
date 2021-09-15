import 'package:abwab_elkheir_dashboard/Constants/ConstantColors.dart';
import 'package:flutter/material.dart';

class UtilityFunctions {
  static List<String> parseString(stringJson) {
    List<String> stringList = new List<String>.from(stringJson);
    return stringList;
  }

  static String convertNumberToEnglish(number) {
    String replace1 = number.replaceAll('٠', '0');
    String replace2 = replace1.replaceAll('١', '1');
    String replace3 = replace2.replaceAll('٢', '2');
    String replace4 = replace3.replaceAll('٣', '3');
    String replace5 = replace4.replaceAll('٤', '4');
    String replace6 = replace5.replaceAll('٥', '5');
    String replace7 = replace6.replaceAll('٦', '6');
    String replace8 = replace7.replaceAll('٧', '7');
    String replace9 = replace8.replaceAll('٨', '8');
    String replace10 = replace9.replaceAll('٩', '9');
    return replace10;
  }

  static void showErrorDialog(
      String title, String message, BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          title,
          textAlign: TextAlign.left,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              message,
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
              style: TextButton.styleFrom(
                  primary: ConstantColors.purple,
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  )),
              child: Text('close'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
        actions: <Widget>[],
      ),
    );
  }
}
