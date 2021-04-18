import 'package:abwab_elkheir_dashboard/Models/case_model.dart';
import 'package:abwab_elkheir_dashboard/ViewModels/AddCaseViewModel.dart';
import 'package:abwab_elkheir_dashboard/ViewModels/AuthenticationViewModel.dart';
import 'package:abwab_elkheir_dashboard/ViewModels/EditCaseViewModel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:abwab_elkheir_dashboard/Widgets/TextFieldWidget.dart';
import 'package:vrouter/vrouter.dart';
import '../../Models/case_model.dart';
import '../../Constants/ConstantColors.dart';
import 'package:abwab_elkheir_dashboard/ViewModels/CasesViewModel.dart';

class EditCaseScreenMobile extends StatefulWidget {
  final deviceSize;

  const EditCaseScreenMobile({Key key, this.deviceSize}) : super(key: key);
  @override
  _EditCaseScreenMobileState createState() => _EditCaseScreenMobileState();
}

class _EditCaseScreenMobileState extends State<EditCaseScreenMobile> {
  AuthenticationViewModel auth;
  EditCaseViewModel caseViewModel;
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _statusFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

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

  Case currentCase;
  Case editedCase;

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
        totalPrice: caseViewModel.editCaseTotalPriceController.text,
        status: caseViewModel.editCaseStatusController.text);

    caseViewModel.setCaseToEdit(editedCase);
    await caseViewModel.editCase(context, auth.accessToken);
    context.vRouter.pop();
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
                  labelText: 'عنوان الحالة',
                  textInputAction: TextInputAction.next,
                  onChanged: () {
                    caseViewModel.isChanged = true;
                  },
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
                  controller: caseViewModel.editCaseTotalPriceController,
                  textInputAction: TextInputAction.next,
                  textDirection: TextDirection.rtl,
                  inputType: TextInputType.number,
                  onChanged: () {
                    caseViewModel.isChanged = true;
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
                    if (int.tryParse(value) == null) {
                      return 'أدخل رقم صحيح لمبلغ الحالة ';
                    }
                    if (int.parse(value) <= 0) {
                      return 'يجب أن يكون المبلغ أكثر من صفر.';
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
                  width: deviceSize.width * 0.3 < 250
                      ? 250
                      : deviceSize.width * 0.3,
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
                        value:
                            caseViewModel.editCaseStatusController.text.isEmpty
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
                  textDirection: TextDirection.rtl,
                  inputType: TextInputType.multiline,
                  focusNode: _descriptionFocusNode,
                  onChanged: () {
                    caseViewModel.isChanged = true;
                  },
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
                      width: deviceSize.width * 0.3 < 250
                          ? 250
                          : deviceSize.width * 0.3,
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
                            ConstantColors.lightBlue)),
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
