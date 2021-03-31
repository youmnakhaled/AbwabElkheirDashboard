import 'package:abwab_elkheir_dashboard/Constants/ConstantColors.dart';
import 'package:abwab_elkheir_dashboard/Views/Desktop/ViewCasesScreenDesktop.dart';
import 'package:abwab_elkheir_dashboard/Views/Mobile/ViewCasesScreenMobile.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ViewCasesScreen extends StatefulWidget {
  static final routeName = "/landingScreen";

  @override
  _ViewCasesScreenState createState() => _ViewCasesScreenState();
}

class _ViewCasesScreenState extends State<ViewCasesScreen> {
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
            desktop: ViewCasesScreenDesktop(deviceSize: deviceSize),
            tablet: ViewCasesScreenDesktop(deviceSize: deviceSize),
            mobile: ViewCasesScreenMobile(deviceSize: deviceSize),
          ),
        ),
      );
    });
  }
}
