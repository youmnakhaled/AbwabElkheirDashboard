// import '../Constants/Endpoints.dart';
import '../Constants/ConstantColors.dart';
import '../Models/case_model.dart';
import '../Services/WebServices.dart';
import '../Services/UtilityFunctions.dart';
import 'package:flutter/material.dart';

class CasesViewModel with ChangeNotifier {
  List<Case> cases = [];
  Status status = Status.success;
  Future<void> fetchCases(BuildContext context) async {
    try {
      cases.clear();
      status = Status.loading;
      notifyListeners();
      Map<String, dynamic> results = await WebServices().fetchCases();
      print(results);
      if (results['statusCode'] == 200) {
        for (int i = 0; i < results['data'].length; i++) {
          cases.add(Case.fromJson(results['data'][i]));
        }
      }
      if (results['statusCode'] == 400) {
        UtilityFunctions.showErrorDialog(
            " خطأ",
            " حدث خطأ ما ، يرجى المحاولة مرة أخرى والتحقق من اتصالك بالإنترنت",
            context);
      }

      status = Status.success;
      notifyListeners();
    } catch (error) {
      return;
    }
  }
}
