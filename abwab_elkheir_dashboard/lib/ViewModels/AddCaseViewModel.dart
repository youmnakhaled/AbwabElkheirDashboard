// import '../Constants/Endpoints.dart';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import '../Constants/ConstantColors.dart';
import '../Models/case_model.dart';
import '../Services/WebServices.dart';
import '../Services/UtilityFunctions.dart';
import 'package:flutter/material.dart';

class AddCaseViewModel with ChangeNotifier {
  Case caseToAdd;

  Status status = Status.success;
  XFile imageToUpload;

  TextEditingController addCaseTitleController = TextEditingController();
  TextEditingController addCaseDescriptionController = TextEditingController();
  int addCaseTotalPrice;
  TextEditingController addCaseStatusController = TextEditingController();

  void setImageToUpload(XFile imageFile) {
    imageToUpload = imageFile;
  }

  void setCaseToAdd(Case caseToAdd) {
    this.caseToAdd = caseToAdd;
  }

  get getImage {
    return imageToUpload;
  }

  // Future<void> addImage(BuildContext context, String token) async {
  //   try {
  //     status = Status.loading;
  //     notifyListeners();
  //     Map<String, dynamic> results =
  //         await WebServices().getImagesUrls(imageToUpload, token);
  //     print(results);

  //     if (results['statusCode'] == 400) {
  //       UtilityFunctions.showErrorDialog(
  //           " خطأ",
  //           " حدث خطأ ما ، يرجى المحاولة مرة أخرى والتحقق من اتصالك بالإنترنت",
  //           context);
  //     }

  //     status = Status.success;
  //     notifyListeners();
  //   } catch (error) {
  //     return;
  //   }
  // }

  Future<void> addCase(BuildContext context, String token) async {
    try {
      status = Status.loading;
      notifyListeners();
      print('Adding');

      //Upload Images to AWS
      if (imageToUpload != null) {
        List<dynamic> imageUrls =
            await WebServices().getImagesUrls(imageToUpload, token);

        final fields = imageUrls[0]['fields'];
        fields['file'] = await MultipartFile.fromBytes(
          await imageToUpload.readAsBytes(),
          filename: imageToUpload.name,
        );
        await WebServices().uploadImage(imageUrls[0]['url'], fields);
        caseToAdd.images.add(imageUrls[0]['fields']['key']);
        print(caseToAdd.images);
      } else {
        //Default image if image not added
        caseToAdd.images.add('default-case-photo/logo.png');
      }

      Map<String, dynamic> results = await WebServices().addCase(
          caseToAdd.title,
          caseToAdd.description,
          caseToAdd.totalPrice,
          caseToAdd.images,
          true,
          caseToAdd.status,
          token);
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
            " تم الاضافة ", "تم اضافة الحالة بنجاح", context);

        addCaseTitleController.clear();
        addCaseDescriptionController.clear();
        addCaseStatusController.clear();
        caseToAdd = null;
      }

      status = Status.success;
      notifyListeners();
    } catch (error) {
      return;
    }
  }
}
