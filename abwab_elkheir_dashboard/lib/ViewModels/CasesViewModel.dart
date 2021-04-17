// import '../Constants/Endpoints.dart';
import '../Constants/ConstantColors.dart';
import '../Models/case_model.dart';
import '../Services/WebServices.dart';
import '../Services/UtilityFunctions.dart';
import 'package:flutter/material.dart';

class CasesViewModel with ChangeNotifier {
  List<Case> cases = [];
  Status status = Status.success;
  String startDate;
  String endDate;
  String casesStatus;

  String get getStartDate {
    return startDate;
  }

  String get getEndDate {
    return endDate;
  }

  Case findById(String id) {
    return cases.firstWhere((current) => current.id == id);
  }

  String get getCasesStatus {
    return casesStatus;
  }

  void setStartDate(String startDate) {
    this.startDate = startDate;
  }

  void setEndDate(String endDate) {
    this.endDate = endDate;
  }

  void setStatus(String status) {
    this.casesStatus = status;
  }

  Future<void> fetchCases(BuildContext context) async {
    try {
      cases.clear();
      status = Status.loading;
      notifyListeners();
      Map<String, dynamic> results =
          await WebServices().fetchCases(casesStatus, startDate, endDate);
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
