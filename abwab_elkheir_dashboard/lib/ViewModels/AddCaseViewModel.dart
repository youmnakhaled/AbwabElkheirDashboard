// import '../Constants/Endpoints.dart';

import 'package:image_picker/image_picker.dart';

import '../Constants/ConstantColors.dart';
import '../Models/case_model.dart';
import '../Services/WebServices.dart';
import '../Services/UtilityFunctions.dart';
import 'package:flutter/material.dart';

class AddCaseViewModel with ChangeNotifier {
  Case caseToAdd;
  Case caseToEdit;
  Status status = Status.success;
  PickedFile imageToUpload;

  void setImageToUpload(PickedFile imageFile) {
    imageToUpload = imageFile;
  }

  void setCaseToAdd(Case caseToAdd) {
    this.caseToAdd = caseToAdd;
  }

  void setCaseToEdit(Case caseToEdit) {
    this.caseToEdit = caseToEdit;
  }

  get getImage {
    return imageToUpload;
  }

  Future<void> addImage(BuildContext context, String token) async {
    try {
      status = Status.loading;
      notifyListeners();
      Map<String, dynamic> results =
          await WebServices().getImagesUrls(imageToUpload, token);
      print(results);

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

  Future<void> addCase(BuildContext context, String token) async {
    try {
      status = Status.loading;
      notifyListeners();
      print('Adding');
      Map<String, dynamic> results = await WebServices().addCase(
          caseToAdd.title,
          caseToAdd.description,
          caseToAdd.totalPrice,
          [],
          true,
          caseToAdd.status,
          caseToAdd.category);
      print(results);

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

  Future<void> editCase(BuildContext context, String token) async {
    try {
      status = Status.loading;
      notifyListeners();
      print('Adding');
      Map<String, dynamic> results = await WebServices().editCase(
          caseToEdit.id,
          caseToEdit.title,
          caseToEdit.description,
          caseToEdit.totalPrice,
          caseToEdit.images,
          caseToEdit.isActive,
          caseToEdit.status,
          caseToEdit.category,
          token);
      print(results);

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
