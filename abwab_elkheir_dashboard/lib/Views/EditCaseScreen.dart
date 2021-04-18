import 'package:abwab_elkheir_dashboard/Constants/ConstantColors.dart';
import 'package:abwab_elkheir_dashboard/Models/case_model.dart';
import 'package:abwab_elkheir_dashboard/ViewModels/AddCaseViewModel.dart';
import 'package:abwab_elkheir_dashboard/ViewModels/CasesViewModel.dart';
import 'package:abwab_elkheir_dashboard/ViewModels/EditCaseViewModel.dart';
import 'package:abwab_elkheir_dashboard/Views/Desktop/EditCaseScreenDesktop.dart';
import 'package:abwab_elkheir_dashboard/Views/Mobile/EditCaseScreenMobile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:vrouter/vrouter.dart';

class EditCaseScreen extends StatefulWidget {
  static final routeName = "/landingScreen";

  @override
  _EditCaseScreenState createState() => _EditCaseScreenState();
}

class _EditCaseScreenState extends State<EditCaseScreen> {
  TextEditingController notesController = TextEditingController();
  TextEditingController orderStatusController = TextEditingController();
  bool isFormChanged = false;
  Case currentCase;
  EditCaseViewModel caseViewModel;
  @override
  void initState() {
    // final id = context.vRouter.pathParameters['id'];
    // if (id != null) {
    //   currentCase =
    //       Provider.of<CasesViewModel>(context, listen: false).findById(id);
    //   caseViewModel = Provider.of<AddCaseViewModel>(context, listen: false);

    //   caseViewModel.editCaseTitleController.text = currentCase.title;
    //   caseViewModel.editCaseDescriptionController.text =
    //       currentCase.description;
    //   caseViewModel.editCaseTotalPriceController.text =
    //       currentCase.totalPrice.toString();
    //   caseViewModel.editCaseStatusController.text = currentCase.status;
    // }
    super.initState();
  }

  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final id = context.vRouter.pathParameters['id'];
      if (id != null) {
        currentCase =
            Provider.of<CasesViewModel>(context, listen: false).findById(id);
        caseViewModel = Provider.of<EditCaseViewModel>(context, listen: false);
        caseViewModel.currentCase = currentCase;
        caseViewModel.editCaseTitleController.text = currentCase.title;
        caseViewModel.editCaseDescriptionController.text =
            currentCase.description;
        caseViewModel.editCaseTotalPriceController.text =
            currentCase.totalPrice.toString();
        caseViewModel.editCaseStatusController.text = currentCase.status;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      print(sizingInformation);
      return Scaffold(
        backgroundColor: ConstantColors.purple,
        body: Container(
          height: deviceSize.height,
          child: ScreenTypeLayout(
            desktop: EditCaseScreenDesktop(deviceSize: deviceSize),
            tablet: EditCaseScreenDesktop(deviceSize: deviceSize),
            mobile: EditCaseScreenMobile(deviceSize: deviceSize),
          ),
        ),
      );
    });
  }
}
