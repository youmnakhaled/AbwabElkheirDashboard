import 'dart:html';

import 'package:abwab_elkheir_dashboard/Models/case_model.dart';
import 'package:abwab_elkheir_dashboard/Services/UtilityFunctions.dart';
import 'package:abwab_elkheir_dashboard/ViewModels/AuthenticationViewModel.dart';
import 'package:abwab_elkheir_dashboard/ViewModels/EditCaseViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:abwab_elkheir_dashboard/Widgets/TextFieldWidget.dart';
import 'package:vrouter/vrouter.dart';
import '../../Models/case_model.dart';
import '../../Constants/ConstantColors.dart';

class EditCaseScreenDesktop extends StatefulWidget {
  final deviceSize;

  const EditCaseScreenDesktop({Key key, this.deviceSize}) : super(key: key);
  @override
  _EditCaseScreenDesktopState createState() => _EditCaseScreenDesktopState();
}

class _EditCaseScreenDesktopState extends State<EditCaseScreenDesktop> {
  AuthenticationViewModel auth;
  EditCaseViewModel caseViewModel;
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _statusFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  Case currentCase;
  Case editedCase;

  bool isLoading = false;
  @override
  void initState() {
    auth = Provider.of<AuthenticationViewModel>(context, listen: false);
    caseViewModel = Provider.of<EditCaseViewModel>(context, listen: false);
    currentCase = caseViewModel.currentCase;
    super.initState();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _statusFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  void _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();

    Case editedCase = Case(
        description: caseViewModel.editCaseDescriptionController.text,
        images: currentCase.images,
        isActive: currentCase.isActive,
        category: currentCase.category,
        id: currentCase.id,
        title: caseViewModel.editCaseTitleController.text,
        totalPrice: caseViewModel.editCaseTotalPrice,
        status: caseViewModel.editCaseStatusController.text);

    caseViewModel.setCaseToEdit(editedCase);
    await caseViewModel.editCase(context, auth.accessToken);
    // context.vRouter.pop();
    window.history.back();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = widget.deviceSize;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(""),
        backgroundColor: ConstantColors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFieldWidget(
                  controller: caseViewModel.editCaseTitleController,
                  isEnabled: false,
                  deviceSize: deviceSize,
                  onChanged: (value) {
                    setState(() {
                      caseViewModel.isChanged = true;
                    });
                  },
                  labelText: 'عنوان الحالة',
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'أدخل عنوان الحالة';
                    }
                    return null;
                  },
                  textDirection: TextDirection.rtl,
                  onSaved: (value) {},
                ),
                TextFieldWidget(
                  // controller: caseViewModel.editCaseTotalPriceController,
                  initialValue: caseViewModel.editCaseTotalPrice.toString(),
                  textInputAction: TextInputAction.next,
                  textDirection: TextDirection.rtl,
                  inputType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      String engAmount = UtilityFunctions.convertNumberToEnglish(value);
                      caseViewModel.editCaseTotalPrice = int.parse(engAmount);
                      caseViewModel.isChanged = true;
                    });
                  },
                  deviceSize: deviceSize,
                  labelText: ' المبلغ المطلوب',
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'أدخل المبلغ المطلوب للحالة';
                    }

                    RegExp regExp = RegExp(r"^[٠-٩]+|^[0-9]+$");
                    bool matches = regExp.hasMatch(value);
                    if (!matches) {
                      return 'أدخل رقم صحيح لمبلغ الحالة ';
                    }
                    // if (value == "0" || value == "٠") {
                    //   return 'يجب أن يكون المبلغ أكثر من صفر.';
                    // }
                    value = UtilityFunctions.convertNumberToEnglish(value);
                    if (value == "0") {
                      return 'يجب أن يكون المبلغ أكثر من صفر.';
                    }
                    if (int.tryParse(value) == null) {
                      return 'يجب أن يكون المبلغ رقم صحيح .';
                    }
                    return null;
                  },
                  onSaved: (value) {},
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  width: deviceSize.width * 0.3 < 250 ? 250 : deviceSize.width * 0.3,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        onTap: () {
                          FocusScope.of(context).requestFocus(_statusFocusNode);
                        },
                        isExpanded: true,
                        elevation: 10,
                        hint: Text(" درجة الحالة"),
                        value: caseViewModel.editCaseStatusController.text.isEmpty
                            ? null
                            : caseViewModel.editCaseStatusController.text,
                        items: <DropdownMenuItem>[
                          DropdownMenuItem(
                            value: 'في البداية',
                            child: Text('في البداية'),
                          ),
                          DropdownMenuItem(
                            value: 'قارب على الانتهاء',
                            child: Text('قارب على الانتهاء'),
                          ),
                          DropdownMenuItem(
                            value: 'جاري التجميع',
                            child: Text('جاري التجميع'),
                          ),
                          DropdownMenuItem(
                            value: "تم",
                            child: Text("تم"),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            caseViewModel.editCaseStatusController.text = value;
                            caseViewModel.isChanged = true;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                TextFieldWidget(
                  controller: caseViewModel.editCaseDescriptionController,
                  deviceSize: deviceSize,
                  labelText: 'التفاصيل',
                  maxLines: 14,
                  onChanged: (value) {
                    setState(() {
                      // caseViewModel.editCaseDescriptionController = value;
                      caseViewModel.isChanged = true;
                    });
                  },
                  textDirection: TextDirection.rtl,
                  inputType: TextInputType.multiline,
                  focusNode: _descriptionFocusNode,
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'أدخل تفاصيل الحالة';
                    }
                    return null;
                  },
                  onSaved: (value) {},
                ),
                SizedBox(
                  height: 50,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: deviceSize.width * 0.3 < 250 ? 250 : deviceSize.width * 0.3,
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: currentCase.images[0] == null
                          ? Image.asset('assets/placeholder.png')
                          : Image.network(currentCase.images[0]),
                    ),
                    // Container(
                    //   width: deviceSize.width * 0.3 < 250
                    //       ? 250
                    //       : deviceSize.width * 0.3,
                    //   margin: EdgeInsets.all(deviceSize.height * 0.01),
                    //   child: Theme(
                    //     data: ThemeData(primaryColor: Colors.black26),
                    //     child: Directionality(
                    //         textDirection: TextDirection.rtl,
                    //         child: TextButton.icon(
                    //           onPressed: chooseImage,
                    //           icon: Icon(Icons.upload_rounded),
                    //           label: Text(
                    //             'اختار صورة للحالة',
                    //             style: TextStyle(
                    //                 color: Colors.blue,
                    //                 decoration: TextDecoration.underline),
                    //           ),
                    //         )),
                    //   ),
                    // ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 50, 0, 50),
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {
                      _saveForm();
                    },
                    child: Text('حفظ'),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            caseViewModel.isChanged ? ConstantColors.lightBlue : Colors.grey)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
