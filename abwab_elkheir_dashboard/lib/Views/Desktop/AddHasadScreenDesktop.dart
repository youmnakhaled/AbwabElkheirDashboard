import 'package:abwab_elkheir_dashboard/Models/case_model.dart';
import 'package:abwab_elkheir_dashboard/ViewModels/AuthenticationViewModel.dart';
import 'package:abwab_elkheir_dashboard/ViewModels/EditCaseViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:abwab_elkheir_dashboard/Widgets/TextFieldWidget.dart';
import 'package:vrouter/vrouter.dart';
import '../../Models/case_model.dart';
import '../../Constants/ConstantColors.dart';

class AddHasadScreenDesktop extends StatefulWidget {
  final deviceSize;

  const AddHasadScreenDesktop({Key key, this.deviceSize}) : super(key: key);
  @override
  _AddHasadScreenDesktopState createState() => _AddHasadScreenDesktopState();
}

class _AddHasadScreenDesktopState extends State<AddHasadScreenDesktop> {
  AuthenticationViewModel auth;
  EditCaseViewModel caseViewModel;
  final _linkFocusNode = FocusNode();
  final _titleFocusNode = FocusNode();
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
    _linkFocusNode.dispose();
    _titleFocusNode.dispose();
    super.dispose();
  }

  void _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();

    // Case editedCase = Case(
    //     description: caseViewModel.editCaseDescriptionController.text,
    //     images: currentCase.images,
    //     isActive: currentCase.isActive,
    //     category: currentCase.category,
    //     id: currentCase.id,
    //     title: caseViewModel.editCaseTitleController.text,
    //     totalPrice: caseViewModel.editCaseTotalPrice,
    //     status: caseViewModel.editCaseStatusController.text);

    // caseViewModel.setCaseToEdit(editedCase);
    // await caseViewModel.editCase(context, auth.accessToken);
    context.vRouter.pop();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = widget.deviceSize;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(" اضافة حصاد جديد"),
        backgroundColor: ConstantColors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                TextFieldWidget(
                  width: deviceSize.width * 0.8,
                  // controller: caseViewModel.editCaseTitleController,
                  isEnabled: true,
                  maxLines: 1,
                  deviceSize: deviceSize,
                  onChanged: (value) {
                    setState(() {
                      caseViewModel.isChanged = true;
                    });
                  },
                  labelText: ' عنوان الحصاد',
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_titleFocusNode);
                  },
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'أدخل عنوان الحصاد الجديد';
                    }
                    return null;
                  },
                  textDirection: TextDirection.ltr,
                  onSaved: (value) {},
                ),
                TextFieldWidget(
                  width: deviceSize.width * 0.8,
                  // controller: caseViewModel.editCaseTitleController,
                  isEnabled: true,
                  maxLines: 1,
                  deviceSize: deviceSize,
                  onChanged: (value) {
                    setState(() {
                      caseViewModel.isChanged = true;
                    });
                  },
                  labelText: 'لينك الحصاد',
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_linkFocusNode);
                  },
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'أدخل لينك الحصاد';
                    }
                    bool _validURL = Uri.parse(value).isAbsolute;
                    if (!_validURL) {
                      return ' (youtube) أدخل لينك صحيح الفيديو';
                    }
                    return null;
                  },
                  textDirection: TextDirection.ltr,
                  onSaved: (value) {},
                ),
                SizedBox(
                  height: 50,
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
                            caseViewModel.isChanged
                                ? ConstantColors.lightBlue
                                : Colors.grey)),
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
