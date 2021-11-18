import '../Constants/ConstantColors.dart';
import '../Models/hasad_model.dart';
import '../Services/WebServices.dart';
import '../Services/UtilityFunctions.dart';
import 'package:flutter/material.dart';

class AddHasadViewModel with ChangeNotifier {
  Hasad hasadToAdd;

  Status status = Status.success;

  TextEditingController addHasadTitleController = TextEditingController();
  TextEditingController addHasadLinkController = TextEditingController();

  void setHasadToAdd(Hasad hasadToAdd) {
    this.hasadToAdd = hasadToAdd;
  }

  Future<void> addHasad(BuildContext context, String token) async {
    try {
      status = Status.loading;
      notifyListeners();
      print('Adding Hasad');

      Map<String, dynamic> results = await WebServices()
          .addHasad(hasadToAdd.title, hasadToAdd.link, token);
      print(results);

      if (results['statusCode'] == 400) {
        UtilityFunctions.showErrorDialog(
            " خطأ",
            " حدث خطأ ما ، يرجى المحاولة مرة أخرى والتحقق من اتصالك بالإنترنت",
            context);
      }

      print(results['statusCode']);
      if (results['statusCode'] == 201) {
        UtilityFunctions.showErrorDialog(
            " تم الاضافة ", "تم اضافة الحصاد بنجاح", context);

        addHasadTitleController.clear();
        addHasadLinkController.clear();
        hasadToAdd = null;
      }

      status = Status.success;
      notifyListeners();
    } catch (error) {
      return;
    }
  }
}
