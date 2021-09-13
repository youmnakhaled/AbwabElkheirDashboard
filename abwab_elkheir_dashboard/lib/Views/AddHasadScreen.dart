import 'package:abwab_elkheir_dashboard/Constants/ConstantColors.dart';
import 'package:abwab_elkheir_dashboard/Models/case_model.dart';
import 'package:abwab_elkheir_dashboard/ViewModels/EditCaseViewModel.dart';
import 'package:abwab_elkheir_dashboard/Views/Desktop/AddHasadScreenDesktop.dart';
import 'package:abwab_elkheir_dashboard/Views/Mobile/AddHasadScreenMobile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:vrouter/vrouter.dart';

class AddHasadScreen extends StatefulWidget {
  static final routeName = "/AddHasad";

  @override
  _AddHasadScreen createState() => _AddHasadScreen();
}

class _AddHasadScreen extends State<AddHasadScreen> {
  TextEditingController notesController = TextEditingController();
  TextEditingController orderStatusController = TextEditingController();
  bool isFormChanged = false;
  Case currentCase;
  EditCaseViewModel caseViewModel;
  @override
  void initState() {
    super.initState();
  }

  var _isInit = true;

  // @override
  // void didChangeDependencies() {
  //   if (_isInit) {
  //     final id = context.vRouter.pathParameters['id'];
  //     if (id != null) {
  //       currentCase =
  //           Provider.of<CasesViewModel>(context, listen: false).findById(id);
  //       caseViewModel = Provider.of<EditCaseViewModel>(context, listen: false);
  //       caseViewModel.currentCase = currentCase;
  //       caseViewModel.editCaseTitleController.text = currentCase.title;
  //       caseViewModel.editCaseDescriptionController.text =
  //           currentCase.description;
  //       caseViewModel.editCaseTotalPrice = currentCase.totalPrice;
  //       caseViewModel.editCaseStatusController.text = currentCase.status;
  //     }
  //   }
  //   _isInit = false;
  //   super.didChangeDependencies();
  // }

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
            desktop: AddHasadScreenDesktop(deviceSize: deviceSize),
            tablet: AddHasadScreenDesktop(deviceSize: deviceSize),
            mobile: AddHasadScreenMobile(deviceSize: deviceSize),
          ),
        ),
      );
    });
  }
}
