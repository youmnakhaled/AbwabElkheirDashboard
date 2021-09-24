// import '../Constants/Endpoints.dart';
import '../Constants/ConstantColors.dart';
// import '../Models/setting_model.dart';
import '../Services/WebServices.dart';
import '../Services/UtilityFunctions.dart';
import 'package:flutter/material.dart';

class SettingViewModel with ChangeNotifier {
  Status status = Status.success;
  String youtubeLink;
  bool isChanged = false;
  // TextEditingController youtubeLinkController = TextEditingController();

  String get getYoutubeLink {
    return this.youtubeLink;
  }

  void setNewLink(String link) {
    this.youtubeLink = link;
    print('utube link set to');
    print(this.youtubeLink);
  }

  Future<void> getCurrentLink(BuildContext context, String token) async {
    try {
      status = Status.loading;
      notifyListeners();
      Map<String, dynamic> results = await WebServices().getYoutubeLink(token);
      print(results);
      if (results['statusCode'] == 200) {
        setNewLink(results['data']['link']);
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

  Future<void> editLink(BuildContext context, String token, String link) async {
    try {
      status = Status.loading;
      notifyListeners();
      print('Editing Link');
      print(link);
      Map<String, dynamic> results =
          await WebServices().editYoutubeLink(link, token);
      print(results);
      if (results['statusCode'] == 400) {
        UtilityFunctions.showErrorDialog(
            " خطأ",
            " حدث خطأ ما ، يرجى المحاولة مرة أخرى والتحقق من اتصالك بالإنترنت",
            context);
      }

      print(results['statusCode']);
      if (results['statusCode'] == 200) {
        UtilityFunctions.showErrorDialog(
            " تم التعديل ", "تم التعديل  بنجاح", context);
        //youtubeLinkController.clear();
        print("status 200");
        // print(link);
        setNewLink(link);
        isChanged = false;
      }

      status = Status.success;

      notifyListeners();
    } catch (error) {
      return;
    }
  }
}
