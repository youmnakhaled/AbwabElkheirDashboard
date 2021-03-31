import 'package:abwab_elkheir_dashboard/Services/UtilityFunctions.dart';
import 'package:abwab_elkheir_dashboard/Services/WebServices.dart';
import 'package:flutter/material.dart';

class AuthenticationViewModel with ChangeNotifier {
  String _accessToken;
  String get accessToken {
    return _accessToken;
  }

  Future<bool> signIn(
      String email, String password, BuildContext context) async {
    try {
      final Map<String, dynamic> results =
          await WebServices().signIn(email, password);
      print(results);
      _accessToken = results["accessToken"];
      return true;
    } catch (error) {
      UtilityFunctions.showErrorDialog(
          "An error occured", error.toString(), context);
      return false;
    }
  }

  Future<bool> signOut(BuildContext context) async {
    try {
      // await WebServices().signOut(_accessToken);
      return true;
    } catch (error) {
      // UtilityFunctions.showErrorDialog(
      //     "An error occured", error.toString(), context);
      return false;
    }
  }
}
