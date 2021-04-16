import 'package:abwab_elkheir_dashboard/Constants/ConstantColors.dart';
import 'package:abwab_elkheir_dashboard/Views/Desktop/EditCaseScreenDesktop.dart';
import 'package:abwab_elkheir_dashboard/Views/Mobile/EditCaseScreenMobile.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class EditCaseScreen extends StatefulWidget {
  static final routeName = "/landingScreen";

  @override
  _EditCaseScreenState createState() => _EditCaseScreenState();
}

class _EditCaseScreenState extends State<EditCaseScreen> {
  TextEditingController notesController = TextEditingController();
  TextEditingController orderStatusController = TextEditingController();
  bool isFormChanged = false;
  @override
  void initState() {
    super.initState();
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
