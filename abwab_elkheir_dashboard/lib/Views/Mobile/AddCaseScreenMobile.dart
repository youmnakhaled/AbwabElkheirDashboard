import 'package:abwab_elkheir_dashboard/ViewModels/AddCaseViewModel.dart';
import 'package:abwab_elkheir_dashboard/ViewModels/AuthenticationViewModel.dart';

import 'package:flutter/material.dart';
import 'package:abwab_elkheir_dashboard/Models/case_model.dart';

// import 'package:flutter_web_image_picker/flutter_web_image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:abwab_elkheir_dashboard/Widgets/TextFieldWidget.dart';

import '../../Constants/ConstantColors.dart';

class AddCaseScreenMobile extends StatefulWidget {
  final deviceSize;

  const AddCaseScreenMobile({Key key, this.deviceSize}) : super(key: key);
  @override
  _AddCaseScreenMobileState createState() => _AddCaseScreenMobileState();
}

class _AddCaseScreenMobileState extends State<AddCaseScreenMobile> {
  AuthenticationViewModel auth;
  AddCaseViewModel caseViewModel;

  bool isLoading = false;

  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _statusFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  @override
  void initState() {
    auth = Provider.of<AuthenticationViewModel>(context, listen: false);
    caseViewModel = Provider.of<AddCaseViewModel>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _statusFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  Future chooseImage() async {
    final _picker = ImagePicker();
    PickedFile image = await _picker.getImage(source: ImageSource.gallery);
    caseViewModel.setImageToUpload(image);
    await caseViewModel.addImage(context, auth.accessToken);
    setState(() {
      print('Image Selected:' + image.path);
    });
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();

    if (!isValid) {
      return;
    }

    _form.currentState.save();
    Case caseToAdd = Case(
      title: caseViewModel.addCaseTitleController.text,
      description: caseViewModel.addCaseDescriptionController.text,
      status: caseViewModel.addCaseStatusController.text,
      images: ['7d77a888-ab0b-4944-b7b4-13f1f4267c88.jpg'],
      isActive: true,
      totalPrice: caseViewModel.addCaseTotalPriceController.text,
    );

    caseViewModel.setCaseToAdd(caseToAdd);
    caseViewModel.addCase(context, auth.accessToken);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = widget.deviceSize;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(""),
        backgroundColor: ConstantColors.lightBlue,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFieldWidget(
                controller: caseViewModel.addCaseTitleController,
                deviceSize: deviceSize,
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
                controller: caseViewModel.addCaseTotalPriceController,
                textInputAction: TextInputAction.next,
                textDirection: TextDirection.rtl,
                inputType: TextInputType.number,
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
                  if (value == "0" || value == "٠") {
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
                width:
                    deviceSize.width * 0.3 < 250 ? 250 : deviceSize.width * 0.3,
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
                      value: caseViewModel.addCaseStatusController.text.isEmpty
                          ? null
                          : caseViewModel.addCaseStatusController.text,
                      items: <DropdownMenuItem>[
                        DropdownMenuItem(
                          value: "في البداية",
                          child: Text("في البداية"),
                        ),
                        DropdownMenuItem(
                          value: "قارب على الانتهاء",
                          child: Text("قارب على الانتهاء"),
                        ),
                        DropdownMenuItem(
                          value: "جاري التجميع",
                          child: Text("جاري التجميع"),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          caseViewModel.addCaseStatusController.text = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
              TextFieldWidget(
                // initialValue: initValues['description'],
                controller: caseViewModel.addCaseDescriptionController,
                deviceSize: deviceSize,
                labelText: 'التفاصيل',
                maxLines: 14,
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
              Container(
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
                  height: 200,
                  child: caseViewModel.getImage == null
                      ? Image.asset('assets/placeholder.png')
                      : Image.network(caseViewModel.getImage.path)
                  // : Image.file(
                  //     imageSelected,
                  //     // fit: BoxFit.contain,
                  //   ),
                  ),
              Container(
                width:
                    deviceSize.width * 0.3 < 250 ? 250 : deviceSize.width * 0.3,
                margin: EdgeInsets.all(deviceSize.height * 0.01),
                child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextButton.icon(
                      onPressed: chooseImage,
                      icon: Icon(Icons.upload_rounded),
                      label: Text(
                        'اختار صورة للحالة',
                        style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline),
                      ),
                    )),
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
                      backgroundColor:
                          MaterialStateProperty.all(ConstantColors.lightBlue)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
