import 'package:abwab_elkheir_dashboard/Constants/ConstantColors.dart';
import 'package:abwab_elkheir_dashboard/Views/Desktop/AddCaseScreenDesktop.dart';
import 'package:abwab_elkheir_dashboard/Views/Mobile/AddCaseScreenMobile.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AddCaseScreen extends StatefulWidget {
  static final routeName = "/addCase";

  @override
  _AddCaseScreenState createState() => _AddCaseScreenState();
}

class _AddCaseScreenState extends State<AddCaseScreen> {
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
            desktop: AddCaseScreenDesktop(deviceSize: deviceSize),
            tablet: AddCaseScreenDesktop(deviceSize: deviceSize),
            mobile: AddCaseScreenMobile(deviceSize: deviceSize),
          ),
        ),
      );
    });
  }
}
